<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Storingimage.aspx.cs" Inherits="experiments_project_experiments_Storingimage" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace= "System.Data" %>
<%@ Import Namespace= "System.Collections" %>
<%@ Import Namespace= "System.Collections.Generic"%>
<%@ Import Namespace= "System.IO" %>
<%@ Import Namespace= "System.Xml" %>
<%@ Import Namespace= "System.Xml.XPath" %>
<%@ Import Namespace= "System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Exp26 - Storing Image in Database</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void butSubmit_Click(object sender, EventArgs e)
        {
            bool valid = true;
            if (ddl_cropname.Value == "default")
            {
                lblStatus.Text = "Please select a crop";
                valid = false;
            }
            if (valid != false)
            {
                SqlConnection connection = null;
                try
                {
                    Byte[] imgByte = null;
                    if (FileUpload1.HasFile && FileUpload1.PostedFile != null)
                    {
                        HttpPostedFile File = FileUpload1.PostedFile;
                        imgByte = new Byte[File.ContentLength];
                        File.InputStream.Read(imgByte, 0, File.ContentLength);
                    }
                    connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());

                    connection.Open();
                    string sql = "INSERT INTO arulselv.user_crop_images(Cropid,CropName,CropImage,PlantedUserId,Comments) VALUES('1',@theTitle, @theImage,'22','NO comments') SELECT @@IDENTITY";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    cmd.Parameters.AddWithValue("@theTitle", ddl_cropname.Value);
                    cmd.Parameters.AddWithValue("@theImage", imgByte);
                    int id = Convert.ToInt32(cmd.ExecuteScalar());
                    ddl_cropname.SelectedIndex=0;// Reset the textbox value to empty
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", id);
         }
                catch
                {
                    lblStatus.Text = "There was an error";
                }
                finally
                {
                    connection.Close();
                }
            }
        }
    </script>
    <link href="css/addnewcrop/crop.css" rel="stylesheet" />
</head>
<body>
    <div class="wrapper">
    <form id="cropform" runat="server">
        <h3>Enter details about the Crop you planted</h3>
        <div>
            <label>
                <span>Crop Name:</span>
                <%--<input  type="text" id="croptxt" runat="server" placeholder="Please enter the Name of your crop"  tabindex="1" required autofocus>--%>
                <select name="ddl_cropname" id="ddl_cropname" runat="server" required autofocus>
                    <option value="default">Select a Crop</option>
                    <option value="tomato">Tomato</option>
                </select>
            </label>
        </div>
        <div>
            <label>
                <span>How many did you plant?</span>
                <input placeholder= "Enter the number of plantings you did for this crop" type="text" tabindex="2" required>
            </label>
        </div>
        <div>
            <label>
                <span>Planted from?(Select the one you used for your planting)</span>
                <input placeholder="ex:Seed,Organic Method,Biofarming etc.," type="text" tabindex="3" required>
            </label>
        </div>
        <div>
            <label>
                <span>Sun or Shade?</span>
                <input placeholder="Sun or Shade?" type="text" tabindex="4" required>
            </label>
        </div>
        <div>
            <label>
                <span>Tell us more about your crop</span>
                <textarea placeholder="Include all the details you can" tabindex="5" required></textarea>
            </label>
        </div>
        <label>
        <span>Upload an Image of your Crop</span>
            <%--<input type="file" name="FileUpload1" runat="server" id="FileUpload1">--%>
        <asp:FileUpload ID="FileUpload1" runat="server"  /><br />
        <br />
        <asp:Button ID="butSubmit" CssClass="btnctrl" runat="server" Text="Submit"
            OnClick="butSubmit_Click" /><br />
        <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </label>
        <br />
        <br />
        
    </form>
        </div>

</body>
</html>