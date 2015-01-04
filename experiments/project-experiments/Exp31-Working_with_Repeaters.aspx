<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp31-Working_with_Repeaters.aspx.cs" Inherits="experiments_project_experiments_Exp31_Working_with_Repeaters" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp30-Crop details</title>
    <link href="css/crophome/bootstrap.min.css" rel="stylesheet" />
    <link href="css/cropdetails/cropdetail.css" rel="stylesheet" />
    <%--<link href="css/cropdetail/cropdetail.css" rel="stylesheet" />--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script runat="server">
        //string username = "arulselvan"; //For the purposes of letting the instructors view experiments without having to login.
        string userName = "whunting";
        //string userName = "gardenvariety";
        string seperator = " | " ;
        public string getText(int commentId)
        {
            //int comId = Convert.ToInt32(commentId);
            
            
            //string test = dt.Rows[commentId]["likedUsers"];
            List<string> eachUser = getLikedUsers(commentId);
            if (eachUser.Contains(userName))
            {
                return "Unvote";
            }
            else
            {
                return "Vote as good post";
            }
        }
        public string getTotalLikes(int commentId)
        {
            List<string> eachUser = getLikedUsers(commentId);
            if (eachUser.Contains(userName))
            {
                //int = eachUser.Length;
                //string totalUsers = Convert.ToString(eachUser.Count);
                if(eachUser.Count==1)
                {
                    return string.Concat(seperator,"You think this is a good post");
                }
                else
                    return string.Concat(seperator, "You", " and ", eachUser.Count - 1, " Others thinks this is a good post");
            }
            else if (eachUser.Count==0)
            {
                return null;
            }
            else
            {
                return string.Concat(seperator, eachUser.Count, " User think that this is a good post.");
            }
        }
        public List<string> getLikedUsers(int commentId)
        {
            DataTable dt = (DataTable)reptr_Comments.DataSource;
             //List<string> eachUser = likedUsers1.Split(':').ToList<string>();
             //   eachUser.RemoveAt(eachUser.IndexOf(username));
             //   string concatenatedUsers = string.Join<string>(":", eachUser);
            string likedUsers1 = dt.Rows[commentId]["likedUsers"].ToString();
            List<string> eachUser = likedUsers1.Split(':').ToList<string>();
            eachUser.RemoveAt(0);
            return eachUser;
        }
    </script>
</head>
<body>
    <div class="wrapper">
        <form id="cropform" runat="server">
            <h3 id="cropnameheader">
                <asp:Label runat="server" ID="lbl_cropname"></asp:Label>
                <%--            <asp:DataList ID="cropdetails" runat="server">
            </asp:DataList>--%>
            </h3>
            <div class="div_cropimgholder" runat="server">
                <asp:Image ID="img_crop" CssClass="img-thumbnail img-responsive" runat="server"
                    ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' />
            </div>
            <table class="croptable">
                <tr class="row">
                    <td class="selector">
                        <span>Crop Scientific Name:</span>
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
                        <span>Production Practices:</span>
                    </td>
                    <td>
                        <i>
                            <asp:Label ID="lbl_prod_practices" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />

                        </i>
                    </td>
                </tr>
            </table>
            <div class="text-center">
                <h3>
                    <span>Post Your Comment</span>
                </h3>
            </div>
            <div>
                <asp:TextBox ID="Commentbox" runat="server" TextMode="MultiLine" />
            </div>
            <div class="div_commentbtn">
                <asp:Button ID="btn_comment" CssClass="btn-primary" runat="server" Text="Post Your Comment" OnClick="btn_comment_Click" />
            </div>
            <br />
            <div>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>
            
            <div>
                <h3 id="h3_cropcomments">
                    <asp:Label ID="lbl_commentsHeader" runat="server"></asp:Label>
                </h3>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Repeater ID="reptr_Comments" runat="server" OnItemCommand="reptr_Comments_ItemCommand">
                    <ItemTemplate>
                        <div id='<%# Eval("commentId") %>' class="comment_header">
                            <a href="Exp32-Building_profile_page.aspx?username=<%# Eval ("userName") %>"><%# Eval ("userName") %>  </a>
                            <span>posted the following comments at </span>&nbsp<span><%# Eval ("commentedAt") %></span></div>
                        <div class="comment">
                            <p class="panel-primary">
                                <span><%# Eval("comments") %></span>
                            </p>
                            <%--<asp:HyperLink ID="a_link" NavigateUrl="#"  runat="server" ></asp:HyperLink>--%>
                            <asp:LinkButton ID="a_like" CommandName="likeComment" CommandArgument='<%# Eval("commentId")%>' CssClass="btn-link" runat="server" OnClientClick="changeLinkText" Text='<%#getText(Container.ItemIndex) %>'></asp:LinkButton>
                            <span><%#getTotalLikes(Container.ItemIndex) %></span>
                            <%--<asp:LinkButton ID="a_totalLikes" runat="server" ToolTip='<%# Eval("likedUsers")%>' Text='<%#getTotalLikes(Container.ItemIndex) %>'></asp:LinkButton>--%>
                            
                        </div>
                        <hr />
                        <br />
                    </ItemTemplate>
                </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </form>
    </div>
</body>
</html>
