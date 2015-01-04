<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp29-ResponsiveListVIew.aspx.cs" Inherits="experiments_project_experiments_Exp28_ResponsiveListVIew" %>

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
    <link href="css/bootstrap.css" rel="Stylesheet" />
    <link href="css/crophome/cropown.css" rel="stylesheet" />
</head>
<body>
    <%--<div data-role="page" class="my-page">--%>
    <div class="pad">
        <div>
            <h2>Experiment:29: Responsive List View</h2>
            <p>
                <b>Purpose Of the Experiment:</b>
                I learned from my previous experiment with datalist that it is really hard to achieve pagination and responsiveness with datalist. So, I performed this experiment to see how to display table data(from DB) horizontally
                and also achieve responsiveness on the table data.
            </p>
            <h2>
                Experiment Demo: 
            </h2>
            <p>
                I am trying to achieve something like the below screenshot and also make such a page responsive.
            </p>
                            <div>
            <img src="../../images/exp28-sample.jpg" style="width: 250px; height: 250px;" />
                    </div>
           <b>Try shrinking the page to smaller size and see how the page adjusts itself based on the screenwidth.</b>
            <%--<div>
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
            </div>--%>
        </div>
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
                    <table id="maincontent" class="maincontent">
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
                                                ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("bestPlantingId")%>' />
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
        <div>
            <h2>
                Documentation:
            </h2>
            <p>
                1. AS opposed to the previous experiment, I have switched tables and using one of my project tables to display the data. I have created a view to query the data that I need to display in this page.
            </p>
            <p>
                2. Also , with this experiment , I have followed the DAO method which the professor suggested to use , while querying DB.
            </p>
            <p>
                3. To configure listview to display data horizontally, you have to write your own Layout template  and grouptemplate in addition to the itemtemplate  , as opposed to the datalist which needs only a Itemtemplate.
                <code>
                 
                < LayoutTemplate>
                    < table id="maincontent" class="maincontent">
                        asp:PlaceHolder runat="server" ID="groupPlaceHolder1" 
                    < /t>
                < /LayoutTemplate>
                < GroupTemplate>
                    < tr>
                       asp:PlaceHolder runat=" server " ID=" itemPlaceHolder1 " 
                    < /tr>
                < /GroupTemplate>
                </code>
            </p>
            <p>
                4. In the Layout template , I have used a HTML table to render the listview's data. 
            </p>
            <p>
                5. This is the major setting that enables table data to get rendered horizontally.
                <pre>
                    GroupItemCount="4" GroupPlaceholderID="groupPlaceHolder1"
                </pre>
            </p>
            <p>
                6. In the Group template, I have used table row to group list data, in numbers of 4, under a single row 
                <pre>
                    < GroupTemplate>
                    < tr>
                       asp:PlaceHolder runat="server" ID="itemPlaceHolder1" /asp:PlaceHolder
                    < /tr>
                < /GroupTemplate>
                </pre>
            </p>
            <p>
                7. Finally my Itemtemplate uses a < td> to display each list data 
            </p>
            <p>
                Note: ASP server tags have been removed to allow the code to get displayed in this page. You can view the source of this page to see the asp.new controls with their tags.
            </p>
        </div>

        
        <hr />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp29-ResponsiveListVIew.aspx" target="_blank">Link to aspx file</a> <br />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp29-ResponsiveListVIew.aspx.cs" target="_blank">Link to cs file</a> <br />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">Link to DAO file</a> <br />
        <hr/>
        <h2>References</h2>
        <a href="http://stackoverflow.com/questions/16433063/horizontal-list-view-in-asp-net" target="_blank">1.StackOverflow discussion</a> <br />
        <a href="http://www.aspsnippets.com/Articles/Populate-ASPNet-ListView-from-database-and-Repeat-columns-horizontally-using-GroupTemplate.aspx" target="_blank">2.Example from ASP.Snippets</a> <br />
    </div>
</body>
</html>
