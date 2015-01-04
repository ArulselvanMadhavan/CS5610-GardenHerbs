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


public partial class project_QuickStats : System.Web.UI.Page
{
    DataSet RunDS = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btn_getpastdata_Click(object sender, EventArgs e)
    {

        string w_key = "9479ED1A-C12B-36E2-B3DD-3C4859C87441";
        //string locationsResponse = null;
        try
        {
            string locationsRequest = CreateRequest("MA", w_key);
            XmlDocument locationsResponse = makeAPIRequest(locationsRequest);
            ProcessResponse(locationsResponse);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            Console.Read();
        }
    }
     public static string CreateRequest(string queryString, string w_key)
    {

        string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key +
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=MA&format=XML";
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
        //errorMsg.InnerText = "Sorry! An error occured while loading the page!";
        //errorMsg.Visible = true;
        return null;
    }

    }
     public void ProcessResponse(XmlDocument locationsResponse)
    {
        //Create namespace manager
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(locationsResponse.NameTable);
        nsmgr.AddNamespace("rest", "http://schemas.microsoft.com/search/local/ws/rest/v1");
        XmlNodeList locationElements = locationsResponse.SelectNodes("//rest:data", nsmgr);
        DataSet RunDS = new DataSet();
        DataTable dt = new DataTable("CensusDataTable");
        dt.Columns.Add("Commodity");
        dt.Columns.Add("Group");
        dt.Columns.Add("Section");
        dt.Columns.Add("Short Description");
        dt.Columns.Add("Year");
        dt.Columns.Add("State Code");
        dt.Columns.Add("Value");
        string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" +"9479ED1A-C12B-36E2-B3DD-3C4859C87441"+
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=MA&format=XML";
        XDocument doc = XDocument.Load(UrlRequest);
        foreach (XElement item in doc.Descendants("perldata").Descendants("arrayref").Elements("item"))
        {
            DataRow dr = dt.NewRow();
            dr["Commodity"] = item.Element("commodity_desc").Value;
            dr["Group"] = item.Element("group_desc").Value;
            dr["Section"] = item.Element("sector_desc").Value;
            dr["Short Description"] = item.Element("short_desc").Value;
            dr["State Code"] = item.Element("state_alpha").Value;
            dr["Year"] = item.Element("year").Value;
            dr["Value"] = item.Element("Value").Value;
            dt.Rows.Add(dr);
        }
        RunDS.Tables.Add(dt);
        g_census_Results.DataSource = RunDS;
        g_census_Results.DataBind();
        g_census_Results.Visible = true;
    }

}