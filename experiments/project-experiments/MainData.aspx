<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainData.aspx.cs" Inherits="project_MainData" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp:21 - First attempt to extract data from USDA - Project</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <script runat="server">
        DataSet RunDS = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void btn_getpastdata_Click(object sender, EventArgs e)
        {
            string w_key = KeyTools.GetKey(this, "quickstats");
            try
            {
                string locationsRequest = CreateRequest("MA", w_key);
                XmlDocument locationsResponse = makeAPIRequest(locationsRequest);
                ProcessResponse(locationsResponse, w_key);
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
                return null;
            }

        }
        public void ProcessResponse(XmlDocument locationsResponse, string w_key)
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
            dt.Columns.Add("Value", typeof(Double));
            primary_keys[0] = dt.Columns["Commodity"];
            dt.PrimaryKey = primary_keys;

            string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key +
               "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=MA&format=XML";
            //string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key="
            //    + KeyTools.GetKey(this,"quickstats") + "source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=SALES&unit_desc=$&year__GE=2012&state_alpha=MA&format=XML";
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

        }
    </script>
    <style>
        pre {
            color: blue;
        }

        p {
            color: black;
        }
    </style>



</head>
<body>
    <div class="d_heading">
        <h2><i>Experiment 21: First attempt to extract data from USDA - Project</i></h2>
        <h2><i>Purpose of the Experiment:</i></h2>
        <p>
            Since I need to connect to the US Department of Agriculture API site and extract relevant data from a flood of data,
            I decided to perform my first experiment in connecting to the US department of Agriculture. The knowledge gained from this experiment gives me a wide range of ideas to implement my project using the stats provided by USDA.
        </p>
        <h2><i>Experiment Demo:</i></h2>
        <p>Click the button below to get the list of crops that have produced good sales revenue in MA State</p>
        <i>Please allow few seconds for the data to be fetched as the code has to parse through millions of records and fecth only the desired results.</i>
        <br />
        <hr />
        <i>Disclaimer: The C# code involved in data parsing is placed in this aspx file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.
            As per standard coding practices, I have written the C# code in code behind files in my project. Reference: Piazza post: @112
        </i>
        <hr />
        <br />
    </div>
    <form id="form1" runat="server">
        <div class="d_getpastdata">
            <table class="t_getpastdata">
                <tr>
                    <td class="b_getpastdata">
                        <asp:Button ID="btn_getpastdata" runat="server"
                            Text="Fetch the Crops that provide highest sales revenue in MA " CssClass="btn-warning"
                            OnClick="btn_getpastdata_Click" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <div class="d_searchResults">
                <table class="t_census_Results">
                    <tr>
                        <td class="g_census_Results">
                            <asp:GridView ID="g_census_Results" runat="server" CellPadding="4" ForeColor="#333333"
                                GridLines="None">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table>
                    <tr>
                        <td>
                            <p id="errorMsg" runat="server" visible="false" style="text-align: center; background-color: Silver; border: 1px dotted gray"></p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <h2>Documentation:</h2>
    <p>
        1. After registering with USDA to get an access key, we have to frame our URL request to hit the USDA API.
    </p>
    <p>
        2. The returned results will have thousands of data with duplications.
    </p>
    <p>
        3. We have to eliminate the duplicate results, Invalid results, and get only the maximum revenue for each crop.
    </p>
    <p>Here is a code sample</p>
    <p><i>Code for connecting and retrieving the documents.</i></p>
    <pre>
       string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key="
                            + KeyTools.GetKey(this,"quickstats") + "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=PRODUCTION&year__GE=2012&state_alpha=MA&format=XML";
        XDocument doc = XDocument.Load(UrlRequest);
        </pre>
    <pre>
        <p><i>Code for iterating over the retrieved content and extracting only the relevant data. </i></p>
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
        </pre>
    <pre>
        <p><i>Code for Filtering only the valid results. This will remove results with value , prevent duplication and retain only the item with maximum sales revenue in the dataTable.</i></p>
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

    </pre>

    <div>
        <br />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/MainData.aspx" style="color: black; text-decoration: underline" target="_blank">Link to source file</a>
    </div>
    <div>
        <h2>References</h2>
        <a href="http://ww.w3schools.com" target="_blank">1. W3Schools.</a>
    </div>
</body>
</html>

