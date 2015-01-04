<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CropDetails_old.aspx.cs" Inherits="experiments_project_experiments_Exp30_CropDetails" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp30-Crop details</title>


    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="css/cropDetails/cropDetail.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script runat="server">
    </script>
</head>
<body>
    <div class="wrapper">
        <form id="cropform" runat="server">

            <asp:LoginName ID="LoginName1" runat="server" CssClass="pull-right" />
            <asp:LoginStatus ID="LoginStatus1" runat="server" CssClass="pull-right" />
            <h3 id="cropnameheader">
                <asp:Label runat="server" ID="lbl_cropname"></asp:Label>
            </h3>
            <div class="div_cropimgholder" runat="server">
                <asp:Image ID="img_crop" CssClass="img-thumbnail img-responsive imgctrl" runat="server" />
            </div>
            <asp:Label ID="cropID" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="endorsedUsers" runat="server" Visible="false"></asp:Label>
            <table class="croptable">
                <tr class="row">
                    <td class="selector">
                        <span>Crop Scientific Name</span>
                    </td>
                    <td>
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
                    <td>
                        <i>
                            <asp:Label ID="lbl_prod_practices" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />

                        </i>
                    </td>
                </tr>
                <tr class="row">
                    <td class="selector">
                        <span>User's method</span>
                    </td>
                    <td>
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
                    <td>
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
                    <td>
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
                    <td>
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
                    <td>
                        <i>
                            <asp:UpdatePanel ID="update_EndorsedUsersCount" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lbl_endorsedUsers" runat="server"
                                        Font-Size="10pt" ForeColor="#336699" Width="100%" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </i>
                    </td>
                </tr>
            </table>
            <div>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>
            <asp:UpdatePanel ID="update_CommentBox" runat="server">
                <ContentTemplate>
                    <asp:Button ID="btn_Endorse" CssClass="btnctrl" runat="server" Text='<%# getBtnEndorseText() %>' OnClick="btn_Endorse_Click" />
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

                    <div>
                        <h3 id="h3_cropcomments">
                            <asp:Label ID="lbl_commentsHeader" runat="server"></asp:Label>
                        </h3>
                        <%--Do Not Rename anything without fully understanding the repercussions--%>
                        <asp:Repeater ID="reptr_Comments" runat="server" OnItemCommand="reptr_Comments_ItemCommand">
                            <ItemTemplate>
                                <div id='<%# Eval("commentId") %>' class="comment_header">
                                    <a href="Exp32-Building_profile_page.aspx?username=<%# Eval ("userName") %>"><%# Eval ("userName") %>  </a>
                                    <span>posted the following comments at </span>&nbsp<span><%# Eval ("commentedAt") %></span>
                                </div>
                                <div class="comment">
                                    <p class="panel-primary info">
                                        <asp:Label ID="comments" runat="server" Text='<%# Eval("comments") %>'></asp:Label>
                                        <asp:TextBox ID="tb_comments" runat="server" Text='<%# Eval("comments") %>' Visible="false"></asp:TextBox>
                                    </p>
                                    <table class="likeTable">
                                        <tr class="likeRow">
                                            <td class="likeData">
                                                <asp:LinkButton ID="a_like" CommandName="likeComment" CommandArgument='<%#String.Format("{0}#{1}", Eval("commentId"),Eval("likedUsers"))%>' CssClass="btn-link" runat="server" Text='<%# getText(Container.ItemIndex) %>'></asp:LinkButton>
                                                <span runat="server"><%#getTotalLikes(Container.ItemIndex) %></span>
                                            </td>
                                            <td class="editCommentLinks">
                                                <asp:LinkButton ID="a_Edit" CommandName="editComment" CommandArgument='<%# Eval("commentId")%> ' CssClass="btn-link" runat="server" Text='<%# getEditText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                                <asp:LinkButton ID="a_Delete" CommandName="deleteComment" CommandArgument='<%# Eval("commentId")%>' CssClass="btn-link" runat="server" Text='<%# getDeleteText(Eval ("userName").ToString())%>'></asp:LinkButton>
                                                <asp:LinkButton ID="a_Update" CommandName="updateComment" CommandArgument='<%#Eval("commentId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getUpdateText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                                <asp:LinkButton ID="a_Cancel" CommandName="cancelComment" CommandArgument='<%# Eval("commentId")%>' CssClass="btn-link" runat="server" Visible="false" Text='<%# getCancelText(Eval ("userName").ToString()) %>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <hr />
                                <br />
                            </ItemTemplate>
                        </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </form>
    </div>
</body>
</html>
