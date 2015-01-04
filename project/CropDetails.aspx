<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CropDetails.aspx.cs" Inherits="project_cropDetails_final" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GardenHerbs</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <%--StyleSheets--%>

    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <%--<link href="css/common/header.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="~/project/css/home/masterStyle.css" />
    <link href="css/cropDetails/cropDetail.css" rel="stylesheet" />
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

            <asp:Label runat="server" ID="lbl_PageLoadError"></asp:Label>

            <div id="cropform" runat="server">
                <h3 id="cropnameheader">
                    <asp:Label runat="server" ID="lbl_cropname"></asp:Label>
                </h3>
                <div class="div_cropimgholder" runat="server">
                    <asp:Image ID="img_crop" CssClass="img-responsive imgctrl" runat="server" />
                </div>
                <asp:Label ID="cropID" runat="server" Visible="false"></asp:Label>
                <asp:Label ID="endorsedUsers" runat="server" Visible="false"></asp:Label>
                <table class="croptable">
                    <tr class="row">
                        <td class="selector">
                            <span>Crop Scientific Name</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_crop_sciname" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Standard Production Practices</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_prod_practices" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />
                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Planted By</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <a id="a_plantedUser" runat="server" font-size="10pt" forecolor="#336699" width="100%"></a>
                                <%--<asp:Label ID="lbl_plantedUser" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />--%>
                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>User's method</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_userMethod" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Number of Plantings</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_Plantings" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Planted On</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_PlantedOn" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Source for Plantings</span>
                        </td>
                        <td colspan="2">
                            <i>
                                <asp:Label ID="lbl_PlantedFrom" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <tr class="row">
                        <td class="selector">
                            <span>Type of Shading </span>
                        </td>
                        <td>
                            <i>
                                <asp:Label ID="lbl_shadingMethod" runat="server"
                                    Font-Size="10pt" ForeColor="#336699" Width="100%" />

                            </i>
                        </td>
                    </tr>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <tr class="row" id="endorsedUsersCount" runat="server">
                        <td class="selector">
                            <span>Total Number of Endorsements: </span>
                        </td>
                        <td class="endorsedUsersCount">
                            <i>
                                <asp:UpdatePanel ID="update_EndorsedUsersCount" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="lbl_endorsedUsers" runat="server"
                                            Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </i>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="update_CommentBox" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btn_Endorse" CssClass="btnctrl" runat="server" Text='<%#"Click Here to " + getBtnEndorseText() + " this crop"%>' OnClick="btn_Endorse_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </td>
                    </tr>
                </table>
                <div>
                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                </div>
                <asp:UpdatePanel ID="updatePanel_commentBox" runat="server">
                    <ContentTemplate>
                        <div>
                            <asp:TextBox ID="Commentbox" runat="server" TextMode="MultiLine" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="div_commentbtn">
                            <%--<button id="btn_comment" class="btnctrl" runat="server" onclick="btn_comment_Click" > Post Your Comment</button>--%>
                            <asp:Button ID="btn_comment" CssClass="btnctrl" runat="server" Text="Post Your Comment" OnClick="btn_comment_Click" />
                        </div>

                        <br />

                        <div>
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </div>


                        <h3 id="h3_cropcomments">
                            <asp:Label ID="lbl_commentsHeader" runat="server"></asp:Label>
                        </h3>
                        <%--Do Not Rename anything without fully understanding the repercussions--%>
                        <div id="wallPostsHolder">
                            <div id="wallPostsWrapper">
                                <asp:Repeater ID="reptr_Comments" runat="server" OnItemCommand="reptr_Comments_ItemCommand">
                                    <ItemTemplate>
                                        <div class="d_postBox">
                                            <div id='<%# Eval("commentId") %>' class="comment_header">
                                                <div class="d_postBylogo">
                                                    <asp:Image ID="postedBYLogo" CssClass="postedBYLogo" runat="server" ImageUrl='<%# frameURL(Eval("userimg").ToString())%>' />
                                                </div>
                                                <div class="d_postedHeaderHolder">
                                                    <a class="postedUser" href="userDetails.aspx?username=<%# Eval ("userName") %>"><%# Eval ("userName") %>  </a>
                                                    <span class="s_CommentHeader">posted the below comments on </span>&nbsp<span><%# Eval ("commentedAt") %></span>
                                                </div>
                                            </div>
                                            <div class="postContent">
                                                <p class="panel-primary info voteForComment">
                                                    <asp:Label ID="comments" runat="server" Text='<%# Eval("comments") %>'></asp:Label>
                                                    <asp:TextBox ID="tb_comments" runat="server" Text='<%# Eval("comments") %>' Visible="false"></asp:TextBox>
                                                </p>
                                                <div class="d_likeRow">
                                                    <div class="d_likeData">
                                                        <asp:LinkButton ID="a_like" CommandName="likeComment" CommandArgument='<%#String.Format("{0}#{1}", Eval("commentId"),Eval("likedUsers"))%>' CssClass="btn-link" runat="server" Text='<%# getText(Container.ItemIndex) %>'></asp:LinkButton>
                                                    </div>
                                                    <div class="d_likeStatement">
                                                        <span runat="server" class="s_likeStatement"><%#getTotalLikes(Container.ItemIndex) %></span>
                                                    </div>
                                                    <div class="editCommentLinks">
                                                        <asp:LinkButton ID="a_Edit" CommandName="editComment" CommandArgument='<%# Eval("commentId")%> ' CssClass="btn-link" runat="server" Text='<%# getEditText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                                        <asp:LinkButton ID="a_Delete" CommandName="deleteComment" CommandArgument='<%# Eval("commentId")%>' CssClass="btn-link" runat="server" Text='<%# getDeleteText(Eval ("userName").ToString())%>'></asp:LinkButton>
                                                        <asp:LinkButton ID="a_Update" CommandName="updateComment" CommandArgument='<%#Eval("commentId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getUpdateText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                                        <asp:LinkButton ID="a_Cancel" CommandName="cancelComment" CommandArgument='<%# Eval("commentId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getCancelText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
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
