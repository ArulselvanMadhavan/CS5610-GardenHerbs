<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp22-ResponsiveGrid.aspx.cs" Inherits="experiments_project_experiments_Exp22_ResponsiveGrid" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Exp 22: Responsove grid View</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link href="css/gridstyle.css" rel="stylesheet" />
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/footable.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=responsivegrid.ClientID %>').footable({
                breakpoints: {
                    phone: 300,
                    tablet: 640
                }
            });
        });
    </script>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = bindGridView();
                responsivegrid.DataSource = dt;
                responsivegrid.DataBind();
                responsivegrid.UseAccessibleHeader = true;
                responsivegrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                TableCellCollection cells = responsivegrid.HeaderRow.Cells;
                cells[0].Attributes.Add("data-class", "expand");
                cells[2].Attributes.Add("data-hide", "phone,tablet");
                cells[3].Attributes.Add("data-hide", "phone,tablet");
                cells[4].Attributes.Add("data-hide", "phone");
                cells[5].Attributes.Add("data-hide", "phone,tablet");
            }
        }
        public DataTable bindGridView()
        {
            DataTable table = new DataTable();

            table.Columns.Add("StudentID", typeof(int));
            table.Columns.Add("StudentName", typeof(string));
            table.Columns.Add("FatherName", typeof(string));
            table.Columns.Add("City", typeof(string));
            table.Columns.Add("Country", typeof(string));
            table.Columns.Add("Address", typeof(string));

            table.Rows.Add(10856781, "Someone", "Else", "Someplace", "India", "100c Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(10267767, "Someone", "Else", "Someplace", "India", "100c Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(10465467, "Someone", "Else", "Someplace", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(105345, "Name", "for", "Test", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(10645543, "Name", "for", "Test", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(107543534, "Data", "for", "testing purposes", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(108543534, "Data", "for", "testing purposes", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(1095435, "Data", "for", "testing purposes", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(11054354, "Data", "for", "testing purposes", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(1115435, "Test", "Results", "Success", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(1124535, "Test", "Results", "Success", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");
            table.Rows.Add(11445435, "Test", "Results", "Success", "India", "100C Smith Street,Mission Main Apartments,Roxbury crossing,Boston,Massachusetts");

            return table;
        }
    </script>
</head>
<body>
    <div id="d_heading">
        <h1>Experiment 22: Creating a Responsive Grid View</h1>
        <h2><i>Purpose Of the Experiment:</i></h2>
        <p>
            In my project, I am planning to use the asp.net grid view control. Since, I want my entire website to be responsive , I decided to learn about making an asp.net grid view, responsive to various device widths.
            This experiment helped me learn about the complexities involved in making datatables responsive.
        </p>
        <h2>Experiment Demo:</h2>
        <p>
            Try Shrinking the below data grid to different sizes and notice the columns getting reduced as the page shrinks. The data in the columns that got hidden can be viewed by clicking on the respective rows.Try clicking a row when the columns get reduced for lesser device widths.
        </p>


        <br />

        <i><b>Disclaimer:</b> The C# code involved in data parsing is placed in this aspx file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.
            As per standard coding practices, I have written the C# code in code behind files in my project. Please refer piazza post @112.
        </i>
        <br />
    </div>
    <form id="form1" runat="server">
        <div>


            <asp:GridView ID="responsivegrid" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="footable">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />

            </asp:GridView>


        </div>
    </form>
    <div>
        <h2>Documentation:</h2>
        <p>1. In this experiment, I have used the Footable plugin to achieve responsiveness to the grid view. The problem with Footable plugin is that they are suitable only for HTML table elements. We have to adapt them to suit our needs for an asp.net grid.</p>
        <p>2. We can specify the columns that we want to display/hide for phones/tablets using the data-hide class . Sample code shown below</p>
        <p>3.The columns which we want to use for expanding data can be specified using the 'data-class' method.</p>
        <pre>
                responsivegrid.UseAccessibleHeader = true;
                responsivegrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                TableCellCollection cells = responsivegrid.HeaderRow.Cells;
                cells[0].Attributes.Add("data-class", "expand");
                cells[2].Attributes.Add("data-hide", "phone,tablet");
                cells[3].Attributes.Add("data-hide", "phone,tablet");
                cells[4].Attributes.Add("data-hide", "phone");
                cells[5].Attributes.Add("data-hide", "phone,tablet");
        </pre>
        <p>
            4. Responsiveness is achieved by having the data under a wrapper div and applying media queries to that div element.
        </p>
        <pre>
            @media (min-width: 320px) and (max-width: 480px) {
           .wrapper {
            max-width: 300px;
            width: 300px;
            }
            }

            @media (min-width: 481px) and (max-width: 767px) {
            .wrapper {
            max-width: 480px;
            width: 480px;
            }
            }
        </pre>
    </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp22-ResponsiveGrid.aspx" target="_blank">Link to source file</a>
    <hr />
    <div class="d_ref">
        <h2>References:</h2>
        <a href="http://themergency.com/footable/" target="_blank">1. Link to FooTable JS</a><br />
        <a href="http://themergency.com/footable-demo/responsive-container.htm" target="_blank">2.Footable Demos - Note:Demos given are for HTML tables. We have to modify them to suit asp.net tables.</a>
    </div>
</body>
</html>
