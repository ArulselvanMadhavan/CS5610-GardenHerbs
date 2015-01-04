<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp25-Grid_View_Pagination.aspx.cs" Inherits="experiments_project_experiments_Exp25_Grid_View_Pagination" %>


<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace= "System.Data" %>
<%@ Import Namespace= "System.Collections" %>
<%@ Import Namespace= "System.Collections.Generic"%>
<%@ Import Namespace= "System.IO" %>
<%@ Import Namespace= "System.Xml" %>
<%@ Import Namespace= "System.Xml.XPath" %>
<%@ Import Namespace= "System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Exp 24: Responsive Pagination in Grid</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
    <link href="css/bootstrap.css" rel="Stylesheet"/>
<link href="css/responsivegrid.css" rel="stylesheet" />
    <script src="js/jquery-1.11.1.min.js" type="text/ecmascript"></script>
    <script src="js/footable.js" type="text/javascript"></script>
    <script src="js/footable.paginate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=g_census_Results.ClientID %>').footable({
                breakpoints: {
                    phone: 300,
                    tablet: 640
                }
            });
        });
    </script>
    <style>
        pre{
            color:blue;
        }
    </style>
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
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=AREA HARVESTED&unit_desc=ACRES&year__GE=2012&state_alpha=MA&format=XML";

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
    public void ProcessResponse(XmlDocument locationsResponse,string w_key)
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
        dt.Columns.Add("Value",typeof(Double));
        primary_keys[0] = dt.Columns["Commodity"];
        dt.PrimaryKey = primary_keys;

        string UrlRequest = "http://quickstats.nass.usda.gov/api/api_GET/?key=" + w_key +
            "&source_desc=CENSUS&sector_desc=CROPS&statisticcat_desc=AREA HARVESTED&unit_desc=ACRES&year__GE=2012&state_alpha=MA&format=XML";
        
        
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

            e.Row.Cells[0].Controls.Add(new LiteralControl("<div class='pagination pagination-centered hide-if-no-paging'></div>"));
        }
    }
    </script>
</head>
<body>
      <div class="d_heading">
        <h2><i>Experiment 24-Project-Achieving Pagination in Grid View</i></h2>
        <h2><i>Purpose of the Experiment:</i></h2><p>In my project , the data that I show to my users via grid view can span multiple rows. Instead of having the users scroll down to see all the results, I decided to display the results in several pages.
            Pagination in a ASP.NET is not difficult, but achieving pagination in a responsive grid is.
        </p>
        <h2><i>Experiment Demo:</i></h2>
        <p>Click the button below to get the list of crops that has been harvested in MA State</p>
        <i>Please allow few seconds for the data to be fetched as the code has to parse through millions of records and fecth only the desired results.</i>
          <i>Notice that the grid view is responsive and it displays a plus sign when it is shrunk to the size of a phone/tablet. Minimize the screen to the size of a phone to see the results of this experiment</i>
             <br />

        <i><b>Disclaimer:</b> The C# code involved in data parsing is placed in this aspx file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.
            As per standard coding practices, I have written the C# code in code behind files in my project.
        </i>
        <br />
    </div>
 <form id="form2" runat="server">
     <div class="d_getpastdata">
      <table class="t_getpastdata">
            <tr>
                <td class="b_getpastdata">
                    <asp:Button ID="btn_getpastdata" runat="server" 
                        Text="Fetch the Crops that provide highest sales revenue in MA " CssClass="btn-primary"
                        onclick="btn_getpastdata_Click" />
                    </td>
                <td>
                </td>
            </tr>
        </table>
        <div>
            <asp:GridView ID="g_census_Results" runat="server" ShowFooter="true" OnRowCreated="onRowCreate" AutoGenerateColumns="false" CssClass="footable" data-page-size="5">
           
            <Columns>
                                <asp:BoundField ReadOnly="True" HeaderText="Commodity"
                                    DataField="Commodity"></asp:BoundField>
                                <asp:BoundField HeaderText="Group"
                                    DataField="Group"></asp:BoundField>
                                <asp:BoundField HeaderText="Section"
                                    DataField="Section"></asp:BoundField>
                                <asp:BoundField HeaderText="Short Description"
                                    DataField="Short Description"></asp:BoundField>
                                <asp:BoundField HeaderText="State Code"
                                    DataField="State Code"></asp:BoundField>
                                <asp:BoundField HeaderText="Year"
                                    DataField="Year"></asp:BoundField>
                <asp:BoundField HeaderText="Value"
                                    DataField="Value"></asp:BoundField>
                                <%--<asp:HyperLinkField DataNavigateUrlFields="npi" DataNavigateUrlFormatString="findPhysician-helper.aspx?npi={0}" HeaderText="More" Text="View Details" Target="_blank" />--%>
                            </Columns>
                 </asp:GridView>

        </div>
           </div>
    </form>
    <div>
        <h2>Documentation</h2>
        <p>1. TO achieve pagination in grid view, set the AutoGenerateColumns property as false</p>
        <p>2. Configure the columns of the grid view as follows</p>
        <pre>
            < Columns>
                                < asp:BoundField ReadOnly="True" HeaderText="Commodity"
                                    DataField="Commodity">< /asp:BoundField>
                                < asp:BoundField HeaderText="Group"
                                    DataField="Group">< /asp:BoundField>
                                < asp:BoundField HeaderText="Section"
                                    DataField="Section">< /asp:BoundField>
                                < asp:BoundField HeaderText="Short Description"
                                    DataField="Short Description">< /asp:BoundField>
                                < asp:BoundField HeaderText="State Code"
                                    DataField="State Code">< /asp:BoundField>
                                < asp:BoundField HeaderText="Year"
                                    DataField="Year">< /asp:BoundField>
                < asp:BoundField HeaderText="Value"
                                    DataField="Value">< /asp:BoundField>
                            < /Columns>
        </pre>
        <p>
            3.Set the data-page-size property to the number of columns that  you want in a page
        </p>
        <pre>
            Example: data-page-size="5"
        </pre>
        <p>
            4. Footable applies pagination styles to tfoot. Since we dont have a tfoot in asp.net grid, we have to create a tfoot element.
        </p>
        <p>
            5. Set the OnRowCreated event to call a function . This function should dynamically create a div element that can be used as a replacement for tfoot. 
        </p>
        <pre>
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

            e.Row.Cells[0].Controls.Add(new LiteralControl("< div class='pagination pagination-centered hide-if-no-paging'>< /div>"));
        }
    }
        </pre>
    </div>
      <hr/>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp25-Grid View Pagination.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a>
    <hr />
    <div class="d_ref">
        <h2>References:</h2>
         <a href="http://themergency.com/footable/" target="_blank">1. Link to FooTable JS</a><br />
         <a href="http://themergency.com/footable-demo/responsive-container.htm" target="_blank">2.Footable Demos</a><br />
         <a href="http://fooplugins.com/footable/demos/paging.htm" target="_blank">3.Demo on Pagination for HTML elements</a>
         </div>
</body>
</html>