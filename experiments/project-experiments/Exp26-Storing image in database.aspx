<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp26-Storing image in database.aspx.cs" Inherits="experiments_project_experiments_Exp26_Storing_image_in_database" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Exp26 - Storing Image in Database</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            cropDetailsDAO cropDAO = new cropDetailsDAO();

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
                    string sql = "Insert into uploadmaster (userName,cropName,plantedOn,plantedFrom,shade,cropImage) VALUES('1',@theTitle, @theImage,'arulselvan','This crop produced a good yield') SELECT @@IDENTITY";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    cmd.Parameters.AddWithValue("@theTitle", ddl_cropname.Value);
                    cmd.Parameters.AddWithValue("@theImage", imgByte);
                    int id = Convert.ToInt32(cmd.ExecuteScalar());
                    ddl_cropname.SelectedIndex = 0;// Reset the textbox value to empty
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", id);

                    //Image1.ImageUrl = "~/CropImageDisplay.ashx?id=" + id;
                    Image1.ImageUrl = "~/experiments/project-experiments/DisplayImg.ashx?id=" + id;
                    connection.Close();


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
                    <select name="ddl_cropname" id="ddl_cropname" runat="server" required autofocus>
                        <option value="default">Select a Crop</option>
                        <option value="tomato">Tomato</option>
                        <option value="potato">Potato</option>
                        <option value="brinjal">Eggplant</option>
                        <option value="carrot">Carrot</option>
                        <option value="beet">Beets</option>
                        <option value="cauliflower">Cauliflower</option>
                        <option value="redchilli">Red Chilli</option>
                        <option value="beans">Beans</option>
                    </select>
                </label>
            </div>
            <div>
                <label>
                    <span>How many did you plant?</span>
                    <input id="totalplantings" placeholder="Enter the number of plantings you did for this crop" type="text" tabindex="2" required>
                </label>
            </div>
            <div>
                <label>
                    <span>Planted from?(Select the one you used for your planting)</span>
                    <input placeholder="Please enter the type you used for your planting" type="text" tabindex="3" required>
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
                <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                <br />
                <asp:Button ID="butSubmit" CssClass="btnctrl" runat="server" Text="Submit"
                    OnClick="butSubmit_Click" /><br />
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </label>
            <br />
            <br />
            <div>
                <asp:Image CssClass="imagecontrol" ID="Image1" ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id="+Eval("id") %>' runat="server" />
            </div>
        </form>

    </div>

</body>
</html>
