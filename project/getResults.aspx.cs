using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class project_getResults : System.Web.UI.Page
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
        {
            try
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
            DataColumn[] primary_keys = new DataColumn[1];
            dt.Columns.Add("Commodity");
            dt.Columns.Add("Group");
            dt.Columns.Add("Section");
            dt.Columns.Add("Short Description");
            dt.Columns.Add("Year");
            dt.Columns.Add("State Code");
            dt.Columns.Add("Value");
            primary_keys[0] = dt.Columns["Commodity"];
            dt.PrimaryKey = primary_keys;


            string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" + "9479ED1A-C12B-36E2-B3DD-3C4859C87441" +
                "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=MA&format=XML";
            XDocument doc = XDocument.Load(UrlRequest);
            foreach (XElement item in doc.Descendants("perldata").Descendants("arrayref").Elements("item"))
            {
                var tmp = item.Descendants("hashref").Elements("item");
                DataRow dr = dt.NewRow();
                foreach (XElement subitem in tmp)
                {

                    if (subitem.Attribute("key").Value == "commodity_desc")
                        dr["Commodity"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "group_desc")
                        dr["Group"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "sector_desc")
                        dr["Section"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "short_desc")
                        dr["Short Description"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "state_alpha")
                        dr["State Code"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "year")
                        dr["Year"] = subitem.Value;
                    if (subitem.Attribute("key").Value == "Value")
                        try
                        {
                            dr["Value"] = Convert.ToDouble(subitem.Value);
                        }
                        catch
                        {
                            dr["Value"] = 0;
                        }
                }
                if ((Convert.ToDouble(dr["Value"]) != 0) && (!(dr["Commodity"].ToString().Contains("CROP TOTALS"))))
                {
                    if (dt.Rows.Contains(dr["Commodity"]))
                        foreach (DataRow dr2 in dt.Rows)
                        {
                            if ((dr2["Commodity"] == dr["Commodity"]) && (Convert.ToDouble(dr2["Value"]) < (Convert.ToDouble(dr["Value"]))))
                            {
                                dt.Rows.Remove(dr2);
                                dt.Rows.Add(dr);
                            }
                        }
                    else
                        dt.Rows.Add(dr);
                }

            }
            //DataView resultsView = new DataView(dt);
            //resultsView.Sort = "Value DESC";
            ////dt.DefaultView.Sort = "Value DESC";
            //RunDS.Tables.Add(resultsView.ToTable());
            //var tmp4 = dt.Columns["Value"];
            //dt.DefaultView.Sort = "Value ASC";
            //dt = dt.DefaultView.ToTable();
            //dt.DefaultView.Sort = "Value DESC";
            //dt = dt.DefaultView.ToTable();
            RunDS.Tables.Add(dt);
            g_census_Results.DataSource = RunDS;
            g_census_Results.DataBind();
            //g_census_Results.Sort("Value", SortDirection.Descending);
            g_census_Results.Visible = true;
        }

    }  
