<%@ Page Language="C#" AutoEventWireup="true" CodeFile="weatherForecast.aspx.cs" Inherits="Project_weatherForecast" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GardenHerbs- WeatherForecast</title>
    <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
    <%--<link href="~/experiments/project-experiments/css/bootstrap.css" rel="Stylesheet" />--%>
    <link href="css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="js/bootstrap.min.js" rel="stylesheet" />
    <link rel="stylesheet" href="css/cropSuggestor/master.css" />
    <%--<link rel="stylesheet" href="~/project/css/home/masterStyle.css" />--%>
    <link rel="stylesheet" href="css/farmersMarket/farmersMarket.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/footable/footable.js" type="text/javascript"></script>
    <script src="js/footable/footable.paginate.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/cropSuggestor/loader.css" />
    <script type="text/javascript">
        $(function () {
            $('#<%=g_forecastResults.ClientID %>').footable({
                breakpoints: {
                    phone: 340,
                    tablet: 770
                }
            });
        });
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

            <h3 class="explainText">GardenHerbs gives you a 5 day weather forecast so that you can protect your crops from getting affected by weather conditions.</h3>
            <h3 class="explainText">The weather Statistics are fetched from worldweatherOnline API.</h3>
            <h3 class="explainText">Please select your State and Zipcode to find the weather forecast for your location.</h3>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <div class="d_optionsrow">

                <asp:UpdatePanel ID="update_Statelist" runat="server">
                    <ContentTemplate>
                        <div id="optionElementsDD1" class="d_optionElements">
                            <div id="lbl_state">
                                <asp:Label ID="lbl_State" CssClass="stateSelector" runat="server">Select Your State</asp:Label>
                            </div>
                            <div id="ddl_state">
                                <asp:DropDownList ID="ddl_statelist" runat="server" AutoPostBack="true" ClientIDMode="Inherit" OnSelectedIndexChanged="ddl_Statelist_SelectedIndexChanged" placeholder="Select Your State"></asp:DropDownList>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddl_statelist" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="updateZip" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div id="optionElementsDD2" class="d_optionElements">
                            <div id="lbl_zip">
                                <asp:Label ID="lbl_ZipCode" CssClass="stateSelector" runat="server">ZipCode</asp:Label>
                            </div>

                            <div id="ddl_zip">
                                <select name="ddl_zipCodeList" id="ddl_zipCodeList" class="ddl_zipCode" runat="server" required autofocus>
                                </select>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddl_statelist" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="updateStats" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div id="optionElementsButton" class="d_optionElements">
                            <asp:Button ID="btn_getpastdata" runat="server" CssClass="btnctrl"
                                Text="Fetch Weather Data"
                                OnClick="btnWeatherForecast_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="d_error">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </div>
            <asp:UpdateProgress ID="updProgress"
                AssociatedUpdatePanelID="updateStats"
                runat="server">
                <ProgressTemplate>
                    <div id="d_loader" class="loader" runat="server">Fetching Data.... </div>

                    <script type="text/javascript">
                        if (!($get("update_MarketDetails")) == null) {
                            var c = new Sys.UI.Control($get("update_MarketDetails"));
                            function beginRequestHandler(sender, args) {
                                //c.set_visible(false);
                                //c.style.display = "none";
                                $('#g_forecastResults').css("display", "none")
                            }


                            function endRequestHandler(sender, args) {
                                //c.set_visible(true);
                                //c.style.display = "";
                                $('#g_forecastResults').css("display", "")
                                $('#g_forecastResults').trigger('footable_redraw');
                            }


                            function pageLoad() {
                                Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequestHandler);
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequestHandler);
                            }
                        }
                        var prm = Sys.WebForms.PageRequestManager.getInstance();

                        prm.add_endRequest(function () {
                            // re-bind your jQuery events here
                            $('#<%=g_forecastResults.ClientID %>').footable({
                                breakpoints: {
                                    phone: 340,
                                    tablet: 770
                                }
                            });
                            $('#<%=g_forecastResults.ClientID %>').trigger('footable_redraw');
                        });
                    </script>
                </ProgressTemplate>

            </asp:UpdateProgress>

            <asp:UpdatePanel ID="update_MarketDetails" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="g_forecastResults" runat="server" OnRowCreated="onRowCreate" ShowFooter="true" AutoGenerateColumns="false" CssClass="footable" data-page-size="5" OnPreRender="g_forecastResults_PreRender">

                        <Columns>
                            <asp:BoundField ReadOnly="True" HeaderText="Date" ItemStyle-Width="10%"
                                DataField="date"></asp:BoundField>
                            <asp:ImageField HeaderText="Weather Image" DataImageUrlField="weatherIconUrl" ItemStyle-Width="10%">
                            </asp:ImageField>
                            <asp:BoundField HeaderText="Description" ItemStyle-Width="20%"
                                DataField="WeatherDesc"></asp:BoundField>
                            <asp:BoundField HeaderText="Temp Max(F)" ItemStyle-Width="15%"
                                DataField="tempMaxF"></asp:BoundField>
                            <asp:BoundField HeaderText="Temp Min(F)" ItemStyle-Width="15%"
                                DataField="tempMinF"></asp:BoundField>
                            <asp:BoundField HeaderText="Windspeed in Miles" ItemStyle-Width="15%"
                                DataField="windspeedMiles"></asp:BoundField>
                            <asp:BoundField HeaderText="Wind Direction" ItemStyle-Width="10%"
                                DataField="Wind Direction"></asp:BoundField>
                            <asp:BoundField HeaderText="Wind Direction Degree" ItemStyle-Width="15%"
                                DataField="Wind Direction Degree"></asp:BoundField>
                            <%--    <asp:BoundField HeaderText="Humidity" ItemStyle-Width="10%"
                                DataField="humidity"></asp:BoundField>--%>
                            <asp:BoundField HeaderText="Precipitation in MM" ItemStyle-Width="10%"
                                DataField="Precip MM"></asp:BoundField>
                            <%--<asp:HyperLinkField DataNavigateUrlFields="npi" DataNavigateUrlFormatString="findPhysician-helper.aspx?npi={0}" HeaderText="More" Text="View Details" Target="_blank" />--%>
                        </Columns>
                    </asp:GridView>
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

<%--  <div class="d_searchResults">
    <table class="t_forecastResults">
    <tr>
    <td class="g_forecastResults">
        <asp:GridView ID="g_forecastResults" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        </td>
        </tr>
        </table>
    </div>
    <div>
    <table>
    <tr>
    <td>
    <p id="errorMsg" runat="server" visible="false" style="text-align: center; background-color: Silver; border: 1px dotted gray"></p>
    </tr>
    </table>
    </div>
    </form>--%>
