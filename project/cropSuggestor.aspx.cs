using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Net;
using edu.neu.ccis.rasala;
using System.Configuration;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class experiments_project_experiments_Exp25_Grid_View_Pagination : System.Web.UI.Page
{
    //DataSet RunDS = new DataSet();
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string script = " $(function my() {$('#g_census_Results').trigger('footable_redraw');});";
            //ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);

            ddl_statelist.DataTextField = "stateName";
            ddl_statelist.DataValueField = "stateCode";
            ddl_statelist.DataSource = cropDAO.fetchStateDetails();
            ddl_statelist.DataBind();

        }

    }
    public void btn_getpastdata_Click(object sender, EventArgs e)
    {
        string w_key = KeyTools.GetKey(this, "quickstats");
        string stateCode = ddl_statelist.Value;
        try
        {
            //string locationsRequest = CreateRequest("MA", w_key);
            //string locationsRequest = CreateRequest(stateCode, w_key);
            //XmlDocument locationsResponse = makeAPIRequest(locationsRequest);
            string url = getURL(ddl_statelist.Value, ddl_statscriteria.Value, w_key);
            if (url != null)
            {
                ProcessResponse(url);
            }
            UpdatePanel1.Update();
            //updatePanel2.Update();
            //string script = " $(function my() {$('#g_census_Results').trigger('footable_redraw');});";
            //ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ScriptKey", "my()", true);   
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            Console.Read();
        }
    }

    public string getURL(string stateCode, string requestedStats, string w_key)
    {
        switch (requestedStats)
        {

            case "SALES":
                return "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key +
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=" + stateCode + "&format=XML";
            //break;
            case "PRODUCTIONVALUE":
                return "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key + "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=PRODUCTION&year__GE=2012&state_alpha=" + stateCode + "&format=XML";
            //break;
            case "HARVESTEDAREA":
                return "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key + "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=AREA HARVESTED&unit_desc=ACRES&year__GE=2012&state_alpha=" + stateCode + "&format=XML";
            default:
                return null;

        }
    }
    public static string CreateRequest(string stateCode, string w_key)
    {

        string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key +
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=AREA HARVESTED&unit_desc=ACRES&year__GE=2012&state_alpha=" + stateCode + "&format=XML";

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
    public void ProcessResponse(string UrlRequest)
    {
        //Create namespace manager
        //XmlNamespaceManager nsmgr = new XmlNamespaceManager(locationsResponse.NameTable);
        //nsmgr.AddNamespace("rest", "http://schemas.microsoft.com/search/local/ws/rest/v1");
        //XmlNodeList locationElements = locationsResponse.SelectNodes("//rest:data", nsmgr);
        DataSet RunDS = new DataSet();
        DataTable dt = new DataTable("CensusDataTable");
        DataColumn[] primary_keys = new DataColumn[1];
        dt.Columns.Add("Commodity");
        dt.Columns.Add("Group");
        dt.Columns.Add("Section");
        dt.Columns.Add("Short Description");
        dt.Columns.Add("Year");
        dt.Columns.Add("State Code");
        dt.Columns.Add("Value", typeof(Double));
        primary_keys[0] = dt.Columns["Commodity"];
        dt.PrimaryKey = primary_keys;
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
                        //Add only the maximum value for a particular commodity
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
        DataView dv = dt.DefaultView;
        dv.Sort = "Value DESC";
        DataTable sorteddt = dv.ToTable(); // Sorting the results to get the maximum values at the top.
        RunDS.Tables.Add(sorteddt);
        g_census_Results.DataSource = RunDS;
        g_census_Results.DataBind();
        g_census_Results.Visible = true;
        g_census_Results.UseAccessibleHeader = true;
        g_census_Results.HeaderRow.TableSection = TableRowSection.TableHeader;
        TableCellCollection cells = g_census_Results.HeaderRow.Cells;
        cells[0].Attributes.Add("data-class", "expand");
        cells[1].Attributes.Add("data-hide", "phone");
        cells[2].Attributes.Add("data-hide", "phone,tablet");
        cells[3].Attributes.Add("data-hide", "phone,tablet");
        cells[4].Attributes.Add("data-hide", "phone,tablet");
        cells[5].Attributes.Add("data-hide", "phone,tablet");
        g_census_Results.FooterRow.TableSection = TableRowSection.TableFooter;

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

    public void setVisibility()
    {
        g_census_Results.Visible = false;
    }
}