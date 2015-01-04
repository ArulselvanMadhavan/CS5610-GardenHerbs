<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchCrops-with-Master.aspx.cs" Inherits="project_searchCrops" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Search Crops</title>
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<%--    <link href="css/searchCrop/searchBar.css" rel="stylesheet" />
    <link href="css/searchCrop/searchCrop.css" rel="stylesheet" />--%>
    <link href="css/searchCrop/Search.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link href="js/bootstrap.min.js" rel="stylesheet" />
</head>
<body>
    <div class="wrapper">
        <div id="cropform" runat="server">
<%--            <asp:LoginName ID="LoginName1" runat="server" CssClass="pull-right" />
            <asp:LoginStatus ID="LoginStatus1" runat="server" CssClass="pull-right" />--%>
            <div class="search-bar-wrapper">
                <table class="t_searchBar">
                    <tr>
                        <td class="searchText">
                            <input type="text" id="search" runat="server" placeholder="Enter a crop to Search ...." maxlength="20" required>
                        </td>
                        <td class="searchButton">
                            <asp:Button ID="findCrops"  runat="server" OnClick="submit_Click" Text="Find Crops" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:Repeater ID="searchResults" runat="server">
                <ItemTemplate>
                    <div class="d_searchResultsWrapper">
                        <table class="tbl_searchResults">
                            <tbody>
                                <tr>
                                    <td class="imgHolder">
                                        <asp:Image ID="img_searchResult" CssClass="imgResults img-responsive img-thumbnail" runat="server" ImageUrl='<%# "~/project/webhandler/CropImage.ashx?uploadId="+Eval("uploadId")%>' />
                                    </td>
                                    <td class="searchResultTextParentRow">
                                        <div class="top">
                                            <table>
                                                <tbody>
                                                    <tr class="cropDescription">
                                                        <td>
                                                            <span>Planted By </span>
                                                        </td>
                                                        <td>
                                                            <a href="Exp32-Building_profile_page.aspx?username='<%#Eval ("userName") %>'"><%# ": " + Eval ("userName") %></a>
                                                        </td>
                                                    </tr>
                                                    <tr class="cropDescription">
                                                        <td>
                                                            <span>Crop Name</span>
                                                        </td>
                                                        <td>
                                                            <span>: <i><%#Eval("cropName")%> </i>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr class="cropDescription">
                                                        <td>
                                                            <span>Planted On</span>
                                                        </td>
                                                        <td>
                                                            <span>: <%#Eval("plantedOn") %> </span>
                                                        </td>
                                                    </tr>
                                                    <tr class="cropDescription">
                                                        <td>
                                                            <span>Number of Endorsements</span>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_endorsedUsersTotal" runat="server" Text='<%# ": " + getendorsedUsersCount(Eval("endorsedUsers").ToString())%>'></asp:Label>
                                                            <%--<span>: <%#Eval("endorsedUsers") %></span>--%>
                                                        </td>
                                                    </tr>
                                                    <tr class="cropDescription cropDescriptionlastRow">
                                                        <td colspan="2">
                                                            <a href='<%# "CropDetails.aspx?cropId="+Eval("uploadId") %>' class="btn-block btn-link btn-primary">Click Here to view more details</a>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <hr />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</body>
</html>
