<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp27-Storing_image_in_database.aspx.cs" Inherits="experiments_project_experiments_Exp26_Storing_image_in_database" %>
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
        
    </script>
    <style>
        pre{
            color:blue;
        }
    </style>
    <link href="css/addnewcrop/crop.css" rel="stylesheet" />
</head>
<body>
    <div>
        <h3>Experiment 26:Storing image into database</h3>
        <h2><i>Purpose of the Experiment:</i></h2>
        <p>
            In my project, I am planning to retrieve image from database and display them to the user. With this experiment, I learned how to retrieve images from databases.
        </p>
        <h2>Experiment Demo:</h2>
        <p>
            Fill all the fields and upload an image . Then press submit. On successful insertion of the details(including the image) into database, a label will appear giving you the image id that just got inserted.
            Along with the label, the image which just got inserted into database is fetched from the database and displayed to the user.
        </p>
    </div>
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
    <%--  <form id="form1" runat="server">
       <br />
       <div>
       CropName: <asp:TextBox ID="txtTitle" runat="server" /><br />
           </div>
Image: <asp:FileUpload ID="FileUpload1" runat="server" /><br />
<br />
<asp:Button ID="butSubmit" runat="server" Text="Submit"
onclick="butSubmit_Click" /><br />
<asp:Label ID="lblStatus" runat="server"></asp:Label>
<br /><br />
 <div>
<asp:Image ID="Image1" ImageUrl='<%# "~/experiments/project-experiments/DisplayImg.ashx?id="+Eval("id") %>' runat="server" />
     </div>
</form>--%>
        </div>
<div>
    <h2>Documentation</h2>
    <p>1. To retrieve images , we neeed a handler that could process the request to retrive an image from the db and display it to the user.</p>
    <p>2. We add a 'GenericHandler' to the project and pass the id of the image that needs to be retrieved to the handler.</p>
    <p>3. Inside the handler , we have to write a function that takes an image id as querystring and returns the image</p>
    <pre>
        public void ProcessRequest (HttpContext context)
    {
        Int32 theID;
        if (context.Request.QueryString["id"] != null)
            theID = Convert.ToInt32(context.Request.QueryString["id"]);
        else
            throw new ArgumentException("No parameter specified");

        context.Response.ContentType = "image/jpeg";
        Stream strm = DisplayImage(theID);
        byte[] buffer = new byte[2048];
        int byteSeq = strm.Read(buffer, 0, 2048);

        while (byteSeq > 0)
        {
            context.Response.OutputStream.Write(buffer, 0, byteSeq);
            byteSeq = strm.Read(buffer, 0, 2048);
        }
    }
    
    public Stream DisplayImage(int theID)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "SELECT CropImage FROM user_crop_images WHERE ImageId = @ID";
        SqlCommand cmd = new SqlCommand(sql,connection);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@ID", theID);
        connection.Open();
        object theImg = cmd.ExecuteScalar();
        try
        {
            return new MemoryStream((byte[])theImg);
        }
        catch
        {
            return null;
        }
        finally
        {
            connection.Close();
        }
    }
    </pre>
    <hr/>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp26-Storing image in database.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a>
    <hr />
</div>
     <div class="d_ref">
        <h2>References:</h2>
         <a href="https://www.youtube.com/watch?v=BsI2W5w77EQ" target="_blank">1. Youtube video on how to store images into database</a><br />
         </div>
</body>
</html>
