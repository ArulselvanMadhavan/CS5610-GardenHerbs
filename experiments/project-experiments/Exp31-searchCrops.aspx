<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp31-searchCrops.aspx.cs" Inherits="project_searchCrops" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Crops</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/searchCrops/searchCrop/searchBar.css" rel="stylesheet" />
    <%--<link href="js/bootstrap.min.js" rel="stylesheet" />--%>
    <link rel="stylesheet" href="css/searchCrops/masterStyle.css" />
    <link href="css/searchCrops/searchCrop/searchCrop.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
    <div>
        <h2>Experiment 31: Working with Repeaters</h2>
        <h3>Purpose of the Experiment:</h3>
        In my project, I am allowing the user to search for crops supported by my project website. For this purpose, I decided to learn to work with repeaters. 
        This experiment helped me understand how repeaters work and how they should be configured.
    </div>
    <p><b>Disclaimer:</b>As this is just an experiment, I have inserted only few records to search . But the code should work handle any number of search results. </p>
    <p>Try typing letters that will search for potato or letters that will search for tomato. </p>
    <hr />
    <div class="container">
        <form id="form1" runat="server">
            <div class="header">
                <div id="d_firstRow">
                    <%-- <div id="logo">
                        <img id="logo_img" src="images/logo.png" />
                    </div>--%>
                    <div id="d_loggedInUser" class="pull-right">
                        <asp:LoginName ID="LoginName1" runat="server" CssClass="pull-right" />
                    </div>
                </div>
                <%-- <div id="sublogo" style="width: 100%">
                    <img id="imgsublogo" class="pull-right" src="images/log-subtext.png" />
                </div>--%>
            </div>
            <!-- LOGO END -->
            <!-- MENU START -->
            <div class="navHolder">
                <nav>
                    <ul>
                        <li><a href="#" class="cl-effect-8">Home</a></li>
                        <li><a href="#" class="cl-effect-8">Search Crops</a></li>
                        <li><a href="#" class="cl-effect-8">Browse Crops</a></li>
                        <li><a href="#" class="cl-effect-8">Crop Suggestor</a></li>
                        <li><a href="#" class="cl-effect-8">Farmers Market</a></li>
                        <li><a href="#" class="cl-effect-8">Check Weather</a></li>
                        <li>
                            <asp:LoginStatus ID="LoggedInStatus" runat="server" CssClass="cl-effect-8" />
                        </li>
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
                            <input type="text" id="search" runat="server" placeholder="Enter a crop to Search ...." maxlength="20" required>
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
                                        <asp:Image ID="img_searchResult" CssClass="imgResults img-responsive" runat="server" ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("uploadId")%>' />
                                    </div>
                                </div>
                                <div class="d_resultsHolder">
                                    <div class="d_selector">
                                        <span>Planted By </span>
                                    </div>
                                    <div class="d_result">
                                        <a href="Exp32-Building_profile_page.aspx?username='<%#Eval ("userName") %>'"><%# Eval ("userName") %> </a>
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
    </div>
    <div>
        <h3>Documentation:</h3>
        <p>1.Repeaters repeat data from a datasource that is binded to them.</p>
        <p>2. In this experiment, I am querying the data from the DB and assigning the search results to the repeater.</p>
        <p>3.Based on the Itemtemplate that we define for the repeater , the repeater assigns the table row from the datasource to the ItemTemplate and renders the content to the user.</p>
        <pre>
            ItemTemplate:
            < div class="d_searchResultsWrapper">
                                < div class="d_imgHolder">
                                    < div class="d_imgWrapper">
                                        < img ID="img_searchResult" CssClass="imgResults img-responsive" ImageUrl="~/project/webhandler/CropImage.ashx?uploadId="+Eval("uploadId") />
                                    < /div>
                                < /div>
                                < div class="d_resultsHolder">
                                    < div class="d_selector">
                                        < span>Planted By < /span>
                                    < /div>
                                    < div class="d_result">
                                        < a href="Exp32-Building_profile_page.aspx?username=Eval ("userName")  > Eval ("userName") < /a>
                                    < /div>
                                   < div class="d_selector">
                                        < span>Crop Name< /span>
                                    < /div>
                                    < div class="d_result">
                                        < >< i>Eval("cropName")< /i>
                                       
                                    < /div>
                                    < div class="d_selector">
                                        < span>Planted On< /span>
                                    < /div>
                                    < div class="d_result">
                                        < span> Eval("plantedOn") < /span>
                                    < /div>
                                    < div class="d_selector">
                                        < span>Endorsements< /span>
                                    < /div>
                                    < div class="d_result">
                                        < span ID="lbl_endorsedUsersTotal" Text= getendorsedUsers(userName)/> 
                                    < /div>
                                    < div class="d_lastRow">
                                        < a href="CropDetails.aspx?cropId="+Eval("uploadId")  class="btn-block btn-link btn-primary">Click Here to view more details< /a>
                                    < /div>
                                < /div>
                            < /div>
        </pre>
        <p>4. Note: Please refer the source of this file for the exact Itemtemplate. The template shown is just a sample which doesn't include server tags as the page will show an error if server tags are included inside html.</p>
    </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp31-searchCrops.aspx" target="_blank">Link to aspx file</a>
    <br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp31-searchCrops.aspx.cs" target="_blank">Link to cs file</a>
    <br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">Link to DAO file</a>
    <br />
    <hr />
    <div>
        <h2>References</h2>
        <a href="http://www.w3schools.com/aspnet/aspnet_repeater.asp" target="_blank">1. W3Schools</a> <br />
        <a href="http://msdn.microsoft.com/en-us/library/zzx23804(v=vs.85).aspx" target="_blank">2. MSDN</a>
    </div>
</body>
</html>
