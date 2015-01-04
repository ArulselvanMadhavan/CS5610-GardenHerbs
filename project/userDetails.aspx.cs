using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Net;
using System.Configuration;

public partial class project_userDetails : System.Web.UI.Page
{
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    //string loggedinUser = "whunting";
    //string seperator = " | ";
    string LBTEXT = "Like";
    string LBTEXTTOGGLED = "UnLike";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //string userName = "whunting"; //Request from Query String
        string userName = Request.QueryString["username"];
        if(userName==null)
        {
            lbl_pageLoadError.Text = "It appears you accessed this page directly. Please follow proper flow and access this page";
        }
        lbl_username.Text = userName;
        
        // CHeck if no one has signed in . 
        if(User.Identity.Name=="")
        {
            txt_postContent.Visible = false;
            btn_post.Visible = false;
        }
        

        if (!IsPostBack)
        {

            userDetailsVO requestedUserDetails = new userDetailsVO(userName);
            userDetailsVO ResultsfromDB = new userDetailsVO();
            ResultsfromDB = cropDAO.fetchUserDetails(requestedUserDetails);
            if (ResultsfromDB != null)
            {
                img_UserLogo.ImageUrl = "~/images/user/" + ResultsfromDB.userImageId.Trim() + ".jpg";
                lbl_userFullName.Text = ResultsfromDB.userFullName;
                lbl_userLocation.Text = ResultsfromDB.location;
                lbl_occupation.Text = ResultsfromDB.occupation;
                lbl_plantedSoFar.Text = ResultsfromDB.plantedSoFar;
                lbl_userID.Text = ResultsfromDB.userid.ToString();
                if (ResultsfromDB.wallPosts.Rows.Count == 0)
                {
                    lbl_postHeader.Text = "No one has Posted on this wall yet";
                    lbl_postHeader.Visible = true;
                }
                else
                {
                    lbl_postHeader.Text = "Comments from our Users";
                    lbl_postHeader.Visible = true;
                    DataTable postResults = ResultsfromDB.wallPosts;
                    reptr_Comments.DataSource = postResults;
                    reptr_Comments.DataBind();
                }
            }

            if (userName != null)
            {
                d_wall.Visible = true;
                lbl_wallHeader.Text = lbl_userFullName.Text + " 's Wall";
            }
            else
            {
                d_wall.Visible = false;
               
            }
        }
    }
    protected void btn_post_Click(object sender, EventArgs e)
    {
        if ((txt_postContent.Text == null) || (txt_postContent.Text.Length > 499))
        {
            lblStatus.Visible = true;
            lblStatus.Text = "Please enter a valid Comment";
        }
        else
        {
            postVO post = new postVO(Convert.ToInt32(lbl_userID.Text), lbl_username.Text, User.Identity.Name, txt_postContent.Text.Trim());
            string result = cropDAO.insertPost(post);
            if (result == "success")
            {
                txt_postContent.Text = "";
                reptr_Comments.DataSource = cropDAO.refreshWallPosts((Convert.ToInt32(lbl_userID.Text)));
                reptr_Comments.DataBind();
                if (lbl_wallHeader.Text == "No Comments to Display")
                {
                    lbl_wallHeader.Text = "Comments from our Users";
                }
            }
        }
    }
    public string getText(int postId)
    {
        if (User.Identity.Name == "")
        {
            return "";
        }
        else
        {
            List<string> eachUser = getLikedUsers(postId);
            if (eachUser.Contains(User.Identity.Name))
            {
                return "UnLike";
            }
            else
            {
                return "Like";
            }
        }
    }
    public List<string> getLikedUsers(int postId)
    {
        DataTable dt = (DataTable)reptr_Comments.DataSource;
        string likedUsers1 = dt.Rows[postId]["likedUsers"].ToString();
        List<string> eachUser = likedUsers1.Split(':').ToList<string>();
        eachUser.RemoveAt(0);
        return eachUser;
    }

    public string getTotalLikes(int postId)
    {
        List<string> eachUser = getLikedUsers(postId);
        if (eachUser.Contains(User.Identity.Name))
        {
            if (eachUser.Count == 1)
            {
                return string.Concat("You like this post");
            }
            else
                return string.Concat("You", " and ", eachUser.Count - 1, " Others like this post");
        }
        else if (eachUser.Count == 0)
        {
            return null;
        }
        else
        {
            return string.Concat(eachUser.Count, " User(s) like this post.");
        }
    }

    public string frameURL(String userImageId)
    {
        return "~/images/user/" + userImageId + ".jpg";
    }
    public string getEditText(string postedBy)
    {
        if (postedBy == User.Identity.Name)
        {
            return "Edit";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getUpdateText(string postedBy)
    {


        if (postedBy == User.Identity.Name)
        {
            return "Update";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getDeleteText(string postedBy)
    {


        if ((postedBy == User.Identity.Name) || (User.Identity.Name == lbl_username.Text))
        {
            return "Delete";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
        }
    }
    public string getCancelText(string postedBy)
    {


        if (postedBy == User.Identity.Name)
        {
            return "Cancel";
        }
        else
        {
            return ""; // No Edit Option for Unlogged In Users
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
                int postId = Convert.ToInt32(SeperateIdfromlikedUsers[0]);
                string likedUser = User.Identity.Name;
                likeThisPostVO likeSelectedPost = new likeThisPostVO(postId, likedUser, (Convert.ToInt32(lbl_userID.Text)));
                DataTable result = cropDAO.updateWallPostLikes(likeSelectedPost);
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
                int postId = Convert.ToInt32(SeperateIdfromlikedUsers[0]);
                string likedUser = User.Identity.Name;
                DataTable dt = (DataTable)reptr_Comments.DataSource;
                string likedUsers1 = SeperateIdfromlikedUsers[1];
                List<string> eachUser = likedUsers1.Split(':').ToList<string>();
                eachUser.RemoveAt(eachUser.IndexOf(User.Identity.Name));
                string concatenatedUsers = string.Join<string>(":", eachUser);
                likeThisPostVO likeSelectedCrop = new likeThisPostVO(postId, likedUser, (Convert.ToInt32(lbl_userID.Text)), concatenatedUsers);
                DataTable result = cropDAO.updateWallPostLikes(likeSelectedCrop);
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
            l.Visible = false;
            //TextBox txt_toDisplay = ((TextBox)e.Item.FindControl("tb_comments"));
            //txt_toDisplay.Visible = true;
            //txt_toDisplay.Text = l.Text;
            ((TextBox)e.Item.FindControl("tb_comments")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Edit")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Delete")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Update")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Cancel")).Visible = true;
        }
        if (e.CommandName == "updateComment")
        {
            TextBox selectedTextBox = ((TextBox)e.Item.FindControl("tb_comments"));
            postVO updatePost = new postVO();
            updatePost.postid = Convert.ToInt32(e.CommandArgument);
            updatePost.postContent = selectedTextBox.Text;
            string result = cropDAO.updatePost(updatePost);
            if (result == "success")
            {
                reptr_Comments.DataSource = cropDAO.refreshWallPosts(Convert.ToInt32(lbl_userID.Text));
                reptr_Comments.DataBind();
            }
        }
        if (e.CommandName == "deleteComment")
        {

            string result = cropDAO.deletePost(Convert.ToInt32(e.CommandArgument));
            if (result == "success")
            {
                reptr_Comments.DataSource = cropDAO.refreshWallPosts(Convert.ToInt32(lbl_userID.Text));
                reptr_Comments.DataBind();
            }
        }
        if (e.CommandName == "cancelComment")
        {
            ((Label)e.Item.FindControl("comments")).Visible = true;
            ((TextBox)e.Item.FindControl("tb_comments")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Edit")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Delete")).Visible = true;
            ((LinkButton)e.Item.FindControl("a_Update")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_Cancel")).Visible = false;
        }

        if (e.CommandName == "replyComment")
        {
            TextBox replyTextBox = ((TextBox)e.Item.FindControl("txt_reply"));
            if ((replyTextBox.Text == "") || (replyTextBox.Text == null))
            {
                // Do Nothing
            }
            else
            {
                int postId = Convert.ToInt32(e.CommandArgument);
                string wallName = lbl_username.Text;
                string postedBy = User.Identity.Name;
                string reply = replyTextBox.Text;
                replyPostVO addReplyRequest = new replyPostVO(postId, wallName, postedBy, reply);
                cropDAO.insertPostComments(addReplyRequest);


                Repeater replyRepeater = (Repeater)(e.Item.FindControl("reptr_replies"));
                DataTable refreshedPost;
                if (replyRepeater.Items.Count <= 3)
                {
                    refreshedPost = (cropDAO.refreshPost(postId));
                }
                else
                {
                    refreshedPost = (cropDAO.viewAllReplies(addReplyRequest));
                }
                if (refreshedPost != null)
                {
                    replyTextBox.Text = "";
                    replyRepeater.DataSource = refreshedPost;
                    replyRepeater.DataBind();
                    Label l = ((Label)e.Item.FindControl("lbl_repliesCount"));
                    //DataTable dt = fetchLatestReplies(Convert.ToInt32(table.Rows[i]["postId"]), connection);
                    if (refreshedPost.Rows.Count != 0)
                    {
                        // string test = refreshedPost.Rows[0]["repliesCount"].ToString();
                        l.Text = "Replies(" + refreshedPost.Rows[0]["repliesCount"].ToString() + ")";  // Get Replies Count from the first row
                        l.DataBind();
                        //table.Rows[i]["replies"] = dt;
                    }
                    else
                    {
                        l.Text = "Replies(0)";
                        l.DataBind();
                        //table.Rows[i]["replies"] = dt;
                    }
                }
            }
        }

        if (e.CommandName == "allReplies")
        {

            int postId = Convert.ToInt32(e.CommandArgument);
            string wallName = lbl_username.Text;
            string postedBy = User.Identity.Name;

            replyPostVO viewAllRepliesRequest = new replyPostVO(postId);


            Repeater replyRepeater = (Repeater)(e.Item.FindControl("reptr_replies"));
            DataTable refreshedPost = cropDAO.viewAllReplies(viewAllRepliesRequest);
            replyRepeater.DataSource = refreshedPost;
            replyRepeater.DataBind();
            ((LinkButton)e.Item.FindControl("a_replies")).Visible = false;
            ((LinkButton)e.Item.FindControl("a_hide")).Visible = true;
            //Label l = ((Label)e.Item.FindControl("lbl_repliesCount"));
            ////DataTable dt = fetchLatestReplies(Convert.ToInt32(table.Rows[i]["postId"]), connection);
            //if (refreshedPost.Rows.Count != 0)
            //{
            //    // string test = refreshedPost.Rows[0]["repliesCount"].ToString();
            //    l.Text = "Replies(" + refreshedPost.Rows[0]["repliesCount"].ToString() + ")";  // Get Replies Count from the first row
            //    l.DataBind();
            //    //table.Rows[i]["replies"] = dt;
            //}
            //else
            //{
            //    l.Text = "Replies(0)";
            //    l.DataBind();
            //    //table.Rows[i]["replies"] = dt;
            //}


        }

        if (e.CommandName == "hideReplies")
        {

            int postId = Convert.ToInt32(e.CommandArgument);
            string wallName = lbl_username.Text;
            string postedBy = User.Identity.Name;
            Repeater replyRepeater = (Repeater)(e.Item.FindControl("reptr_replies"));
            DataTable refreshedPost = (cropDAO.refreshPost(postId));

            if (refreshedPost != null)
            {
                replyRepeater.DataSource = refreshedPost;
                replyRepeater.DataBind();
                ((LinkButton)e.Item.FindControl("a_replies")).Visible = true;
                ((LinkButton)e.Item.FindControl("a_hide")).Visible = false;
            }

        }
    }
    protected void reptr_Comments_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if(User.Identity.Name == "")
        {
            e.Item.FindControl("txt_reply").Visible = false;
            e.Item.FindControl("a_reply").Visible = false;
        }
        

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            RepeaterItem item = e.Item;
            Repeater Repeater2 = (Repeater)(e.Item.FindControl("reptr_replies"));
            Repeater2.DataSource = DataBinder.Eval(item.DataItem, "replies");

            Repeater2.DataBind();
            //DataRowView drv = (DataRowView)e.Item.DataItem;
            //if(drv != null)
            //{
            //    Repeater Repeater2 = (Repeater)(e.Item.FindControl("reptr_replies"));
            //    if(Repeater2 != null)
            //    {
            //        Repeater2.DataSource = drv.
            //    }
            //}

            //reptr_replies.DataSource = dt.
            //reptr_replies.DataBind();
        }
    }
}