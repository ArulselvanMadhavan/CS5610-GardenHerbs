using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using edu.neu.ccis.rasala;

public class Features
{
    public int forecast10day { get; set; }
}

public class Response
{
    public string version { get; set; }
    public string termsofService { get; set; }
    public Features features { get; set; }
}

public class Forecastday
{
    public int period { get; set; }
    public string icon { get; set; }
    public string icon_url { get; set; }
    public string title { get; set; }
    public string fcttext { get; set; }
    public string fcttext_metric { get; set; }
    public string pop { get; set; }
}

public class TxtForecast
{
    public string date { get; set; }
    public List<Forecastday> forecastday { get; set; }
}

public class Date
{
    public string epoch { get; set; }
    public string pretty { get; set; }
    public int day { get; set; }
    public int month { get; set; }
    public int year { get; set; }
    public int yday { get; set; }
    public int hour { get; set; }
    public string min { get; set; }
    public int sec { get; set; }
    public string isdst { get; set; }
    public string monthname { get; set; }
    public string monthname_short { get; set; }
    public string weekday_short { get; set; }
    public string weekday { get; set; }
    public string ampm { get; set; }
    public string tz_short { get; set; }
    public string tz_long { get; set; }
}

public class High
{
    public string fahrenheit { get; set; }
    public string celsius { get; set; }
}

public class Low
{
    public string fahrenheit { get; set; }
    public string celsius { get; set; }
}

public class QpfAllday
{
    public object @in { get; set; }
    public object mm { get; set; }
}

public class QpfDay
{
    public object @in { get; set; }
    public object mm { get; set; }
}

public class QpfNight
{
    public object @in { get; set; }
    public object mm { get; set; }
}

public class SnowAllday
{
    public object @in { get; set; }
    public object cm { get; set; }
}

public class SnowDay
{
    public object @in { get; set; }
    public object cm { get; set; }
}

public class SnowNight
{
    public object @in { get; set; }
    public object cm { get; set; }
}

public class Maxwind
{
    public int mph { get; set; }
    public int kph { get; set; }
    public string dir { get; set; }
    public int degrees { get; set; }
}

public class Avewind
{
    public int mph { get; set; }
    public int kph { get; set; }
    public string dir { get; set; }
    public int degrees { get; set; }
}

public class Forecastday2
{
    public Date date { get; set; }
    public int period { get; set; }
    public High high { get; set; }
    public Low low { get; set; }
    public string conditions { get; set; }
    public string icon { get; set; }
    public string icon_url { get; set; }
    public string skyicon { get; set; }
    public int pop { get; set; }
    public QpfAllday qpf_allday { get; set; }
    public QpfDay qpf_day { get; set; }
    public QpfNight qpf_night { get; set; }
    public SnowAllday snow_allday { get; set; }
    public SnowDay snow_day { get; set; }
    public SnowNight snow_night { get; set; }
    public Maxwind maxwind { get; set; }
    public Avewind avewind { get; set; }
    public int avehumidity { get; set; }
    public int maxhumidity { get; set; }
    public int minhumidity { get; set; }
}

public class Simpleforecast
{
    public List<Forecastday2> forecastday { get; set; }
}

public class Forecast
{
    public TxtForecast txt_forecast { get; set; }
    public Simpleforecast simpleforecast { get; set; }
}

public class RootObject
{
    public Response response { get; set; }
    public Forecast forecast { get; set; }
}

public partial class Project_weatherForecast : System.Web.UI.Page
{
    //static string xmlResponse;
    DataSet RunDS = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnWeatherForecast_Click(object sender, EventArgs e)
    {

        string w_key = KeyTools.GetKey(this, "weather");
        //string locationsResponse = null;
        try
        {
            string locationsRequest = CreateRequest("Boston", w_key);
            //XmlDocument locationsResponse = makeAPIRequest(locationsRequest);
            ProcessResponse(locationsRequest);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            Console.Read();
        }
    }
    public static string CreateRequest(string queryString, string w_key)
    {

        string UrlRequest = " http://api.worldweatheronline.com/free/v1/weather.ashx?key=" + w_key + "&q=boston&num_of_days=5&format=xml";
        return (UrlRequest);
    }
    public static XmlDocument makeAPIRequest(string requestUrl)
    {  try
            {
                HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(response.GetResponseStream());
                return (xmlDoc);

            }
            //// Initialise a WebClient to create a request.
            //System.Net.WebClient wc = new System.Net.WebClient();
            //// Force the API to return the data in XML format
            //wc.Headers["Accept"] = "application/xml";
            //xmlResponse = wc.DownloadString(apiURL);


            //// Remove the <response></response> element from the result to avoid extra spaces in the result
            //xmlResponse = xmlResponse.Replace("<response>", " ");
            //xmlResponse = xmlResponse.Replace("</response>", "");

        catch
        {
            //errorMsg.InnerText = "Sorry! An error occured while loading the page!";
            //errorMsg.Visible = true;
            return null;
        }

    }

    public void ProcessResponse(string URLRequest)
    {

        DataSet RunDS = new DataSet();
        DataTable dt = new DataTable("weatherForecastTable");
        dt.Columns.Add("Date");
        dt.Columns.Add("tempMaxC");
        dt.Columns.Add("windspeedMiles");
        dt.Columns.Add("Wind Direction");
        dt.Columns.Add("Wind Direction Degree");
        dt.Columns.Add("Precip MM");

        XDocument doc = XDocument.Load(URLRequest);
        //var query = (from x in xDoc.Descendants("quiz").Elements("problem")
        //                select new Question
        //                {
        //                    question = x.Element("question").Value,
        //                    answerA = x.Element("answerA").Value,
        //                    answerB = x.Element("answerB").Value,
        //                    answerC = x.Element("answerC").Value,
        //                    answerD = x.Element("answerD").Value,
        //                    correct = x.Element("correct").Value
        //                }).ToList();
        foreach (XElement weather in doc.Descendants("data").Elements("weather"))
        {
            DataRow dr = dt.NewRow();
            dr["Date"] = weather.Element("date").Value;
            dr["tempMaxC"] = weather.Element("tempMaxC").Value;
            dr["windspeedMiles"] = weather.Element("windspeedMiles").Value;
            dr["Wind Direction"] = weather.Element("winddirection").Value;
            dr["Wind Direction Degree"] = weather.Element("winddirDegree").Value;
            dr["Precip MM"] = weather.Element("precipMM").Value;
            dt.Rows.Add(dr);
        }
        RunDS.Tables.Add(dt);
        g_forecastResults.DataSource = RunDS;
        g_forecastResults.DataBind();
        g_forecastResults.Visible = true;
    }
        

    //protected void btnWeatherForecast_Click(object sender, EventArgs e)
    //{
    //            string w_key = "f52b7bd6ecbb16f0";
    //     string locationsResponse=null;
    //            try
    //            {
    //                string locationsRequest = CreateRequest("Boston", w_key);
    //                locationsResponse  = MakeRequest(locationsRequest);
    //                //ProcessResponse(locationsResponse);
    //            }
    //            catch (Exception ex)
    //        {
    //            Console.WriteLine(ex.Message);
    //            Console.Read();
    //        }

    //            JavaScriptSerializer serializer = new JavaScriptSerializer();
    //            Dictionary<String, Object> dict = new System.Collections.Generic.Dictionary<string, object>();
    //            dict = serializer.Deserialize<Dictionary<string, object>>(locationsResponse);
    //            dict[key]        

    //            //dynamic item = serializer.Deserialize<object>(locationsResponse);
    //            //ArrayList forecast = item["forecast"];

    //    //JavaScriptSerializer ser = new JavaScriptSerializer();
    //    //Features res = ser.Deserialize<Features>(locationsResponse);
        
   
        
    //    //dict = ser.Deserialize<Dictionary<string, object>>(locationsResponse);
    //}

    //public static string CreateRequest(string queryString,string w_key)
    //{
    //    string UrlRequest = "http://api.wunderground.com/api/" + w_key + "/forecast10day/q/" + "MA/" + "Boston.json";
    //    return (UrlRequest);
    //}

    //public static string MakeRequest(string requestUrl)
    //{
    //    try
    //    {
    //        HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
    //        using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
    //        {
    //            if (response.StatusCode != HttpStatusCode.OK)
    //                throw new Exception(String.Format(
    //                "Server error (HTTP {0}: {1}).",
    //                response.StatusCode,
    //                response.StatusDescription));
    //            Stream stream = response.GetResponseStream();
    //            StreamReader sr = new StreamReader(stream);
    //            //Response jsonResponse = objResponse as Response;
    //            var temp = sr.ReadToEnd();
    //            return temp;
    //        }
    //    }
    //    catch (Exception e)
    //    {
    //        Console.WriteLine(e.Message);
    //        return null;
    //    }

    //}

    ////public static bool displayForecastResults(Features res)
    ////{
    ////    bool bSuccess = false;

    ////    foreach (Forecastday strKey in res.forecast10day.)
    ////    {
    ////        string strOutput = "".PadLeft(indentLevel * 8) + strKey + ":";
    ////        tbOutput.AppendText("\r\n" + strOutput);

    ////        object o = dict[strKey];
    ////        if (o is Dictionary)
    ////        {
    ////            DisplayDictionary((Dictionary)o);
    ////        }
    ////        else if (o is ArrayList)
    ////        {
    ////            foreach (object oChild in ((ArrayList)o))
    ////            {
    ////                if (oChild is string)
    ////                {
    ////                    strOutput = ((string)oChild);
    ////                    tbOutput.AppendText(strOutput + ",");
    ////                }
    ////                else if (oChild is Dictionary)
    ////                {
    ////                    DisplayDictionary((Dictionary)oChild);
    ////                    tbOutput.AppendText("\r\n");
    ////                }
    ////            }
    ////        }
    ////        else
    ////        {
    ////            strOutput = o.ToString();
    ////            tbOutput.AppendText(strOutput);
    ////        }
    ////    }

    ////    indentLevel--;

    ////    return bSuccess;
    ////}

}