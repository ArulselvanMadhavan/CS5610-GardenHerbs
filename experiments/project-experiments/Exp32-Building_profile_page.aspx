<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp32-Building_profile_page.aspx.cs" Inherits="experiments_project_experiments_Exp32_Building_profile_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Exp32-User Profile Page</title>
    <link href="css/crophome/bootstrap.min.css" rel="stylesheet" />
    <link href="css/userprofile/userprofile.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
    <div class="wrapper">
        <form id="cropform" runat="server">
            <h3 id="usernameheader">
                <asp:Label runat="server" ID="lbl_userName"></asp:Label>
            </h3>
            <div class="div_userImgHolder" runat="server">
                <asp:Image ID="img_User" CssClass="img-thumbnail img-responsive" runat="server"
                    ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id=" + Eval("bestimgid") %>' />
            </div>
            <br />
            <table class="userTable table-responsive">
                <tbody class="userTableBody">
                <tr class="row">
                    <td class="selector">
                        <span>User's Full Name:</span>
                    </td>
                    <td>
                        <i>
                            <asp:Label ID="lbl_userFullName" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                        </i>
                    </td>
                </tr>
                <tr class="row">
                    <td class="selector">
                        <span>Location:</span>
                    </td>
                    <td>
                        <i>
                            <asp:Label ID="lbl_Location" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                        </i>
                    </td>
                </tr>
                 <tr class="row">
                    <td class="selector">
                        <span>Occupation:</span>
                    </td>
                    <td>
                        <i>
                            <asp:Label ID="lbl_Occupation" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                        </i>
                    </td>
                </tr>
                 <tr class="row">
                    <td class="selector">
                        <span>Crops Followed:</span>
                    </td>
                    <td>
                        <i>
                            <asp:Label ID="lbl_followedCrops" runat="server"
                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                        </i>
                    </td>
                </tr>
                    </tbody>
            </table>
            <div>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>

            <div>
                <h3 id="h3_plantedCrops">
                    <asp:Label ID="lbl_plantedCropsHeader" runat="server"></asp:Label>
                </h3>
             <%--   <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>s
                        <asp:Repeater ID="reptr_plantedCrops" runat="server" OnItemCommand="reptr_Comments_ItemCommand">
                            <ItemTemplate>

                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>

        </form>
    </div>
</body>
</html>
