<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="project_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Login</title>
    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="~/project/css/home/masterStyle.css"  rel="stylesheet"/>
    <link href="css/login/loginPageStyle.css" rel="stylesheet" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
    <%--<script type="text/javascript" src="js/login/login.js">--%>

    </script>

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
            <div class="wrapperHolder">
            <div id="wrapper">
                <%--<div class="user-icon"></div>
                <div class="pass-icon"></div>--%>
                <div name="login-form" class="login-form" runat="server">
                    <div class="header">
                        <h1>Login Form</h1>
                        <span>Please Enter Your Credentials to Continue</span>
                    </div>
                    <%--<asp:Login ID="Login1" runat="server" DestinationPageUrl="~/project/searchCrops.aspx">--%>
                    <div class="content">
                        <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/project/Home.aspx">
                            <LayoutTemplate>
                                <asp:TextBox ID="UserName" placeholder="UserName" CssClass="input username" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="Password" placeholder="Password" runat="server" CssClass="input password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                <div class="chkBox_RememberMe">
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                </div>
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                <div class="footer1">
                                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" CssClass="button" ValidationGroup="Login1" />
                                </div>
                            </LayoutTemplate>
                        </asp:Login>
                    </div>
                </div>
            </div>
                </div>
            <%--<div class="gradient"></div>--%>
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
