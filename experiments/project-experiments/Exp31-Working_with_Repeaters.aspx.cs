using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class experiments_project_experiments_Exp31_Working_with_Repeaters : System.Web.UI.Page
{
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    //string username = "arulselvan"; //For the purposes of letting the instructors view experiments without having to login.
    string username = "whunting";
    //string username = "gardenvariety";
    string LBTEXT = "Vote as good post";
    string LBTEXTTOGGLED = "Unvote";
    protected void Page_Load(object sender, EventArgs e)
    {
        /* Uncommenting the below section as I have modified the table structure. Need to replace the below content with the content from cropDetails page */
        
        //string cropname_request = Request.QueryString["cropname"];
        //if (cropname_request == null)
        //{
        //    lbl_cropname.Text = "No Crops selected to display";
        //    return;
        //}
        //lbl_cropname.Text = char.ToUpper(cropname_request[0]) + cropname_request.Substring(1);  //Capitalize First letter and display it.
        //cropNameVO crop = new cropNameVO(lbl_cropname.Text);
        //cropNameVO cropResultsFromDB = cropDAO.getCropDetails(crop);
        //if (cropResultsFromDB == null)
        //{
        //    lblStatus.Text = "There are no details available for this crop.";
        //}
        //else
        //{
        //    img_crop.ImageUrl = "~/experiments/project-experiments/DisplayImg.ashx?id=" + cropResultsFromDB.cropImageId;
        //    lbl_crop_sciname.Text = cropResultsFromDB.cropScientificName;
        //    lbl_prod_practices.Text = cropResultsFromDB.cropProductionPractices;
        //}
        //if (cropResultsFromDB.cropComments == null) 
        //{
        //    lbl_commentsHeader.Text = "No Comments to Display";
        //}
        //else 
        //{
        //    lbl_commentsHeader.Text = "Comments from our Users";
        //     DataTable commentsResults = cropResultsFromDB.cropComments;
        //     reptr_Comments.DataSource = commentsResults;
        //     reptr_Comments.DataBind();
        //}
    }
    protected void btn_comment_Click(object sender, EventArgs e)
    {
        /*Uncommenting to avoid conflicts with project. Copy source from cropDetails.aspx */


        //if((Commentbox.Text==null)||(Commentbox.Text.Length>499))
        //{
        //    lblStatus.Text = "Please enter a valid Comment";
        //}
        //else
        //{
        //    cropCommentVO userComments = new cropCommentVO(lbl_cropname.Text,username,Commentbox.Text);
        //    string result = cropDAO.insertComment(userComments);
        //    if(result == "success")
        //    {
        //        Commentbox.Text = "";
        //        reptr_Comments.DataSource = cropDAO.refreshCropComments(lbl_cropname.Text);
        //        reptr_Comments.DataBind();
        //    }
        //}
    }
    protected void changeLinkText(object sender, EventArgs e)
    {
        
    }
    protected void reptr_Comments_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //string test = e.Item.DataItem.ToString();
        LinkButton lb = (LinkButton)e.CommandSource;

        if (e.CommandName == "likeComment")
        {
            if (lb.Text == LBTEXT)
            {
                int commentId = Convert.ToInt32(e.CommandArgument);
                string likedUser = username;
                likeThisCropVO likeSelectedCrop = new likeThisCropVO(commentId, likedUser,Convert.ToInt32(img_crop.ID));
                DataTable result = cropDAO.updateLikedUsers(likeSelectedCrop);
                if (result == null)
                {
                    lblStatus.Text = "An Error Occured while attempting to connect to database";
                }
                else
                {
                    reptr_Comments.DataSource = result;
                    reptr_Comments.DataBind();
                }
            }
            else if (lb.Text == LBTEXTTOGGLED)
            {
                int commentId = Convert.ToInt32(e.CommandArgument);
                string likedUser = username;
                DataTable dt = (DataTable)reptr_Comments.DataSource;
                string likedUsers1 = dt.Rows[e.Item.ItemIndex]["likedUsers"].ToString();
                List<string> eachUser = likedUsers1.Split(':').ToList<string>();
                eachUser.RemoveAt(eachUser.IndexOf(username));
                string concatenatedUsers = string.Join<string>(":", eachUser);
                likeThisCropVO likeSelectedCrop = new likeThisCropVO(commentId, likedUser, Convert.ToInt32(img_crop.ID), concatenatedUsers);
                DataTable result = cropDAO.updateLikedUsers(likeSelectedCrop);
                if (result == null)
                {
                    lblStatus.Text = "An Error Occured while attempting to connect to database";
                }
                else
                {
                    reptr_Comments.DataSource = result;
                    reptr_Comments.DataBind();
                }
            }
        }
    }
}