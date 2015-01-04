<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Stylishgrid.aspx.cs" Inherits="experiments_project_experiments_Stylishgrid" %>

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
<head runat="server">
    <title>Exp 23: Styling grid View</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
    <link rel="stylesheet" href="css/bootstrap.css" />
<link href="css/responsivegrid.css" rel="stylesheet" />
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/footable.js"></script>
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
        
    }
    </script>
</head>
<body>
      <div class="d_heading">
        <h2><i>Experiment 23: Styling the Responsive Grid- Project</i></h2>
        <h2><i>Purpose of the Experiment:</i></h2><p>The Grid view from my previous experiment was responsive but there wasn't a way to inform the user that he has to click on a row to view the data that got hidden due to insufficient device width.
            With this experiment , I have included a plus and minus sign beside the row elements, to indicate that the rows are expandable.
            The previous experiment was done on a static data. This experiment is performed on data queried from an API.
        </p>
        <h2><i>Experiment Demo:</i></h2>
        <p>Click the button below to get the list of crops that have produced good sales revenue in MA State</p>
        <i>Please allow few seconds for the da0ta to be fetched as the code has to parse through millions of records and fecth only the desired results.</i>
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
                        Text="Fetch the Crops that provide highest sales revenue in MA " CssClass="btn-danger"
                        onclick="btn_getpastdata_Click" />
                    </td>
                <td>
                </td>
            </tr>
        </table>
        <div>
            <asp:GridView ID="g_census_Results" runat="server" CssClass="footable">
            </asp:GridView>
        </div>
           </div>
    </form>
    <div>
        <h2>Documentation</h2>
        <p>1. Though the grid view appears as <pre>< asp:GridView>< /asp:GridView> </pre> in our design pages, it is rendered using table html elements. Though we are not able to see any <pre>< th>< tr> < tdata></pre> elements while designing , the actual grid data is rendered using these HTML elements. This is evident when you goto debug mode in a webpage that renders data using grid view.</p>
        <p>2. Since grid view gets rendered using html elements, we can apply the same styling elements that we use to apply to html table elements.</p>
        <p>3. Code for rendering rows with 'plus' and minus' sign in phone mode </p>
        <pre>
            .footable.breakpoint > tbody > tr > td.expand {0000
             background: url('../img/plus.png') no-repeat 5px center;
            padding-left: 40px;
            }

            .footable.breakpoint > tbody > tr.footable-detail-show > td.expand {
            background: url('../img/minus.png') no-repeat 5px center;
            }
        </pre>
        <p>
            4.Changes that has to be made for elements that gets rendered under reduce device width mode(ex:Phone,tablet), come under the class breakpoint. 

        </p>
    </div>
        <hr/>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Stylishgrid.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a>

    <hr />
    <div class="d_ref">
        <h2>References:</h2>
         <a href="http://themergency.com/footable/" target="_blank">1. Link to FooTable JS</a><br />
         <a href="http://themergency.com/footable-demo/responsive-container.htm" target="_blank">2.Footable Demos - Note:Demos given are for HTML tables. We have to modify them to suit asp.net tables.</a>
         </div>
</body>
</html>

