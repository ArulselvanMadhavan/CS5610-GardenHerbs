using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class project_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        cropDetailsDAO cropDAO = new cropDetailsDAO();
        DataTable dt = (DataTable)cropDAO.getRecentUploads();
        Image1.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + dt.Rows[0]["uploadId"];
        a_recentUpload1.HRef = "cropDetails.aspx?cropid=" + dt.Rows[0]["uploadId"];
        Image2.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + dt.Rows[1]["uploadId"];
        a_recentUpload2.HRef = "cropDetails.aspx?cropid=" + dt.Rows[1]["uploadId"];
        Image3.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + dt.Rows[2]["uploadId"];
        a_recentUpload3.HRef = "cropDetails.aspx?cropid=" + dt.Rows[2]["uploadId"];
        Image4.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + dt.Rows[3]["uploadId"];
        a_recentUpload4.HRef = "cropDetails.aspx?cropid=" + dt.Rows[3]["uploadId"];
        title1.InnerText = dt.Rows[0]["cropName"].ToString();
        title2.InnerText = dt.Rows[1]["cropName"].ToString();
        title3.InnerText = dt.Rows[2]["cropName"].ToString();
        title4.InnerText = dt.Rows[3]["cropName"].ToString();
        r_plantedOn1.InnerText = dt.Rows[0]["plantedOn"].ToString();
        r_userName1.InnerText=dt.Rows[0]["userName"].ToString();
        r_plantedOn2.InnerText = dt.Rows[1]["plantedOn"].ToString();
        r_userName2.InnerText = dt.Rows[1]["userName"].ToString();
        r_plantedOn3.InnerText = dt.Rows[2]["plantedOn"].ToString();
        r_userName3.InnerText = dt.Rows[2]["userName"].ToString();
        r_plantedOn4.InnerText = dt.Rows[3]["plantedOn"].ToString();
        r_userName4.InnerText = dt.Rows[3]["userName"].ToString();
        a1.HRef = "cropDetails.aspx?cropid=" + dt.Rows[0]["uploadId"]; ;
        a2.HRef = "cropDetails.aspx?cropid=" + dt.Rows[1]["uploadId"]; ;
        a3.HRef = "cropDetails.aspx?cropid=" + dt.Rows[2]["uploadId"]; ;
        a4.HRef = "cropDetails.aspx?cropid=" + dt.Rows[3]["uploadId"]; ;
        //recentUploads.DataSource=cropDAO.getRecentUploads();
        //recentUploads.DataBind();
    }
}