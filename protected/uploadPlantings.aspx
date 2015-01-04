<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uploadPlantings.aspx.cs" Inherits="experiments_project_experiments_uploadPlantings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Your Planting</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="~/project/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="~/project/css/home/masterStyle.css" />
    <link href="~/project/css/uploadPlanting/uploadCrop.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
            <div class="header">
                <div id="d_firstRow">
                    <div id="logo">
                        <img id="logo_img" src="../project/images/logo.png" />
                    </div>
                    <div>
                        <asp:LoginStatus ID="a_loginStatus" runat="server" CssClass="pull-right" />
                    </div>
                    <div id="d_loggedInUser" class="pull-right">
                        <asp:LoginName ID="LoginName1" runat="server" CssClass="pull-right" />
                    </div>
                </div>
                <div id="sublogo" style="width: 100%">
                    <img id="imgsublogo" class="pull-right" src="../project/images/log-subtext.png" />
                </div>
            </div>

            <!-- LOGO END -->


            <!-- MENU START -->
            <div class="navHolder">
                <nav>
                    <ul>
                        <li><a href="../project/Home.aspx" class="cl-effect-8">Home</a></li>
                        <li><a href="../project/searchCrops.aspx" class="cl-effect-8">Search Crops</a></li>
                        <li><a href="../project/BrowseCrops.aspx" class="cl-effect-8">Browse Crops</a></li>
                        <li><a href="uploadPlantings.aspx" class="cl-effect-8">Upload Crop</a></li>
                        <li><a href="../project/cropSuggestor.aspx" class="cl-effect-8">Crop Suggestor</a></li>
                        <li><a href="../project/farmersMarket.aspx" class="cl-effect-8">Farmers Market</a></li>
                        <li><a href="../project/weatherForecast.aspx" class="cl-effect-8">Check Weather</a></li>
                    </ul>
                </nav>
            </div>
            <div class="d_heading">
                <h3>Enter details about the Crop you planted</h3>
            </div>
            <div class="wrapper">
                <div id="cropform" runat="server">
                    <div class="cropNameHolder">
                        <div class="d_cropName">
                            <span>Crop Name:</span>
                        </div>
                        <div class="d_cropnamelist">
                            <select name="ddl_cropname" id="ddl_cropname" runat="server" required autofocus>
                            </select>
                            <%--<asp:DropDownList ID="ddl_cropname" runat="server">
                                </asp:DropDownList>--%>
                        </div>
                    </div>
                    <div>
                        <div>
                            <span>How many did you plant?</span>
                        </div>
                        <div>
                            <input type="text" name="totalplantings" id="totalplantings" runat="server" maxlength="4" placeholder="Enter the number of plantings you did for this crop" tabindex="2" required />
                        </div>
                    </div>
                    <div>
                        <div>
                            <span>Planted from?(Select the one you used for your planting)</span>
                        </div>
                        <div>
                            <select name="ddl_plantingSource" id="ddl_plantingSource" runat="server" required tabindex="3">
                                <option value="Seed">Seed</option>
                                <option value="Seedling">Seedling</option>
                                <option value="Cutting">Cutting</option>
                                <option value="RootDivision">rootDivision</option>
                                <option value="Runner">Runner</option>
                                <option value="Bulb">Bulb</option>
                                <option value="root/tuber">root/tuber</option>
                                <option value="BareRootPlant">BareRootPlant</option>
                                <option value="AdvancedPlant">AdvancedPlant</option>
                                <option value="Graft">Graft</option>
                                <option value="Layering">Layering</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <div>
                            <span>Sun or Shade?</span>
                        </div>
                        <div>
                            <select name="ddl_Shademethod" id="ddl_Shademethod" runat="server" required tabindex="4">
                                <option value="Sun">Sun</option>
                                <option value="Semi-Shade">Semi-Shade</option>
                                <option value="Shade">Shade</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <div>
                            <span>Describe the method you followed for this planting:</span>
                            <textarea id="txt_productionPractices" runat="server" maxlength="2000" placeholder="Include as much as details you can" tabindex="5" required></textarea>
                        </div>
                    </div>
                    <div>
                        <span>Upload an Image of your Crop</span>
                    </div>
                    <div>
                        <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                    </div>
                    <div>
                        <asp:Button ID="butSubmit" CssClass="btnctrl" runat="server" Text="Submit"
                            OnClick="butSubmit_Click" /><br />
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                    <br />
                    <br />
                    <div>
                        <asp:Image CssClass="imagecontrol" ID="Image1" runat="server" />
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

                    <img src="../project/images/chrome.png" style="width: 24px" />
                </div>
            </div>
        </form>

    </div>
</body>
</html>
