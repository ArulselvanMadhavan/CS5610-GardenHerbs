<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="project_Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GardenHerbs</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <%--StyleSheets--%>

    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/imageFlipper/imageFlipper.css" />
    <link rel="stylesheet" href="~/project/css/home/masterStyle.css" />
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/carousal/responsive-carousel.css" media="screen">
    <link rel="stylesheet" href="css/carousal/responsive-carousel.fade.css" media="screen">

    <%--JavaScripts--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <%--<script src="js/footable/footable.js" type="text/javascript"></script>
    <script src="js/footable/footable.paginate.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            $('.footable').footable({
                breakpoints: {
                    phone: 720,
                    tablet: 720
                }
            });
        });--%>
    <%--</script>--%>
    <%--<link href="//cdn.datatables.net/responsive/1.0.2/css/dataTables.responsive.css" rel="stylesheet" />--%>
    <!--js files for carousal-->
    <script src="js/carousal/responsive-carousel.js"></script>
    <script src="js/carousal/responsive-carousel.autoplay.js"></script>
    <script src="js/carousal/responsive-carousel.autoinit.js"></script>

    <%--    <script src="//cdn.datatables.net/responsive/1.0.2/js/dataTables.responsive.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#recentUploads').DataTable({
                responsive: true
            });
        });
    </script>--%>
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
            <div class="content">

                <!-- CAROUSAL START  -->
                <div class="carousel" data-transition="fade" data-autoplay>

                    <div>
                        <img src="images/carousal/carousal1.jpg" class="img_carousal">
                    </div>
                    <div>
                        <img src="images/carousal/carousal2.jpg" class="img_carousal" />
                    </div>
                    <div>
                        <img src="images/carousal/carousal3.jpg" class="img_carousal" />
                    </div>
                    <div>
                        <img src="images/carousal/carousal4.jpg" class="img_carousal" />
                    </div>
                </div>

                <div class="d_recentUplodsHolder">
                    <div>
                        <h3>Recent Uploads</h3>
                    </div>

                    <%--  <asp:ListView ID="recentUploads" runat="server" GroupItemCount="4" GroupPlaceholderID="groupPlaceHolder1"
                        ItemPlaceholderID="itemPlaceHolder1">
                        <LayoutTemplate>
                            <table id="recentimagesTable"  data-page-size="1">
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                            </table>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <tr>
                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                            <td class="eachImage col-md-4">
                                <div class="flip-container col-md-4">
                                    <div class="flipper">
                                        <div class="front">
                                            <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                                <asp:Image ID="Image1" runat="server" CssClass="imgRecentUploads col-md-4"
                                                    ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId=" + Eval("uploadId") %>' />
                                            </a>
                                        </div>
                                        <div class="back">
                                            <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                                <table>
                                                    <tbody>
                                                        <tr class="back-logo">
                                                            <div class="d_minilogo">
                                                                <asp:Image ID="minilogo" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                                            </div>
                                                        </tr>
                                                        <tr>
                                                            <div class="back-title"><%# Eval("cropName") %></div>
                                                        </tr>
                                                        <tr>
                                                            <p>Planted On:</p>
                                                            <p><%#Eval("plantedOn")%></p>
                                                            <p>By: <%#Eval("userName") %></p>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </a>
                                        </div>


                                    </div>
                                </div>

                                
                            </td>
                        </ItemTemplate>
                    </asp:ListView>--%>
                    <%--      <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                                <div>
                                                    <asp:Image ID="Image1" runat="server" CssClass="imgRecentUploads"
                                                        ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId=" + Eval("uploadId") %>' />
                                                </div>
                                            </a>--%>




                    <%--  <asp:DataList ID="recentUploads" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                            Width="100%" BorderColor="#336699" BorderStyle="None" BorderWidth="2px" CssClass="footable">
                            <ItemTemplate>
                                <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                    <asp:Image ID="Image1" runat="server" CssClass="imgRecentUploads"
                                            ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId=" + Eval("uploadId") %>' />
                                </a>
                                <br />
                            </ItemTemplate>
                        </asp:DataList>--%>
                    <%-- <a runat="server" id="a_recentUpload1">
                        <div id="img_container3" class="hover">
                            <div id="flipper3" class="shadow">
                                <div class="front face3">
                                    <asp:Image ID="Image1" runat="server" CssClass="imgRecentUploads col-md-4" />
                                </div>
                                <div class="back face3 center">
                                    <p><b>LOOKING FOR THE RIGHT HOSPITAL?</b></p>
                                    <p>We help you to search any hospital in United States</p>
                                    <p id="hosp_link_text">Search Hospital Now!</p>

                                </div>
                            </div>
                        </div>
                    </a>--%>



                    <%--<div class="flipper">
                        <div class="front">
                            <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                <asp:Image ID="Image5" runat="server" CssClass="imgRecentUploads col-md-4"
                                    ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId=" + Eval("uploadId") %>' />
                            </a>
                        </div>
                        <div class="back">
                            <a href='<%# "cropDetails.aspx?cropid="+ Eval("uploadId")%>'>
                                <table>
                                    <tbody>
                                        <tr class="back-logo">
                                            <div class="d_minilogo">
                                                <asp:Image ID="minilogo" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                            </div>
                                        </tr>
                                        <tr>
                                            <div class="back-title"><%# Eval("cropName") %></div>
                                        </tr>
                                        <tr>
                                            <p>Planted On:</p>
                                            <p><%#Eval("plantedOn")%></p>
                                            <p>By: <%#Eval("userName") %></p>
                                        </tr>
                                    </tbody>
                                </table>
                            </a>
                        </div>--%>


                    <div class="d_recentImagesHolder">

                        <div id="f_container1" class="col-md-3 flip-container">
                            <div class="flipper">
                                <div class="front">
                                    <a id="a_recentUpload1" runat="server">
                                        <asp:Image ID="Image1" runat="server" CssClass="imgRecentUploads col-md-4" />
                                    </a>
                                </div>
                                <div class="back">
                                    <a id="a1" runat="server">
                                        <div class="d_minilogo">
                                            <asp:Image ID="Image6" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                        </div>
                                        <div class="back-title" id="title1" runat="server">
                                        </div>
                                        <p>Planted On:</p>
                                        <p id="r_plantedOn1" runat="server"></p>
                                        <p id="r_userName1" runat="server"></p>
                                    </a>
                                </div>
                            </div>
                        </div>


                        <div id="f_container2" class="flip-container  col-md-3">
                            <div class="flipper">
                                <div class="front">
                                    <a id="a_recentUpload2" runat="server">
                                        <asp:Image ID="Image2" runat="server" CssClass="imgRecentUploads col-md-4" />
                                    </a>
                                </div>
                                <div class="back">
                                    <a id="a4" runat="server">
                                        <div class="d_minilogo">
                                            <asp:Image ID="Image8" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                        </div>
                                        <div class="back-title" id="title2" runat="server">
                                        </div>
                                        <p>Planted On:</p>
                                        <p id="r_plantedOn2" runat="server"></p>
                                        <p id="r_userName2" runat="server"></p>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div id="f_container3" class="flip-container  col-md-3">
                            <div class="flipper">
                                <div class="front">
                                    <a id="a_recentUpload3" runat="server">
                                        <asp:Image ID="Image3" runat="server" CssClass="imgRecentUploads col-md-4" />
                                    </a>
                                </div>
                                <div class="back">
                                    <a id="a2" runat="server">
                                        <div class="d_minilogo">
                                            <asp:Image ID="Image5" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                        </div>
                                        <div class="back-title" id="title3" runat="server">
                                        </div>
                                        <p>Planted On:</p>
                                        <p id="r_plantedOn3" runat="server"></p>
                                        <p id="r_userName3" runat="server"></p>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div id="f_container4" class="flip-container  col-md-3">
                            <div class="flipper">
                                <div class="front">
                                    <a id="a_recentUpload4" runat="server">
                                        <asp:Image ID="Image4" runat="server" CssClass="imgRecentUploads col-md-4" />
                                    </a>
                                </div>
                                <div class="back">
                                    <a id="a3" runat="server">
                                        <div class="d_minilogo">
                                            <asp:Image ID="Image7" CssClass="minilogo" runat="server" ImageUrl="images/minilogo.png" />
                                        </div>
                                        <div class="back-title" id="title4" runat="server">
                                        </div>
                                        <p>Planted On:</p>
                                        <p id="r_plantedOn4" runat="server"></p>
                                        <p id="r_userName4" runat="server"></p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="footer">
                        <div id="footer_left">
                            &copy; Arulselvan Madhavan<br />
                            College of Computer and Information Science
                        </div>

                        <div id="footer_middle">
                            Northeastern University,<br />
                            Boston, MA
                        </div>

                        <div id="footer_right">
                            Site is best viewed in
                    <br />
                            <img src="images/chrome.png" style="width: 24px" />
                        </div>
                    </div>--%>
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
        </form>
    </div>
</body>
</html>
