<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp28-Datalist.aspx.cs" Inherits="experiments_project_experiments_Exp27_Datalist" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic"%>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Exp27-Datalist to display repeat columns in a row</title>
    <link href="css/bootstrap.css" rel="Stylesheet"/>
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
    <asp:DataList ID="DataList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
   Width="100%" BorderColor="#336699" BorderStyle="None" BorderWidth="2px" CssClass="footable">
   
   <ItemTemplate>
       <a href="#">
      <asp:Image ID="Image1" runat="server" style='height: 220px; width:220px;border-radius:6px;' CssClass="thumb"
         ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("ImageId") %>' />
           </a>
       <br />
<asp:Label ID="Label1" runat="server" Text='<%# Eval("cropName") %>' Font-Bold="True"
         Font-Size="10pt" ForeColor="#336699" Width="100%" />
   </ItemTemplate>
   <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"  />
</asp:DataList>
    </div>
        <div>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
