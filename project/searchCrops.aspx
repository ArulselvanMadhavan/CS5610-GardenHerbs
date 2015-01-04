<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchCrops.aspx.cs" Inherits="project_searchCrops" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Crops</title>
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="css/searchCrop/searchBar.css" rel="stylesheet" />
    <link href="js/bootstrap.min.js" rel="stylesheet" />
    <link rel="stylesheet" href="~/project/css/home/masterStyle.css" />
    <link href="css/searchCrop/searchCrop.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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

            <%--Main Content of the page--%>
            <div id="cropform" runat="server">
                <h3>Search for Your Favorite Crops Here</h3>
                <%--<table>
                    <tr>
                        <td class="searchPadLeft"></td>
                        <td class="searchBarHolder">--%>
                <div class="searchBarHolder">
                    <div class="search-bar-wrapper">
                        <%--<table class="t_searchBar">
                                    <tr>
                                        <td class="searchText">--%>
                        <div class="searchText">
                            <input type="text" id="search" runat="server" placeholder="ex: potato, apple..." maxlength="15" required>
                        </div>
                        <%--</td>
                                        <td class="searchButton">--%>
                        <div class="searchButton">
                            <asp:Button ID="findCrops" runat="server" OnClick="submit_Click" Text="Find Crops" />
                        </div>
                        <%-- </td>
                                    </tr>
                                </table>--%>
                    </div>
                </div>
                <%-- </td>
                        <td class="searchPadRight"></td>
                    </tr>
                </table>--%>
                <div class="searchResultsHolder">
                    <asp:Repeater ID="searchResults" runat="server">
                        <ItemTemplate>
                            <div class="d_searchResultsWrapper">
                                <div class="d_imgHolder">
                                    <div class="d_imgWrapper">
                                        <a href='<%# "CropDetails.aspx?cropId="+Eval("uploadId") %>'>
                                        <asp:Image ID="img_searchResult" CssClass="imgResults img-responsive" runat="server" ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("uploadId")%>' /></a>
                                    </div>
                                </div>
                                <div class="d_resultsHolder">
                                    <div class="d_selector">
                                        <span>Planted By </span>
                                    </div>
                                    <div class="d_result">
                                        <a href="userDetails.aspx?username=<%#Eval ("userName") %>"><%# Eval ("userName") %> </a>
                                    </div>
                                    <div class="d_selector">
                                        <span>Crop Name</span>
                                    </div>
                                    <div class="d_result">
                                        <span><i><%#Eval("cropName")%> </i>
                                        </span>
                                    </div>
                                    <div class="d_selector">
                                        <span>Planted On</span>
                                    </div>
                                    <div class="d_result">
                                        <span><%#Eval("plantedOn") %> </span>
                                    </div>
                                    <div class="d_selector">
                                        <span>Endorsements</span>
                                    </div>
                                    <div class="d_result">
                                        <asp:Label ID="lbl_endorsedUsersTotal" runat="server" Text='<%# getendorsedUsersCount(Eval("endorsedUsers").ToString())%>'></asp:Label>
                                    </div>
                                    <div class="d_lastRow">
                                        <a href='<%# "CropDetails.aspx?cropId="+Eval("uploadId") %>' class="btn-block btn-link btn-primary">Click Here to view more details</a>
                                    </div>
                                </div>
                            </div>
                            <hr />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </form>
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
    </div>
</body>
</html>
