﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Net;
using System.Configuration;
public partial class experiments_project_experiments_Exp30_CropDetails : System.Web.UI.Page
{
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    //string username = "arulselvan"; //For the purposes of letting the instructors view experiments without having to login.
    string userName = "whunting";
    //string userName = "gardenvariety";
    string seperator = " | ";
    string LBTEXT = "Vote as good post";
    string LBTEXTTOGGLED = "Unvote";
    protected void Page_Load(object sender, EventArgs e)
    {
        //int requestedCropID = 4;
        int requestedCropID = Convert.ToInt32(Request.QueryString["cropid"]);
        cropID.Text = requestedCropID.ToString();

        if (!IsPostBack)
        {
            

            //string cropname_request = Request.QueryString["cropname"];
            

            //string uploadIDforCrop = "tomato"; //For the purposes of showcasing this experiment to Instructors, I am defaulting this variable to 'tomato'. In realtime, the code commented above will be used.
            if (requestedCropID == null)
            {
                lbl_cropname.Text = "No Crops selected to display";
                return;
            }
            cropNameVO crop = new cropNameVO(requestedCropID);
            cropNameVO cropResultsFromDB = cropDAO.getCropDetails(crop);
            if (cropResultsFromDB == null)
            {
                lblStatus.Text = "There are no details available for this crop.";
            }
            else
            {
                img_crop.ID = cropResultsFromDB.cropImageId.ToString();
                img_crop.ImageUrl = "~/project/webhandler/CropImage.ashx?uploadId=" + cropResultsFromDB.cropImageId; ;
                lbl_cropname.Text = char.ToUpper(cropResultsFromDB.cropName[0]) + cropResultsFromDB.cropName.Substring(1);  //Capitalize First letter and display it.
                lbl_crop_sciname.Text = cropResultsFromDB.cropScientificName;
                lbl_prod_practices.Text = cropResultsFromDB.suggestedProductionPractices;
                lbl_userMethod.Text = cropResultsFromDB.methodFollowedByUser;
                lbl_PlantedFrom.Text = cropResultsFromDB.plantedFrom;
                lbl_PlantedOn.Text = cropResultsFromDB.PlantedOn;
                lbl_Plantings.Text = cropResultsFromDB.numberOfPlantings;
                lbl_shadingMethod.Text = cropResultsFromDB.shade;
                List<string> listOfEndorsedUsers = cropResultsFromDB.endorsedUsers.Split(':').ToList<string>();
                listOfEndorsedUsers.RemoveAt(0);   // First value is always empty
                endorsedUsers.Text = cropResultsFromDB.endorsedUsers;
                btn_Endorse.DataBind();  //Calling DataBind as the data that decides the text of the button is NOW available.
                lbl_endorsedUsers.Text = listOfEndorsedUsers.Count.ToString();
                if (cropResultsFromDB.cropComments.Rows.Count == 0)
                {
                    lbl_commentsHeader.Text = "No Comments to Display";
                }
                else
                {
                    lbl_commentsHeader.Text = "Comments from our Users";
                    DataTable commentsResults = cropResultsFromDB.cropComments;
                    reptr_Comments.DataSource = commentsResults;
                    reptr_Comments.DataBind();            
                }
            }
        }
        
    }

    public string getBtnEndorseText()
    {
        if (endorsedUsers.Text == null)   // If no users have endorsed the crop yet.
        {
            return "Endorse";
        }
        else
        {
            List<string> allendorsedUsers = endorsedUsers.Text.Split(':').ToList<string>();
            if (allendorsedUsers.Contains(userName))
            {
                return "UnEndorse";
            }
            else
            {
                return "Endorse";
            }
        }
    }
    public string getTotalLikes(int commentId)
    {
        List<string> eachUser = getLikedUsers(commentId);
        if (eachUser.Contains(userName))
        {
            if (eachUser.Count == 1)
            {
                return string.Concat(seperator, "You think this is a good post");
            }
            else
                return string.Concat(seperator, "You", " and ", eachUser.Count - 1, " Others thinks this is a good post");
        }
        else if (eachUser.Count == 0)
        {
            return null;
        }
        else
        {
            return string.Concat(seperator, eachUser.Count, " User think that this is a good post.");
        }
    }
   
    public string getText(int commentId)
    {
        //int comId = Convert.ToInt32(commentId);


        //string test = dt.Rows[commentId]["likedUsers"];
        List<string> eachUser = getLikedUsers(commentId);
        if (eachUser.Contains(userName))
        {
            return "Unvote";
        }
        else
        {
            return "Vote as good post";
        }
    }
    public string getEditText(string CommentedUser)
    {
        if (CommentedUser == userName)
        {
            return "Edit";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getUpdateText(string CommentedUser)
    {


        if (CommentedUser == userName)
        {
            return "Update";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getDeleteText(string CommentedUser)
    {


        if (CommentedUser == userName)
        {
            return "Delete";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getCancelText(string CommentedUser)
    {


        if (CommentedUser == userName)
        {
            return "Cancel";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public List<string> getLikedUsers(int commentId)
    {
        DataTable dt = (DataTable)reptr_Comments.DataSource;
        string likedUsers1 = dt.Rows[commentId]["likedUsers"].ToString();
        List<string> eachUser = likedUsers1.Split(':').ToList<string>();
        eachUser.RemoveAt(0);
        return eachUser;
    }

    protected void btn_comment_Click(object sender, EventArgs e)
    {
        if ((Commentbox.Text == null) || (Commentbox.Text.Length > 499))
        {
            lblStatus.Visible = true;
            lblStatus.Text = "Please enter a valid Comment";
        }
        else
        {
            cropCommentVO userComments = new cropCommentVO(lbl_cropname.Text, userName, Commentbox.Text,(Convert.ToInt32(cropID.Text)));
            string result = cropDAO.insertComment(userComments);
            if (result == "success")
            {
                Commentbox.Text = "";
                reptr_Comments.DataSource = cropDAO.refreshCropComments((Convert.ToInt32(cropID.Text)));
                reptr_Comments.DataBind();
                if(lbl_commentsHeader.Text == "No Comments to Display")
                {
                    lbl_commentsHeader.Text = "Comments from our Users";
                }
            }
        }
    }

    protected void reptr_Comments_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //string test = e.Item.DataItem.ToString();
        LinkButton lb = (LinkButton)e.CommandSource;

        if (e.CommandName == "likeComment")
        {
            if (lb.Text == LBTEXT)
            {
                List<String> SeperateIdfromlikedUsers = e.CommandArgument.ToString().Split('#').ToList<string>();
                int commentId = Convert.ToInt32(SeperateIdfromlikedUsers[0]);
                string likedUser = userName;
                likeThisCropVO likeSelectedCrop = new likeThisCropVO(commentId, likedUser,Convert.ToInt32(Convert.ToInt32(cropID.Text)));
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

                List<String> SeperateIdfromlikedUsers = e.CommandArgument.ToString().Split('#').ToList<string>();
                int commentId = Convert.ToInt32(SeperateIdfromlikedUsers[0]);
                string likedUser = userName;
                DataTable dt = (DataTable)reptr_Comments.DataSource;
                string likedUsers1 = SeperateIdfromlikedUsers[1];
                List<string> eachUser = likedUsers1.Split(':').ToList<string>();
                eachUser.RemoveAt(eachUser.IndexOf(userName));
                string concatenatedUsers = string.Join<string>(":", eachUser);
                likeThisCropVO likeSelectedCrop = new likeThisCropVO(commentId, likedUser, (Convert.ToInt32(cropID.Text)), concatenatedUsers);
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
        if (e.CommandName == "editComment")
        {
            string labelid = "reptr_Comments_comments_" + e.Item.ItemIndex;
            Label l = (Label)e.Item.FindControl("comments");
            l.Visible=false;
            //TextBox txt_toDisplay = ((TextBox)e.Item.FindControl("tb_comments"));
            //txt_toDisplay.Visible = true;
            //txt_toDisplay.Text = l.Text;
            ((TextBox)e.Item.FindControl("tb_comments")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Edit")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Delete")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Update")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Cancel")).Visible = true;
        }
        if(e.CommandName == "updateComment")
        {
            TextBox selectedTextBox = ((TextBox)e.Item.FindControl("tb_comments"));
            cropCommentVO updateComments = new cropCommentVO();
            updateComments.commentId = Convert.ToInt32(e.CommandArgument);
            updateComments.comments = selectedTextBox.Text;
            string result = cropDAO.updateComments(updateComments);
            if(result == "success")
            {
                reptr_Comments.DataSource = cropDAO.refreshCropComments(Convert.ToInt32(cropID.Text));
                reptr_Comments.DataBind();
            }
        }
        if(e.CommandName=="deleteComment")
        {
            
            string result = cropDAO.deleteComment(Convert.ToInt32(e.CommandArgument));
            if(result== "success")
            {
                reptr_Comments.DataSource = cropDAO.refreshCropComments(Convert.ToInt32(cropID.Text));
                reptr_Comments.DataBind();
            }
        }
        if(e.CommandName=="cancelComment")
        {
            ((Label)e.Item.FindControl("comments")).Visible = true;
            ((TextBox)e.Item.FindControl("tb_comments")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Edit")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Delete")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Update")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Cancel")).Visible = false;
        }
    }

    protected void btn_Endorse_Click(object sender, EventArgs e)
    {
        if(btn_Endorse.Text=="Endorse")
        {
            endorseCrop endorseRequest = new endorseCrop(userName,(Convert.ToInt32(cropID.Text)));
            string endorsedUsersAfterUpdate = cropDAO.endorseCrop(endorseRequest);
            if (endorsedUsersAfterUpdate == null)
            {
                lblStatus.Text = "There was an error";
            }
            else
            {
                endorsedUsers.Text = endorsedUsersAfterUpdate;
                List<String> countOfUsers = endorsedUsersAfterUpdate.Split(':').ToList<string>();
                countOfUsers.RemoveAt(0);
                lbl_endorsedUsers.Text = countOfUsers.Count.ToString();
                btn_Endorse.DataBind();
                
            }
        }
        else 
        {
            List<string> endorsedUsersList = endorsedUsers.Text.Split(':').ToList<string>();
            endorsedUsersList.RemoveAt(endorsedUsersList.IndexOf(userName));
            string concatenatedUsers = string.Join<string>(":", endorsedUsersList);
            endorseCrop endorseRequest = new endorseCrop(userName, concatenatedUsers, (Convert.ToInt32(cropID.Text)));
            string endorsedUsersAfterUpdate = cropDAO.endorseCrop(endorseRequest);
            if (endorsedUsersAfterUpdate == null)
            {
                lblStatus.Text = "There was an error";
            }
            else
            {
                endorsedUsers.Text = endorsedUsersAfterUpdate;
                List<String> countOfUsers = endorsedUsersAfterUpdate.Split(':').ToList<string>();
                countOfUsers.RemoveAt(0);
                lbl_endorsedUsers.Text = countOfUsers.Count.ToString();
                btn_Endorse.DataBind();
            }
            //cropDAO.unEndorseCrop(userName);
        }
    }
}


//endorsedUsers is a label that stores the list of endorsed Users for the crop. IT is hiddden
//cropID is a label that stores the current crop ID and it is hidden