<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp30-ListGrid-dynamic-update.aspx.cs" Inherits="experiments_project_experiments_Exp29_ListGrid_dynamic_update" %>

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
    <title>Exp30:Pagination in ListView</title>
    <link href="css/crophome/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/footable.js" type="text/javascript"></script>
    <script src="js/footable.paginate.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            $('.footable').footable({
                breakpoints: {
                    phone: 720,
                    tablet: 720
                }
            });
        });
    </script>
    <link href="css/crophome/newstyle.css" rel="stylesheet" />
</head>
<body>
    <%--<div data-role="page" class="my-page">--%>
    <div class="pad">
        <div>
            <h2>Experiment:30:List View with Pagination</h2>
            <p>
                <b>Purpose Of the Experiment:</b>
                In my previous experiment , I learned how to make a listview to display table data horizontally and then achieve responsiveness in it.
                In this experiment , I have tried to achieve pagination on the listview.
            </p>
            <h2>Experiment Demo: 
            </h2>
            <p>
                For testing purposes I have limited the page size to 1. You can traverse through the table records by clicking the page numbers displayed below.
                If there is only 1 page, then the navigation buttons get disabled on their own.
            </p>
            <div>
                <img src="../../images/exp28-sample.jpg" style="width: 250px; height: 250px;" />
            </div>
            <b>Try shrinking the page to smaller size and see how the page adjusts itself based on the screenwidth.</b>
        </div>
        <form id="form1" runat="server">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ListView ID="CropList" runat="server" GroupItemCount="4" GroupPlaceholderID="groupPlaceHolder1"
                            ItemPlaceholderID="itemPlaceHolder1">
                            <LayoutTemplate>
                                <table id="cropresultstable" class="row footable" data-page-size="1">
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    <tfoot class="hide-if-no-paging">
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                <ul class="pagination pagination-centered"></ul>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </LayoutTemplate>
                            <GroupTemplate>
                                <tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                </tr>
                            </GroupTemplate>
                            <ItemTemplate>
                                <td class="col-md-2">
                                    <div class='thumbnail' style='height: 220px'>
                                        <a href='<%#"Exp31-Working_with_Repeaters.aspx?cropname=" + Eval("cropname")%>'>
                                            <asp:Image ID="Image2" runat="server" class="img-rounded"
                                                ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("bestPlantingId")%>' />
                                            <p>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"
                                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                                <br>
                                                <i>
                                                    <small id="sci-name">Scientific name
                                                    </small>
                                                </i>
                                                <br>
                                        </a>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("plantedtimes", "Planted times:{0}") %>'
                                            Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                        </p>
                                    </div>
                                </td>
                            </ItemTemplate>
                        </asp:ListView>
                        <div>
                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div>
            <h2>Documentation</h2>
            <p>1. To achieve pagination , I am using a Jquery plugin called Footable.</p>
            <p>2. To use this plugin we have to include the following files. </p>
            <pre>
                < script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">< /script>
    
    < script src="js/footable.js" type="text/javascript">< /script>
    < script src="js/footable.paginate.js" type="text/javascript">< /script>
            </pre>
            <p>
                3. We have add a class called Footable to the table which displays the data.
            </p>
            <p>
                4. We can set the page size limit as follows
            </p>
            <pre>
                < table id="cropresultstable" class="row footable" data-page-size="1">
            </pre>
            <p>5. To display page numbers, we need to set up a template in the tfoot of the table</p>
            <pre>
                   < tfoot class="hide-if-no-paging">
                                        < tr>
                                            <  colspan="5" class="text-center">
                                                < ul class="pagination pagination-centered"></ul>
                                            
                                        < /tr>
                                    < /tfoot>
            </pre>
        </div>
        <hr />
        
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp30-ListGrid-dynamic-update.aspx" target="_blank">Link to aspx file</a> <br />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp30-ListGrid-dynamic-update.aspx.cs" target="_blank">Link to cs file</a> <br />
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">Link to DAO file</a> <br />

        <hr />
        <div>
            <h2>
                References
            </h2>
            <a href="http://fooplugins.com/footable-demos/" target="_blank">1. Footable Demos</a>
        </div>
    </div>
</body>
</html>

