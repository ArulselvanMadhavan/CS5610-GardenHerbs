<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userDetails.aspx.cs" Inherits="project_userDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>userDetails</title>
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
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
            <div>
                <asp:Label ID="lbl_pageLoadError" runat="server"></asp:Label>
            </div>
            <div id="cropform" runat="server">
                <h3 id="usernameheader">
                    <asp:Label runat="server" ID="lbl_username"></asp:Label>
                    <asp:Label runat="server" ID="lbl_userID" Visible="false"></asp:Label>
                </h3>

                <div class="div_cropimgholder" runat="server">
                    <asp:Image ID="img_UserLogo" CssClass="img-responsive imgctrl" runat="server" />
                </div>
                <div class="d_userDetailsHolder">
                    <div class="d_userDetailsWrapper">
                        <div class="row d_row">
                            <div class="d_selector">
                                <span id="userFullName" class="selectorlabels" runat="server">UserName</span>
                            </div>
                            <div class="d_seperator">
                                <span>:</span>
                            </div>
                            <div class="d_value">
                                <asp:Label ID="lbl_userFullName" CssClass="valuelabels" runat="server"></asp:Label>
                                <%--<span id="lbl_userFullName" runat="server"></span>--%>
                            </div>
                        </div>
                        <div class="row d_row">
                            <div class="d_selector">
                                <span id="userLocation" class="selectorlabels" runat="server">Location of the User</span>
                            </div>
                            <div class="d_seperator">
                                <span>:</span>
                            </div>
                            <div class="d_value">
                                <asp:Label ID="lbl_userLocation" CssClass="valuelabels" runat="server"></asp:Label>
                                <%--<span id="lbl_userFullName" runat="server"></span>--%>
                            </div>
                        </div>
                        <div class="row d_row">
                            <div class="d_selector">
                                <span id="occupation" class="selectorlabels" runat="server">Occupation</span>
                            </div>
                            <div class="d_seperator">
                                <span>:</span>
                            </div>
                            <div class="d_value">
                                <asp:Label ID="lbl_occupation" CssClass="valuelabels" runat="server"></asp:Label>
                                <%--<span id="lbl_userFullName" runat="server"></span>--%>
                            </div>
                        </div>
                        <div class="row d_row">
                            <div class="d_selector">
                                <span id="Span2" class="selectorlabels" runat="server">Total Crops planted so far</span>
                            </div>
                            <div class="d_seperator">
                                <span>:</span>
                            </div>
                            <div class="d_value">
                                <asp:Label ID="lbl_plantedSoFar" CssClass="valuelabels" runat="server"></asp:Label>
                                <%--<span id="lbl_userFullName" runat="server"></span>--%>
                            </div>
                        </div>
                    </div>
                    <div class="d_error">
                        <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>
                    </div>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <div id="d_wall" runat="server">
                        <h3 id="wallHeader">
                            <asp:Label ID="lbl_wallHeader" runat="server"></asp:Label>
                        </h3>
                        <div id="d_postBox">
                            <div>
                                <asp:UpdatePanel ID="update_PostText" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txt_postContent" runat="server" TextMode="MultiLine" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="d_postbtn">
                                <asp:UpdatePanel ID="update_PostBox" runat="server">
                                    <ContentTemplate>
                                        <div class="div_commentbtn">
                                            <asp:Button ID="btn_post" CssClass="btnctrl" runat="server" Text="Submit your Post" OnClick="btn_post_Click" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="postheader">
                        <h3 id="postHeader">
                            <asp:Label ID="lbl_postHeader" runat="server" Visible="false"></asp:Label>
                        </h3>
                    </div>
                    <div id="wallPostsHolder">
                        <div id="wallPostsWrapper">
                            <asp:UpdatePanel ID="update_wallPosts" runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="reptr_Comments" runat="server" OnItemCommand="reptr_Comments_ItemCommand" OnItemDataBound="reptr_Comments_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="d_postBox">
                                                <div id='<%# Eval("postId") %>' class="post_header">
                                                    <div class="d_postBylogo">
                                                        <asp:Image ID="postedBYLogo" CssClass="postedBYLogo" runat="server" ImageUrl='<%# frameURL(Eval("userimg").ToString())%>' />
                                                    </div>
                                                    <div class="d_postedHeaderHolder">
                                                        <a class="postedUser" href="userDetails.aspx?username=<%# Eval ("postedBy") %>"><%# Eval ("postedBy") %>  </a>
                                                        <span class="s_CommentHeader">posted on this wall on </span>&nbsp<span><%# Eval ("postedDate") %></span>
                                                    </div>
                                                </div>
                                                <div class="postContent">
                                                    <p class="panel-primary info voteForComment">
                                                        <asp:Label ID="comments" runat="server" Text='<%# Eval("postContent") %>'></asp:Label>
                                                        <asp:TextBox ID="tb_comments" runat="server" Text='<%# Eval("postContent") %>' Visible="false"></asp:TextBox>
                                                    </p>
                                                </div>
                                                <table class="likeTable">
                                                    <tr class="likeRow">
                                                        <td class="likeData">
                                                            <asp:LinkButton ID="a_like" CommandName="likeComment" CommandArgument='<%#String.Format("{0}#{1}", Eval("postId"),Eval("likedUsers"))%>' CssClass="btn-link" runat="server" Text='<%# getText(Container.ItemIndex) %>'></asp:LinkButton>
                                                        </td>
                                                        <td class="likeStatement">
                                                            <span runat="server"><%#getTotalLikes(Container.ItemIndex) %></span>
                                                        </td>
                                                        <td class="editCommentLinks">
                                                            <asp:LinkButton ID="a_Edit" CommandName="editComment" CommandArgument='<%# Eval("postId")%> ' CssClass="btn-link" runat="server" Text='<%# getEditText(Eval ("postedBy").ToString()) %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="a_Delete" CommandName="deleteComment" CommandArgument='<%# Eval("postId")%>' CssClass="btn-link" runat="server" Text='<%# getDeleteText(Eval ("postedBy").ToString())%>'></asp:LinkButton>
                                                            <asp:LinkButton ID="a_Update" CommandName="updateComment" CommandArgument='<%#Eval("postId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getUpdateText(Eval ("postedBy").ToString()) %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="a_Cancel" CommandName="cancelComment" CommandArgument='<%# Eval("postId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getCancelText(Eval ("postedBy").ToString()) %>'></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<span class="totalRepliesCount" id="repliesCount" runat="server" ></span>--%>
                                                <asp:Label CssClass="totalRepliesCount" ID="lbl_repliesCount" runat="server">Replies(<%#Eval("repliesCount")%>)</asp:Label>
                                                <div class="d_postReply">
                                                    <%-- <hr class="thinseperator" />
                                                <span>Replies to this Post</span>--%>
                                                    <asp:UpdatePanel ID="updateReplies" runat="server">
                                                        <ContentTemplate>
                                                            <asp:Repeater ID="reptr_replies" runat="server">
                                                                <ItemTemplate>
                                                                    <div class="d_postRepliesWrapper">
                                                                        <div class="repliedUserImgHolder">
                                                                            <asp:Image ID="commentedBYLogo" CssClass="postedBYLogo" runat="server" ImageUrl='<%# frameURL(Eval("userimg").ToString())%>' />
                                                                        </div>
                                                                        <div class="d_repliesHolder">
                                                                            <a class="post_replies" href="userDetails.aspx?username=<%# Eval ("commentedUser") %>"><%# Eval ("commentedUser") %>  </a>
                                                                            <span class="s_CommentHeader">replied to this post on </span>&nbsp<span><%# Eval ("commentedDate") %></span>
                                                                            <%--<asp:Label ID="post_replies" runat="server"><%#Eval("commentedUser") %> replied to this post on <%#Eval("commentedDate") %></asp:Label>--%>
                                                                        </div>
                                                                        <%--<hr class="clear" />--%>
                                                                    </div>
                                                                    <hr class="thinseperator" />
                                                                    <div>
                                                                        <asp:Label ID="actualReply" CssClass="actualReply" runat="server"> <%# Eval("comments") %></asp:Label>
                                                                    </div>
                                                                    <hr class="thinseperator" />
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <div class="d_viewAllReplies">
                                                        <asp:LinkButton ID="a_replies" CommandName="allReplies" CommandArgument='<%# Eval("postId")%> ' CssClass="btn-link" runat="server" Text="View all Replies"></asp:LinkButton>
                                                        <asp:LinkButton ID="a_hide" CommandName="hideReplies" CommandArgument='<%# Eval("postId")%> ' CssClass="btn-link" runat="server" Text="Show only latest replies" Visible="false"></asp:LinkButton>
                                                    </div>
                                                    <div class="d_newReply">
                                                        <div class="txt_newreply">
                                                            <%--<input id="txt_reply" type="text" class="txt_reply" runat="server" placeholder="Reply to this post" style="padding:5px;"/>--%>
                                                            <%--<asp:UpdatePanel ID="update_replyTextBox" runat="server">
                                                                <ContentTemplate>--%>
                                                            <asp:TextBox ID="txt_reply" runat="server" CssClass="txt_reply" placeholder="Reply to this post" Style="padding: 5px;"></asp:TextBox>
                                                            <%--    </ContentTemplate>
                                                            </asp:UpdatePanel>--%>
                                                        </div>
                                                        <div class="d_replybtn">
                                                            <asp:LinkButton ID="a_reply" CommandName="replyComment" CommandArgument='<%# Eval("postId")%> ' CssClass="btn-link" runat="server" Text="Reply"></asp:LinkButton>
                                                            <%--<asp:LinkButton ID="LinkButton1" CommandName="replyComment" CommandArgument='<%# Eval("postId")%> ' CssClass="btn-link" runat="server" Text="Reply"></asp:LinkButton>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
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
