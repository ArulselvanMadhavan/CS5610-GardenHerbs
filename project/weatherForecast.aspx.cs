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
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    //static string xmlResponse;
    DataSet RunDS = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblError.Visible = false;
        if (!IsPostBack)
        {
            ddl_statelist.DataTextField = "stateName";
            ddl_statelist.DataValueField = "stateName";
            ddl_statelist.DataSource = cropDAO.fetchStateDetails();
            ddl_statelist.DataBind();
            ddl_zipCodeList.Items.Add("Select a ZipCode");
        }
    }
    protected void btnWeatherForecast_Click(object sender, EventArgs e)
    {
        if (ddl_zipCodeList.Value == "Select a ZipCode")
        {
            lblError.Visible = true;
            lblError.Text = "Please select a zipcode to continue";
        }
        else
        {
            string w_key = KeyTools.GetKey(this, "weather");
            try
            {
                string locationsRequest = CreateRequest(ddl_zipCodeList.Value, w_key);
                ProcessResponse(locationsRequest);
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "There was an error in retrieving the weather data. Please try later";
            }
        }
    }
    public static string CreateRequest(string zipCode, string w_key)
    {

        string UrlRequest = " http://api.worldweatheronline.com/free/v1/weather.ashx?key=" + w_key + "&q=" + zipCode + "&num_of_days=5&format=xml";
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
     
        catch
        {

            return null;
        }

    }

    public void ProcessResponse(string URLRequest)
    {

        DataSet RunDS = new DataSet();
        DataTable dt = new DataTable("weatherForecastTable");
        dt.Columns.Add("Date");
        dt.Columns.Add("weatherIconUrl");
        dt.Columns.Add("WeatherDesc");
        dt.Columns.Add("tempMaxF");
        dt.Columns.Add("tempMinF");
        dt.Columns.Add("windspeedMiles");
        dt.Columns.Add("Wind Direction");
        dt.Columns.Add("Wind Direction Degree");
        dt.Columns.Add("humidity");
        dt.Columns.Add("Precip MM");

        XDocument doc = XDocument.Load(URLRequest);
        foreach (XElement weather in doc.Descendants("data").Elements("weather"))
        {
            DataRow dr = dt.NewRow();
            dr["Date"] = weather.Element("date").Value;
            dr["weatherIconUrl"] = weather.Element("weatherIconUrl").Value;
            dr["WeatherDesc"] = weather.Element("weatherDesc").Value;
            dr["tempMaxF"] = weather.Element("tempMaxF").Value;
            dr["tempMinF"] = weather.Element("tempMinF").Value;
            dr["windspeedMiles"] = weather.Element("windspeedMiles").Value;
            dr["Wind Direction"] = weather.Element("winddirection").Value;
            dr["Wind Direction Degree"] = weather.Element("winddirDegree").Value;
            //dr["humidity"] = weather.Element("humidity").Value;
            dr["Precip MM"] = weather.Element("precipMM").Value;
            //string url = weather.Element("weatherIconUrl").Value.ToString();
            dt.Rows.Add(dr);
        }
        RunDS.Tables.Add(dt);
        g_forecastResults.DataSource = RunDS;
        g_forecastResults.DataBind();
        g_forecastResults.Visible = true;
        g_forecastResults.UseAccessibleHeader = true;
        g_forecastResults.HeaderRow.TableSection = TableRowSection.TableHeader;
        TableCellCollection cells = g_forecastResults.HeaderRow.Cells;
        cells[0].Attributes.Add("data-class", "expand");
        cells[1].Attributes.Add("data-hide", "phone");
        cells[2].Attributes.Add("data-hide", "phone");
        cells[3].Attributes.Add("data-hide", "phone,tablet");
        cells[4].Attributes.Add("data-hide", "phone,tablet");
        cells[5].Attributes.Add("data-hide", "phone,tablet");
        cells[6].Attributes.Add("data-hide", "phone,tablet");
        cells[7].Attributes.Add("data-hide", "phone,tablet");
        cells[8].Attributes.Add("data-hide", "phone,tablet");
        //g_forecastResults.FooterRow.TableSection = TableRowSection.TableFooter;
    }
    protected void ddl_Statelist_SelectedIndexChanged(object sender, EventArgs e)
    {

        //g_Marketdetails.Visible = false;
        ddl_zipCodeList.DataTextField = "zipcode";
        ddl_zipCodeList.DataValueField = "zipcode";
        ddl_zipCodeList.DataSource = cropDAO.fetchZipCodeDetails(ddl_statelist.SelectedValue);
        ddl_zipCodeList.DataBind();
        //g_Marketdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        //g_Marketdetails.Visible = true;

        //g_Marketdetails.DataBind();
        g_forecastResults.Visible = false;

    }
    protected void onRowCreate(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            int colSpan = e.Row.Cells.Count;

            for (int i = (e.Row.Cells.Count - 1); i >= 1; i -= 1)
            {
                e.Row.Cells.RemoveAt(i);
                e.Row.Cells[0].ColumnSpan = colSpan;
            }

            e.Row.Cells[0].Controls.Add(new LiteralControl("<div id=page class='pagination pagination-centered hide-if-no-paging'></div>"));
        }
    }
    protected void g_forecastResults_PreRender(object sender, EventArgs e)
    {
        if ((g_forecastResults.ShowHeader == true && g_forecastResults.Rows.Count > 0)
    || (g_forecastResults.ShowHeaderWhenEmpty == true))
        {
            //Force GridView to use <thead> instead of <tbody>
            g_forecastResults.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        //if (g_forecastResults.ShowFooter == true && g_forecastResults.Rows.Count > 0)
        //{
        //    //Force GridView to use <tfoot> instead of <tbody> - 11/03/2013 - MCR.
        //    g_forecastResults.FooterRow.TableSection = TableRowSection.TableFooter;
        //}
        base.OnPreRender(e);
    }
}