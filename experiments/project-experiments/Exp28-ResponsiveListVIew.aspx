<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp28-ResponsiveListVIew.aspx.cs" Inherits="experiments_project_experiments_Exp28_ResponsiveListVIew" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Exp28:ResponsiveListView</title>
    <%--<style>
        th, td {
            padding: 2px;
        }

        table {
            border-collapse: collapse;
            border-spacing: 0;
            margin-left: 10%;
            margin-right: 10%;
        }
    </style>--%>
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
<%--    <link href="css/crophome/exp28-test.css" rel="stylesheet" />
    <link href="css/crophome/jquery.mobile-1.4.1.css" rel="stylesheet" />
    <script src="js/jquery.js"></script>
    <script src="js/jquery.mobile-1.4.1.min.js"></script>--%>
    <link href="css/crophome/cropown.css" rel="stylesheet" />
</head>
<body>
    <%--<div data-role="page" class="my-page">--%>
    <div class="pad">
    <form id="form1" runat="server">
        
<%--            <asp:ListView ID="CropList" runat="server" GroupItemCount="3" GroupPlaceholderID="groupPlaceHolder1"
                ItemPlaceholderID="itemPlaceHolder1">
                <LayoutTemplate>
                    <div role="main" class="ui-content">
                        <ul data-role="listview" data-inset="true">
                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                        </ul>
                    </div>
                </LayoutTemplate>
                <GroupTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                </GroupTemplate>
                <ItemTemplate>
                    <li>
                        <a href="#">
                            <asp:Image ID="Image1" runat="server" Style='border-radius: 6px;' CssClass="ui-li-thumb"
                                ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' />
                        </a>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"
                            Font-Size="10pt" ForeColor="#336699" Width="100%" />
                    </li>
                </ItemTemplate>
            </asp:ListView>--%>
       <asp:ListView ID="CropList" runat="server" GroupItemCount="4" GroupPlaceholderID="groupPlaceHolder1"
                ItemPlaceholderID="itemPlaceHolder1">
                <LayoutTemplate>
                    <table id="maincontent" class="maincontent" >
                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td>
                        <div class="cropwrapper">
                        <table class="cropresults">
                            <tr>
                                <td>
                                    <b><u><a href="#">
                                        <asp:Image ID="Image1" runat="server" Style='height: 220px; width: 220px; border-radius: 6px;' CssClass="thumb"
                                            ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' />
                                    </a></u></b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"
                                        Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                </td>
                            </tr>
                        </table>
                            </div>
                    </td>
                </ItemTemplate>
            </asp:ListView>
        
        <div>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </div>
    </form>
        </div>
</body>
</html>
