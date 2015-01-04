using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class experiments_project_experiments_Exp26_Storing_image_in_database : System.Web.UI.Page
{
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
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString()))
            {
                try
                {
                    Byte[] imgByte = null;
                    if (FileUpload1.HasFile && FileUpload1.PostedFile != null)
                    {
                        HttpPostedFile File = FileUpload1.PostedFile;
                        imgByte = new Byte[File.ContentLength];
                        File.InputStream.Read(imgByte, 0, File.ContentLength);
                    }
                    //connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());

                    connection.Open();
                    string sql = "INSERT INTO arulselv.user_crop_images(Cropid,CropName,CropImage,PlantedUserId,Comments) VALUES('1',@theTitle, @theImage,'22','NO comments') SELECT @@IDENTITY";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    cmd.Parameters.AddWithValue("@theTitle", ddl_cropname.Value);
                    cmd.Parameters.AddWithValue("@theImage", imgByte);
                    int id = Convert.ToInt32(cmd.ExecuteScalar());
                    ddl_cropname.SelectedIndex = 0;// Reset the textbox value to empty
                    lblStatus.Text = String.Format("Your crop has been added successfullly. Your image ID is {0}", id);

                    //Image1.ImageUrl = "~/CropImageDisplay.ashx?id=" + id;
                    Image1.ImageUrl = "~/experiments/project-experiments/DisplayImg.ashx?id=" + id;


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
    }  

}