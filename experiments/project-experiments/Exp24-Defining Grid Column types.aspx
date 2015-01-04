<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp24-Defining Grid Column types.aspx.cs" Inherits="experiments_project_experiments_Exp24_Defining_Grid_Column_types" %>


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
        //string w_key = "9479ED1A-C12B-36E2-B3DD-3C4859C87441";
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
        <h2><i>Purpose of the Experiment:</i></h2><p>Sofar, I have only been using the styling template that is provided by default. Since , my responsive grid view allows the user to expand table data by clicking on any row in the datatable,
            I decided to style the grid by writing a seperate stylesheet which allows a 'plus' and 'minus' indicating the expanding and shrinking operations on tabledata.
        </p>
        <h2><i>Experiment Demo:</i></h2>
        <p>Click the button below to get the list of crops that have produced good sales revenue in MA State</p>
        <i>Please allow few seconds for the data to be fetched as the code has to parse through millions of records and fecth only the desired results.</i>
          <i>Notice that the grid view is responsive and it displays a plus sign when it is shrunk to the size of a phone/tablet. Minimize the screen to the size of a phone to see the results of this experiment</i>
    </div>
 <form id="form2" runat="server">
     <div class="d_getpastdata">
      <table class="t_getpastdata">
            <tr>
                <td class="b_getpastdata">
                    <asp:Button ID="btn_getpastdata" runat="server" 
                        Text="Fetch the Crops that provide highest sales revenue in MA "
                        onclick="btn_getpastdata_Click" />
                    </td>
                <td>
                </td>
            </tr>
        </table>
        <div>
            <asp:GridView ID="g_census_Results" runat="server" AutoGenerateColumns="false" CssClass="footable">
           
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
</body>
</html>
