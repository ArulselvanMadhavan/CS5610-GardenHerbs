using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;

public partial class project_JSON_parse : System.Web.UI.Page
{
    DataSet RunDS = new DataSet();
    [DataContract]
        public class JSONResults
        {
        [DataMember(Name = "id")]
            public string id { get; set; }
        [DataMember(Name = "marketname")]
            public string marketname { get; set; }
        }

        public class JSONResponse
        {
            [DataMember(Name = "results")]
            public List<JSONResults> results { get; set; }
        }
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_MarketSchedule_Click(object sender, EventArgs e)
    {
        try
        {
            string locationsRequest = CreateRequest("02120");
            JSONResponse JSONResponse= MakeRequest(locationsRequest);
            RunDS.Tables.Add(ProcessResponse(JSONResponse));
            g_Marketdetails.DataSource = RunDS;
            g_Marketdetails.DataBind();
            g_Marketdetails.Visible = true;
        }
        catch (Exception exc)
        {
            Console.WriteLine(exc.Message);
            Console.Read();
        }

    }
    public static string CreateRequest(string queryString)
    {
        string UrlRequest = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip=02120";
        return (UrlRequest);
    }

    public static JSONResponse MakeRequest(string requestUrl)
    {
        try
        {
            HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                    throw new Exception(String.Format(
                    "Server error (HTTP {0}: {1}).",
                    response.StatusCode,
                    response.StatusDescription));
                DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(JSONResponse));
                object objResponse = jsonSerializer.ReadObject(response.GetResponseStream());
                JSONResponse jsonres = objResponse as JSONResponse;
                return jsonres;
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return null;
        }

    }
    static public DataTable ProcessResponse(JSONResponse JSONres)
    {

        int total_markets = JSONres.results[0].id.Length;
        
        DataTable dt = new DataTable("MarketDetails_Table");
        dt.Columns.Add("Market_Id");
        dt.Columns.Add("Market_Name");
        for (int i = 0; i < total_markets; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Market_Id"] = JSONres.results[i].id;
            dr["Market_Name"] = JSONres.results[i].marketname;
            dt.Rows.Add(dr);
        }
        return dt;
        
    }
}