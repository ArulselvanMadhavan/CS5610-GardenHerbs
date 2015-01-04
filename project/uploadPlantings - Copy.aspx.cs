using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class experiments_project_experiments_uploadPlantings : System.Web.UI.Page
{
    string loggedInUser = "whunting";
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    protected void Page_Load(object sender, EventArgs e)
    {
        //get List of Crops supported by the website
        
        ddl_cropname.DataTextField = "cropName";
        ddl_cropname.DataValueField = "cropId";
        ddl_cropname.DataSource = cropDAO.fetchCropsSupported();
        ddl_cropname.DataBind();
    }
    protected void butSubmit_Click(object sender, EventArgs e)
    {
        bool valid = true;
        if (ddl_cropname.Value == "default")
        {
            lblStatus.Text = "Please select a crop";   // Check if a User Selected a Crop
            valid = false;

        }
        int totalPlantings;

        if(int.TryParse(totalplantings.Value, out totalPlantings)) //
        {
            
        }

        else
        {
            lblStatus.Text="Please enter a numeric value of the number of Plantings you made for this crop.";
        }

        if (valid != false)
        {
            string selectedCrop = ddl_cropname.Items[(Convert.ToInt32(ddl_cropname.Value))].Text;
            int selectedCropId =Convert.ToInt32(ddl_cropname.Items[(Convert.ToInt32(ddl_cropname.Value))].Value);
            string PlantingSource = ddl_plantingSource.Items[ddl_plantingSource.SelectedIndex].Value;
            string ShadingSource = ddl_Shademethod.Items[ddl_Shademethod.SelectedIndex].Value;
            string productionPractice = txt_productionPractices.Value;
            cropUploadVO cropUploadDetails = new cropUploadVO(loggedInUser, selectedCropId, selectedCrop, totalPlantings, PlantingSource, ShadingSource, productionPractice);
            try
            {
                Byte[] imgByte = null;
                if (FileUpload1.HasFile && FileUpload1.PostedFile != null)
                {
                    HttpPostedFile File = FileUpload1.PostedFile;
                    imgByte = new Byte[File.ContentLength];
                    File.InputStream.Read(imgByte, 0, File.ContentLength);
                    int uploadId = cropDAO.uploadUserCrop(cropUploadDetails,imgByte);
                    if(uploadId ==  0)
                    {
                        lblStatus.Text="There was an Error in uploading your crop. Please Notify our admin Team.Sorry for the inconvenience.";
                    }
                    else
                    {
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", uploadId);
                    Image1.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + uploadId;
                    }
                    txt_productionPractices.Value = ""; //Clearing the textbox values after successful upload into DB
                    totalplantings.Value = "";
                }
             }
            catch
            {
                    lblStatus.Text="There was an Error in uploading your crop. Please Notify our admin Team.Sorry for the inconvenience.";
            }
                //Image1.ImageUrl = "~/CropImageDisplay.ashx?id=" + id;
            

        }
    }
}