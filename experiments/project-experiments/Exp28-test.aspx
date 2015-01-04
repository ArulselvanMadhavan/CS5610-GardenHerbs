<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp28-test.aspx.cs" Inherits="experiments_project_experiments_Exp28_test" %>

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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Exp28</title>
    <%--<link href="css/crophome/cropresults.css" rel="stylesheet" />--%>
    <link href="css/crophome/exp28-test.css" rel="stylesheet" />
    <link href="css/crophome/jquery.mobile-1.4.1.min.css" rel="stylesheet" />
    <script src="js/jquery.js"></script>
    <script src="js/jquery.mobile-1.4.1.min.js"></script>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = null;
            try
            {
                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
                connection.Open();
                string sql = "select cropname,bestimgid from arulselv.browse_crops";
                SqlDataAdapter da = new SqlDataAdapter(sql, connection);
                DataTable table = new DataTable();
                da.Fill(table);
                CropList.DataSource = table;
                CropList.DataBind();
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
    <div data-role="page" class="my-page">

        <div data-role="content">
            <asp:ListView ID="CropList" runat="server" GroupItemCount="3" GroupPlaceholderID="groupPlaceHolder1"
                ItemPlaceholderID="itemPlaceHolder1">
                <LayoutTemplate>
                    <ul data-role="listview" data-inset="true">
                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <GroupTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                </GroupTemplate>
                <ItemTemplate>
                    <li>
                        <a href="#">
                            <img src='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' runat="server" style="height: 75%; width: 100%;border-radius:6px;" class="ui-li-thumb">
                            <%--<label runat="server" class="cropname"><%# Eval("cropname") %></label>--%>
                            <br />
                            <div class="cropdiv">    
                            <asp:Label ID="Label1" CssClass="ui-link" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"></asp:Label>
                                </div>
                        </a>
                        
                    </li>
                        </ItemTemplate>
            </asp:ListView>

                    <%--                        <a href="#">
                            <asp:Image ID="Image1" runat="server" Style='border-radius: 6px;' CssClass="ui-li-thumb"
                                ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' />
                        </a>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"></asp:Label>--%>
            

            <%--        <ul data-role="listview" data-inset="true">
        	<li><a href="#">
            	<img src="../../images/homepage/Arul-web.jpg" class="ui-li-thumb">
            	<h2>iOS 6.1</h2>
                <p>Apple released iOS 6.1</p>
                <p class="ui-li-aside">iOS</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/blackberry_10.png" class="ui-li-thumb">
            	<h2>BlackBerry 10</h2>
                <p>BlackBerry launched the Z10 and Q10 with the new BB10 OS</p>
                <p class="ui-li-aside">BlackBerry</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/lumia_800.png" class="ui-li-thumb">
            	<h2>WP 7.8</h2>
                <p>Nokia rolls out WP 7.8 to Lumia 800</p>
                <p class="ui-li-aside">Windows Phone</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/galaxy_express.png" class="ui-li-thumb">
            	<h2>Galaxy</h2>
                <p>New Samsung Galaxy Express</p>
                <p class="ui-li-aside">Samsung</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/nexus_7.png" class="ui-li-thumb">
            	<h2>Nexus 7</h2>
                <p>Rumours about new full HD Nexus 7</p>
                <p class="ui-li-aside">Android</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/firefox_os.png" class="ui-li-thumb">
            	<h2>Firefox OS</h2>
                <p>ZTE to launch Firefox OS smartphone at MWC</p>
                <p class="ui-li-aside">Firefox</p>
            </a></li>
        	<li><a href="#">
            	<img src="../_assets/img/tizen.png" class="ui-li-thumb">
            	<h2>Tizen</h2>
                <p>First Samsung phones with Tizen can be expected in 2013</p>
                <p class="ui-li-aside">Tizen</p>
            </a></li>
        	<li><a href="#">
            	<h2>Symbian</h2>
                <p>Nokia confirms the end of Symbian</p>
                <p class="ui-li-aside">Symbian</p>
            </a></li>
        </ul>--%>
        </div>
        <!-- /content -->
        <div>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </div>
    </div>
    <!-- /page -->
</body>
</html>
