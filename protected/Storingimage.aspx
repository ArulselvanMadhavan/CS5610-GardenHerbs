<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Storingimage.aspx.cs" Inherits="experiments_project_experiments_Storingimage" %>

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
                    ddl_cropname.SelectedIndex = 0;// Reset the textbox value to empty
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
    <style>
        pre {
            color: blue;
        }
    </style>
    <%--<link href="css/addnewcrop/crop.css" rel="stylesheet" />--%>
    <link href="../experiments/project-experiments/css/addnewcrop/crop.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../experiments/project-experiments/css/bootstrap.css" />--%>
</head>
<body>

    <div>
        <h3>Experiment 25:Storing image into database</h3>
        <h2><i>Purpose of the Experiment:</i></h2>
        <p>
            In my project, I am planning to store images into database. With this experiment, I learned how to store image into database.
        </p>
        <h2>Experiment Demo:</h2>
        <p>
            Fill all the fields and upload an image . Then press submit. On successful insertion of the details(including the image) into database, a label will appear giving you the image id that just got inserted.
            Failed attempts will be shown via a label.
        </p>

        <br />

        <i><b>Disclaimer:</b> The C# code involved in data parsing is placed in this aspx file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.
            As per standard coding practices, I have written the C# code in code behind files in my project.
        </i>
        <i>Also , the SQL queries are put in this file to facilitate the instructor to quickly view the code without having to open multiple files to understand the program.  Please refer Piazza post @112 where the instructor advised us to put the code in aspx file to facilitate easy review during grading process.
            As per standard coding practices , all my SQL connections have been put inside a Data Access Object (DAO). All the data that is involved in communication with the database
            have been encapsulated inside a ValueObject class in my project. 
        </i>
        <br />
    </div>
    <div class="wrapper">
        <form id="cropform" runat="server">
              <div style="float: right;">
                <asp:LoginStatus ID="LoginStatus1" runat="server" />
            </div>
            <br />
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
                    <input placeholder="Enter the number of plantings you did for this crop" type="text" tabindex="2" required>
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
                <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                <br />
                <asp:Button ID="butSubmit" CssClass="btnctrl" runat="server" Text="Submit"
                    OnClick="butSubmit_Click" /><br />
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </label>
            <br />
            <br />

        </form>
    </div>
    <div>
        <h2>Documentation</h2>
        <p>1.Images are a special type of data . They have to handled differently when inserting and retrieving them from database.</p>
        <p>2.Get the required image using asp.net fileupload control.</p>
        <p>3.Form a SQL Connection to the database to which you need to insert.</p>
        <p>4.Frame the query to insert image into DB</p>
        <pre>
                    string sql = "INSERT INTO user_crop_images(Cropid,CropName,CropImage,PlantedUserId,Comments) VALUES('1',@theTitle, @theImage,'22','NO comments') SELECT @@IDENTITY";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    cmd.Parameters.AddWithValue("@theTitle", ddl_cropname.Value);
                    cmd.Parameters.AddWithValue("@theImage", imgByte);
                    int id = Convert.ToInt32(cmd.ExecuteScalar());
                    ddl_cropname.SelectedIndex=0;// Reset the textbox value to empty
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", id);
        </pre>
    </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Storingimage.aspx" style="color: black; text-decoration: underline" target="_blank">Link to source file</a>
    <hr />
    <div class="d_ref">
        <h2>References:</h2>
        <a href="https://www.youtube.com/watch?v=BsI2W5w77EQ" target="_blank">1. Youtube video on how to store images into database</a><br />
    </div>

</body>
</html>
