<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrowseCrops.aspx.cs" Inherits="experiments_project_experiments_Exp29_ListGrid_dynamic_update" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>BrowseCrops</title>
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="js/bootstrap.min.js" rel="stylesheet" />
    <link rel="stylesheet" href="~/project/css/home/masterStyle.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/footable/footable.js" type="text/javascript"></script>
    <script src="js/footable/footable.paginate.js" type="text/javascript"></script>
    <link href="css/browseCrops/browseCrops.css" rel="stylesheet" />
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
</head>
<body>
    <div class="container">
        <form id="form2" runat="server">
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
            <%--Main Content of the page--%>
            <div id="cropform" runat="server">
                <h3>Listed below are the various crops that our site currently supports. We plan to add new additions based on user requests.</h3>
                <div class="col-md-12 d_displayPanel">
                    <asp:ListView ID="CropList" runat="server" GroupItemCount="4" GroupPlaceholderID="groupPlaceHolder1"
                        ItemPlaceholderID="itemPlaceHolder1">
                        <LayoutTemplate>
                            <table id="cropresultstable" class="row footable" data-page-size="2">
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
                            <div>
                            <td class="col-md-2">
                                <div id="d_thumbnail_holder" class="d_thumbnail_holder" style='height: 320px'>
                                    <a href='<%# "CropDetails.aspx?cropId="+Eval("bestPlantingId") %>' >
                                        <asp:Image ID="Image2" runat="server" class="img-rounded"
                                            ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("bestPlantingId")%>' />
                                        <p>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("cropname") %>' Font-Bold="True"
                                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                            <br>
                                            <i>
                                                <small id="sci-name"><%# Eval("cropScientificName") %>
                                                </small>
                                            </i>
                                            <br>
                                    </a>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("plantedtimes", "Planted times:{0}") %>'
                                        Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                    </p>
                                </div>
                            </td>
                                </div>
                        </ItemTemplate>
                    </asp:ListView>
                    <div>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                </div>
            </div>

              <div class="footer">
                        <div id="footer_left" class="pull-left">
                            <p class=fleft>&copy; Arulselvan Madhavan<br />
                            CCIS,Northeastern University,MA.</p>
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

