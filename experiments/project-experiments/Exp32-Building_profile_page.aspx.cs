using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class experiments_project_experiments_Exp32_Building_profile_page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        cropDetailsDAO cropDAO = new cropDetailsDAO();
        string requested_User = Request.QueryString["username"].ToString();
        userDetailsVO requestDetails = new userDetailsVO(requested_User);
        requestDetails = cropDAO.fetchUserDetails(requestDetails);
        lbl_userName.Text = requestDetails.userName;
        lbl_userFullName.Text = requestDetails.userFullName;
        lbl_Location.Text = requestDetails.location;
        lbl_Occupation.Text = requestDetails.occupation;
        lbl_followedCrops.Text = requestDetails.followedCrops;
        img_User.ImageUrl = "~/experiments/project-experiments/DisplayImg.ashx?userid=" + requestDetails.userid;
    }
}