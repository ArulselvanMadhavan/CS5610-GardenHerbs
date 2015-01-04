<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uploadPlanting.aspx.cs" Inherits="project_Documentation_uploadPlanting" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Upload Planting</h3>
    </div>
    <strong class="inline-heading">
        Features included in this page.
    </strong>
    <li>This page is accessible only for LOGGED IN users</li>
    <li>This page allows logged in users to describe about the planting that they made and upload a pic of their crop</li>
    <li>User is allowed to upload images that are less than 100Kb.</li>
    <li>User is allowed to upload images that are of type 'jpeg'. No other file type is acceptable</li>
    <li>All the fields are marked as required.</li>
    <li>Fields which expect numeric value are validated before the record is inserted into DB.</li>
    <i class="inline-heading">
        What are the details that a user will have to enter to upload details about his planting?
    </i>
    <p class="para text-justify">
        <li>Cropname - Select from a dropdown- (Options are fetched from the <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.cropmaster" target="_blank"></a>cropmaster table in Database during the page_Load</li>
        <li>Number of plantings - Expects a numercial value. Validators have been put in place to check and make sure that the value is a number before performing an insert operation in DB.</li>
        <li>Source of planting - User have to select the source for his planting(ex: Seed, seedling etc.,</li>
        <li>Shading method -User have to select the type of shading he used for his planting</li>
        <li>Method - User can describe about the method he followed to produce the crop</li>
        <li>Upload a pic of your planting</li>
    </p>
    <i class="inline-heading">
        How are the images saved in database?
    </i>
    <p class="para text-justify">Images are stored in SQL under the SQL datatype.SQL expects the image data to be in byte form. Images that qualify (Only jpeg images that are less than 100kb, qualify) are converted into a byte stream and fed into the database.Here is a link to my experiment which helped me to learn how to store images into database.
        <a href="../../protected/Storingimage.aspx" target="_blank">Saving images in database</a>
    </p>
    <i class="inline-heading">
        Web Handlers
    </i>
    <p class="para text-justify">
        Since I will be retrieving images in several pages of my project, I created a seperate web handler to handle the Image retrieval for me. The web handler uses a seperate DAO to connect to the database and read the image content. We use a stream object to read the image content as a byte stream. Once the image data is read as a byte stream, we construct the image using 'Context.Response.OutputStream.Write'. 
        <i>Therefore, any call made to this web handler will get an image as a response.</i> Throughout the project, whenever I need an image from database, I will just pass the imageId as paramater to this web handler and the web handler will take care of displaying the image for me.
        Here is a link to my experiment on retrieving images from database. <a href="../../protected/Exp27-Storing_image_in_database.aspx">Retrieving images from database</a>
    </p>
    <br />
    <i class="inline-heading">
        Experiments that helped for designing the page:
    </i>
    <li><a href="../../protected/Storingimage.aspx" target="_blank">Saving images in database</a></li>
    <li><a href="../../protected/Exp27-Storing_image_in_database.aspx" target="_blank">Retrieving image from database</a></li>
    <strong class="subheading">
        Database Tables used in this page.
    </strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.cropmaster" target="_blank">CropMaster</a></li>

    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/protected/uploadPlantings.aspx" target="_blank" class="text-indent">uploadPlantings.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/protected/uploadPlantings.aspx.cs" target="_blank">uploadPlantings.aspx.cs</a><br />
    </li>
    <i class="inline-heading">Web Handlers</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/webhandler/CropImage.ashx" target="_blank">CropImage.ashx</a></li>
    
    
    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/displayImageDAO.cs" target="_blank">DisplayImageDAO file</a><br /></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">Common DAO file</a><br />
    </li>
    <i class="inline-heading">VO File</i>
    <li>
        <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropUploadVO.cs" target="_blank">CropUploadVO</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/uploadPlanting/uploadCrop.css" target="_blank"></a>uploadPlanting.css</li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
</asp:Content>
    