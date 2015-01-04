<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp28-Datalist.aspx.cs" Inherits="experiments_project_experiments_Exp27_Datalist" %>

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

<html>
<head runat="server">
    <title>Exp27-Datalist to display repeat columns in a row</title>
    <link href="css/bootstrap.css" rel="Stylesheet" />
    <link href="css/crophome/cropresults.css" rel="stylesheet" />
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = null;
            try
            {
                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());

                connection.Open();
                string sql = "select cropName,ImageId from arulselv.user_crop_images";
                SqlDataAdapter da = new SqlDataAdapter(sql, connection);
                DataTable table = new DataTable();
                da.Fill(table);
                DataList1.DataSource = table;
                DataList1.DataBind();
                connection.Close();

            }
            catch
            {
                lblStatus.Text = "There was an error";
            }
            finally
            {
                connection.Close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Experiment28: Working with Datalist </h2>
            <h3>Purpose of the Experiment: In my project, I am planning to display a browse crops page which lists the crops supported by our project team. </h3>
            <p>Something like the below screenshot</p>
            <img src="../../images/exp28-sample.jpg" style="width: 250px; height: 250px;" />
            <p>This could be very easily achieved if the images and the data displayed in it are static. But I want the data to be retrieved from the DB,so that my project website is dynamic.</p>
            <p>We have grid view control to display table data but I want the table data to be displayed horizontally and not vertically. </p>
            <p>To render table data horizontally, we have to use datalist </p>
            <p>So, this is an experiment to help me familiarize myself with the asp datalist control. If all works out well, I will use datalist in my project.</p>
        </div>
        <div>
            <div>
                <br />

                <i><b>Disclaimer:</b> The C# code involved in data parsing is placed in this aspx file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.
            As per standard coding practices, I have written the C# code in code behind files in my project.
                </i>
                <i>Also , the SQL queries are put in this file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.  Please refer Piazza post @112 where the instructor advised us to put the code in aspx file to facilitate easy review during grading process.
            As per standard coding practices , all my SQL connections have been put inside a Data Access Object (DAO). All the data that is involved in communication with the database
            have been encapsulated inside a ValueObject class in my project. 
                </i>
                <br />
                <br />
                <i>2. Since my database has size constraints, I will be purging the data in the table accessed by this experiment, every night. However, the db used in my project  and the data contained by it will be intact.
                    If you want to test this experiment intensively, you can goto my week9 experiments and upload few images to test how they are getting rendered in this page.
                </i>
                <br />
            </div>
            <div>
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                    Width="100%" BorderColor="#336699" BorderStyle="None" BorderWidth="2px" CssClass="footable">

                    <ItemTemplate>
                        <a href="#">
                            <asp:Image ID="Image1" runat="server" Style='height: 220px; width: 220px; border-radius: 6px;' CssClass="thumb"
                                ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("ImageId") %>' />
                        </a>
                        <br />
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropName") %>' Font-Bold="True"
                            Font-Size="10pt" ForeColor="#336699" Width="100%" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                </asp:DataList>
            </div>
        </div>
        <div>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </div>
        <div class="documentation">
            <h2>Documentation
            </h2>
            <p>
                1. Connect to the DB and from which you want to retrieve data and then query the required results.
            </p>
            <p>
                2. Assign the results to the datasource of the datalist using this command.
                <pre>
                DataList1.DataSource = table;
                
                    </pre>
            </p>
            <p>
                3. None of the data will be assigned to the controls inside datalist unless a databind is called.
                <pre>
                 DataList1.DataBind();
                </pre>
            </p>
            <p>
                4. The controls inside the datalist take values from the datasource that is being assigned to the datalist. 
            </p>
            <p>
                5. To achieve this, we use asp.net's resource tags. "< %# %>" . They let the controls to access the methods/controls that run at the server and fetch their values from them.
            </p>
            <p>
                6. The ID of the images to be displayed are fetched from the DB and then a webhandler that I created during my week 9 experiments ,retreives the image from the DB.
            </p>
            <p>
                7. The datalist property that helps us to display data horizontally is shown below
                <pre>
                 RepeatColumns="2" RepeatDirection="Horizontal"
                    </pre>
            </p>
        </div>
        <hr />
        <p>
            <b>Problems faced:</b>
           <br />
            I have been trying to achieve pagination on this datalist for more than 7 hours . It appears pagination cannot be achieved in a datalist. I am looking for plugins that allow pagination on datalists just like how footable does it for gridview.           
        </p>
        <hr />
        <div>
            <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp28-Datalist.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a>
        </div>
        <div>
            <h2>
                References
            </h2>
            <a href="http://msdn.microsoft.com/en-us/library/79k821wc(v=vs.100).aspx" target="_blank">1.MSDN Library</a> <br />
            <a href="http://runnable.com/UjnG4ehYOHQOAABj/asp-net-how-to-use-datalist" target="_blank">2. Code example from Runnable.com</a><br />
        </div>
    </form>
</body>
</html>
