<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uploadPlantings - Copy.aspx.cs" Inherits="experiments_project_experiments_uploadPlantings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Your Planting</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="css/uploadPlanting/uploadCrop.css" rel="stylesheet" />
    
</head>
<body>
      <div class="wrapper">
    <form id="cropform" runat="server">
        <h3>Enter details about the Crop you planted</h3>
        <div>
            <label>
                <span>Crop Name:</span>
                <select  name="ddl_cropname" id="ddl_cropname" runat="server" required autofocus>
                </select>
            </label>
        </div>
        <div>
            <label>
                <span>How many did you plant?</span>
                <input type="text" name="totalplantings" id="totalplantings" runat="server" maxlength="4" placeholder= "Enter the number of plantings you did for this crop"  tabindex="2" required />
            </label>
        </div>
        <div>
            <label>
                <span>Planted from?(Select the one you used for your planting)</span>
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
            </label>
        </div>
        <div>
            <label>
                <span>Sun or Shade?</span>
                <select name="ddl_Shademethod" id="ddl_Shademethod" runat="server" required  tabindex="4">
                    <option value="Sun">Sun</option>
                    <option value="Semi-Shade">Semi-Shade</option>
                    <option value="Shade">Shade</option>
                </select>
            </label>
        </div>
        <div>
            <label>
                <span>Describe the method you followed for this planting:</span>
                <textarea id="txt_productionPractices" runat="server" maxlength="2000" placeholder="Include as much as details you can" tabindex="5" required></textarea>
            </label>
        </div>
        <label>
        <span>Upload an Image of your Crop</span>
        <asp:FileUpload ID="FileUpload1" runat="server"  /><br />
        <br />
        <asp:Button ID="butSubmit" CssClass="btnctrl" runat="server" Text="Submit"
            OnClick="butSubmit_Click" /><br />
        <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </label>
        <br />
        <br />
            <div>
            <asp:Image CssClass="imagecontrol" ID="Image1" runat="server" />
</div>
    </form>

        </div>
</body>
</html>
