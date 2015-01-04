<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cropSuggestor.aspx.cs" Inherits="experiments_project_experiments_Exp25_Grid_View_Pagination" %>


<%--<%@ Import Namespace="System.Web" %>
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
<%@ Import Namespace="System.Net" %>--%>
<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>CropSuggestor</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
    <%--<link href="~/experiments/project-experiments/css/bootstrap.css" rel="Stylesheet" />--%>
    <link href="css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="js/bootstrap.min.js" rel="stylesheet" />
    <%--<link rel="stylesheet" href="~/project/css/home/masterStyle.css" />--%>
    <link rel="stylesheet" href="css/cropSuggestor/master.css" />
    <link rel="stylesheet" href="css/cropSuggestor/cropSuggestor.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/footable/footable.js" type="text/javascript"></script>
    <script src="js/footable/footable.paginate.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/cropSuggestor/loader.css" />
    <%--   <style type="text/css">
    .modal
    {
        position: fixed;
        top: 0;
        left: 0;
        background-color: black;
        z-index: 99;
        opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
        min-height: 100%;
        width: 100%;
    }
    .loading
    {
        font-family: Arial;
        font-size: 10pt;
        border: 5px solid #67CFF5;
        width: 200px;
        height: 100px;
        display: none;
        position: fixed;
        background-color: White;
        z-index: 999;
    }
</style>--%>
    <script type="text/javascript">
        $(function () {
            $('#<%=g_census_Results.ClientID %>').footable({
                breakpoints: {
                    phone: 340,
                    tablet: 770
                }
            });
        });


    </script>

    <%--  <script type="text/javascript">
        function ShowProgress() {
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });
            }, 200);
        }
        $('form').live("#btn_getpastdata", function () {
            ShowProgress();
        });
        (jQuery)
</script>--%>
    <%--<script type="text/javascript">
        $(function my2() {
            $('#<%=g_census_Results.ClientID %>').trigger('footable_redraw');
        });
       </script>--%>

    <script type="text/javascript">
        //function HideGrid() {
        //    id = document.getElementById("UpdatePanel1");
        //    if (!(id == null)) {
        //        id.style.display = "none";
        //    }
        //}
    </script>
</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
            <div class="header">
                <div id="d_firstRow">
                    <div id="logo">
                        <img id="logo_img" src="images/logo.png" />
                    </div>
                    <div>
                        <asp:LoginStatus ID="a_loginStatus" runat="server" CssClass="pull-right" />
                    </div>
                    <div id="d_loggedInUser" class="pull-right">
                        <asp:LoginName ID="LoginName1" runat="server" CssClass="pull-right" />
                    </div>
                </div>
                <div id="sublogo" style="width: 100%">
                    <img id="imgsublogo" class="pull-right" src="images/log-subtext.png" />
                </div>
            </div>

            <!-- LOGO END -->


            <!-- MENU START -->
            <div class="navHolder">
                <nav>
                    <ul>
                        <li><a href="Home.aspx" class="cl-effect-8">Home</a></li>
                        <li><a href="searchCrops.aspx" class="cl-effect-8">Search Crops</a></li>
                        <li><a href="BrowseCrops.aspx" class="cl-effect-8">Browse Crops</a></li>
                        <li><a href="../protected/uploadPlantings.aspx" class="cl-effect-8">Upload Crop</a></li>
                        <li><a href="cropSuggestor.aspx" class="cl-effect-8">Crop Suggestor</a></li>
                        <li><a href="farmersMarket.aspx" class="cl-effect-8">Farmers Market</a></li>
                        <li><a href="weatherForecast.aspx" class="cl-effect-8">Check Weather</a></li>
                        <%--<li>
                            <asp:LoginStatus ID="LoggedInStatus" runat="server" CssClass="cl-effect-8" />
                        </li>--%>
                    </ul>
                </nav>
            </div>

            <h3 class="explainText">We understand how much a bad farming decision can affect. Use our Crop Suggestor to find what crops have best sale value in your area.</h3>
            <h3 class="explainText">Garden Herbs provides you access to the most recent census taken by US Department of Agriculture.</h3>
            <h3 class="explainText">Please select an option and then click Fetch Crop Stats button</h3>
            <div class="d_optionsrow">
                <div id="optionElementsDD1" class="d_optionElements">
                    <div id="lbl_state">
                        <asp:Label ID="lbl_State" CssClass="stateSelector" runat="server">Select Your State</asp:Label>
                    </div>
                    <div id="ddl_state">
                        <select name="ddl_statelist" id="ddl_statelist" runat="server" required autofocus></select>
                        <%--<asp:DropDownList ID="ddl_statelist" runat="server" AutoPostBack="true"  ClientIDMode="Inherit" OnSelectedIndexChanged="ddl_Statelist_SelectedIndexChanged" placeholder="Select Your State"></asp:DropDownList>--%>
                    </div>
                </div>
                <%--<div class="d_optionElements">
                    <select name="ddl_statelist" id="ddl_statelist" runat="server" required autofocus>
                    </select>
                </div>--%>



                <div id="optionElementsDD2" class="d_optionElements">
                    <div id="lbl_zip">
                        <asp:Label ID="lbl_ZipCode" CssClass="stateSelector" runat="server">Stats Category</asp:Label>
                    </div>

                    <div id="ddl_zip">
                        <select id="ddl_statscriteria" runat="server">
                            <option value="SALES">Find Crops that had maximum sales</option>
                            <option value="PRODUCTIONVALUE">Find Crops that have maximum yield.</option>
                            <option value="HARVESTEDAREA">Find Crops that was harvested the most.</option>
                        </select>
                    </div>
                </div>

                <%-- <div class="d_optionElements">
                    <select id="ddl_statscriteria" runat="server">
                        <option value="SALES">Find Crops that had maximum sales</option>
                        <option value="PRODUCTIONVALUE">Find Crops that have maximum yield.</option>
                        <option value="HARVESTEDAREA">Find Crops that was harvested the most.</option>
                    </select>
                </div>--%>

                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <%--  <script type="text/javascript">
                        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(my2);
                    </script>--%>
                <asp:UpdatePanel ID="updateStats" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div id="optionElementsButton" class="d_optionElements">
                            <asp:Button ID="btn_getpastdata" runat="server" CssClass="btnctrl"
                                Text="Fetch Crop Stats"
                                OnClick="btn_getpastdata_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
            <%--<div id="d_loader" class="loader" runat="server">Fetching Data....</div>--%>
            <%--  <table class="t_getpastdata">
                    <tr>
                        <td class="b_getpastdata">
                         
                        </td>
                        <td></td>
                    </tr>
                </table>--%>
            <asp:UpdateProgress ID="updProgress"
                AssociatedUpdatePanelID="updateStats"
                runat="server">
                <ProgressTemplate>
                    <div id="d_loader" class="loader" runat="server">Fetching Data.... </div>

                    <script type="text/javascript">
                        if (!($get("UpdatePanel1")) == null) {
                            var c = new Sys.UI.Control($get("UpdatePanel1"));



                            //var grid = new Sys.UI.Control($get("g_census_Results"));

                            function beginRequestHandler(sender, args) {
                                //c.set_visible(false);
                                //c.style.display = "none";
                                $('#g_census_Results').css("display", "none")
                            }


                            function endRequestHandler(sender, args) {
                                //c.set_visible(true);
                                //c.style.display = "";
                                $('#g_census_Results').css("display", "")
                                $('#g_census_Results').trigger('footable_redraw');
                            }


                            function pageLoad() {
                                Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequestHandler);
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequestHandler);
                            }
                        }
                        var prm = Sys.WebForms.PageRequestManager.getInstance();

                        prm.add_endRequest(function () {
                            // re-bind your jQuery events here
                            $('#<%=g_census_Results.ClientID %>').footable({
                                breakpoints: {
                                    phone: 340,
                                    tablet: 770
                                }
                            });
                            $('#<%=g_census_Results.ClientID %>').trigger('footable_redraw');
                        });
                    </script>
                </ProgressTemplate>

            </asp:UpdateProgress>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <%--   <script type="text/javascript">
                        Sys.Application.add_load(my2);
                    </script>
                    <script type="text/javascript">
                        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(my2);
                    </script>--%>
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
                    <script type="text/javascript">
                        $('#<%=g_census_Results.ClientID %>').trigger('footable_redraw');
                    </script>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="footer">
                <div id="footer_left" class="pull-left">
                    <p class="fleft">
                        &copy; Arulselvan Madhavan<br />
                        CCIS,Northeastern University,MA.
                    </p>
                </div>


                <div id="footer_right" class="pull-right">
                    <p class="fleft">Site is best viewed in</p>

                    <img src="images/chrome.png" style="width: 24px" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
