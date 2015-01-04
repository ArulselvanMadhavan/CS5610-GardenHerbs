<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp33-UserProfile-Upload.aspx.cs" Inherits="experiments_project_experiments_Exp33_UserProfile_Upload" %>
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <link href="css/addnewcrop/crop.css" rel="stylesheet" />
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void butSubmit_Click(object sender, EventArgs e)
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
                    string sql = "Insert into arulselv.userDetailsMaster (userName,userFullName,location,occupation,followedCrops,userimg) values (@userName,@userFullName,@location,@occupation,@followedCrops,@userImg) select @@IDENTITY";
                    
                    SqlCommand cmd = new SqlCommand(sql, connection);
                    cmd.Parameters.AddWithValue("@userName", tb_userName.Text);
                    cmd.Parameters.AddWithValue("@userFullName", tb_userFullName.Text);
                    
                    cmd.Parameters.AddWithValue("@location", tb_location.Text);
                    cmd.Parameters.AddWithValue("@occupation", tb_occupation.Text);
                    cmd.Parameters.AddWithValue("@followedCrops", tb_interestedCrops.Text);
                    cmd.Parameters.AddWithValue("@userImg", imgByte);
                    int id = Convert.ToInt32(cmd.ExecuteScalar());
                    
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", id);

                    //Image1.ImageUrl = "~/CropImageDisplay.ashx?id=" + id;
                    Image1.ImageUrl = "~/experiments/project-experiments/DisplayImg.ashx?userid=" + id;
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
        
    </script>
</head>
<body>
    <div class="wrapper">
    <form id="cropform" runat="server">
        <h3>Enter details about the Crop you planted</h3>
        <div>
            <label>
                <span>User Name:</span>
                <asp:TextBox ID="tb_userName" runat="server" ></asp:TextBox>
                <%--<input name="tb_Un" value="tb" id="tb_userName" runat="server" placeholder= "Enter the number of plantings you did for this crop" type="text" tabindex="1" required autofocus>--%>
            </label>
        </div>
        <div>
            <label>
                <span>User Full Name:</span>
                <asp:TextBox ID="tb_userFullName" runat="server" ></asp:TextBox>
                <%--<input name="tb_Un" value="tb" id="tb_userName" runat="server" placeholder= "Enter the number of plantings you did for this crop" type="text" tabindex="1" required autofocus>--%>
            </label>
        </div>
        <div>
            <label>
                <span>Location</span>
                <asp:TextBox ID="tb_location" runat="server" TabIndex="2"></asp:TextBox>
            </label>
        </div>
        <div>
            <label>
                <span>Occupation</span>
                <asp:TextBox ID="tb_occupation" runat="server" TabIndex="3" ></asp:TextBox>
            </label>
        </div>
        <div>
            <label>
                <span>Interested Crops</span>
                <asp:TextBox ID="tb_interestedCrops" runat="server" TabIndex="4" ></asp:TextBox>
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
            <asp:Image CssClass="imagecontrol" ID="Image1" ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id="+Eval("id") %>' runat="server" />
</div>
    </form>
        </div>
</body>
</html>
