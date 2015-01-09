using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for cropDetailsDAO
/// </summary>
public class cropDetailsDAO
{

    public cropDetailsDAO()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public cropNameVO getCropDetails(cropNameVO crop)
    {
        cropNameVO cropresults = new cropNameVO();
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "select um.uploadId,um.cropName,cm.cropScientificName,cm.productionPractices,um.methodFollowedByUser,um.numberOfPlantings,um.plantedOn,um.plantedFrom,um.shade,um.endorsedUsers,um.userName from arulselv.uploadMaster um left join arulselv.cropmaster cm on um.cropId=cm.cropId where um.uploadId=@requestedCrop";
        //string sqlquery = "select cropmaster.cropname as [Crop Name],cropmaster.cropscientificname as [Scientific Name],cropmaster.[production practices] as [Production Practices],cropbrowse.bestimgid as [bestImageId] from arulselv.cropmaster cropmaster left join arulselv.browse_crops cropbrowse on cropmaster.cropname=cropbrowse.cropname AND cropmaster.cropname=@cropname";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter cropnameParam = new SqlParameter("@requestedCrop", crop.requestedCropID);
        command.Parameters.Add(cropnameParam);

        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            cropresults.cropName = table.Rows[0]["cropName"].ToString();
            cropresults.cropScientificName = table.Rows[0]["cropScientificName"].ToString();
            cropresults.suggestedProductionPractices = table.Rows[0]["productionPractices"].ToString();
            cropresults.methodFollowedByUser = table.Rows[0]["methodFollowedByUser"].ToString();
            cropresults.numberOfPlantings = table.Rows[0]["numberOfPlantings"].ToString();
            cropresults.PlantedOn = table.Rows[0]["plantedOn"].ToString();
            cropresults.plantedFrom = table.Rows[0]["plantedFrom"].ToString();
            cropresults.shade = table.Rows[0]["shade"].ToString();
            cropresults.cropImageId = Convert.ToInt32(table.Rows[0]["uploadId"]);
            cropresults.endorsedUsers = table.Rows[0]["endorsedUsers"].ToString();
            cropresults.userName = table.Rows[0]["userName"].ToString();

            //Get Crop Comments
            cropresults.cropComments = getCropComments(crop.requestedCropID, connection);
            return cropresults;
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

    public DataTable getCropComments(int uploadId, SqlConnection connection)
    {
        string sqlquery = "select cm.commentid,cm.cropname as [cropName],cm.username as [userName],cm.date as [commentedAt],cm.comments,cm.likedusers as [likedUsers],udm.userimg from arulselv.commentsmaster cm left join arulselv.userDetailsMaster udm on cm.username = udm.userName where uploadId=@uploadId order by commentedAt desc";
        //string sqlquery = "select commentid as [commentId],cropname as [cropName],username as [userName],date as [commentedAt],comments,likedusers as [likedUsers] from arulselv.commentsmaster where uploadId=@uploadId order by commentedAt desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter cropnameParam = new SqlParameter("@uploadId", uploadId);
        command.Parameters.Add(cropnameParam);

        try
        {
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
        }
        catch
        {
            return null;

        }
    }

    public DataTable refreshCropComments(int uploadId)
    {
        cropNameVO cropresults = new cropNameVO();
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());

        //string sqlquery = "select commentid,cropname as [cropName],username as [userName],date as [commentedAt],comments,likedusers as [likedUsers] from arulselv.commentsmaster where uploadId=@uploadID order by commentedAt desc";
        string sqlquery = "select cm.commentid,cm.cropname as [cropName],cm.username as [userName],cm.date as [commentedAt],cm.comments,cm.likedusers as [likedUsers],udm.userimg from arulselv.commentsmaster cm left join arulselv.userDetailsMaster udm on cm.username = udm.userName where uploadId=@uploadId order by commentedAt desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter cropnameParam = new SqlParameter("@uploadId", uploadId);
        command.Parameters.Add(cropnameParam);

        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;

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


    public string insertComment(cropCommentVO userComments)
    {

        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "insert into arulselv.commentsmaster(cropname,username,comments,uploadId) values (@cropname,@username,@comments,@uploadId)";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter cropnameParam = new SqlParameter("@cropname", userComments.cropName);
        SqlParameter userNameParam = new SqlParameter("@username", userComments.commentedUser);
        SqlParameter commentsParam = new SqlParameter("@comments", userComments.comments);
        SqlParameter uploadIdParam = new SqlParameter("@uploadId", userComments.uploadId);
        command.Parameters.Add(cropnameParam);
        command.Parameters.Add(userNameParam);
        command.Parameters.Add(commentsParam);
        command.Parameters.Add(uploadIdParam);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "fail";
        }
        finally
        {
            connection.Close();
        }
    }
    public DataTable updateLikedUsers(likeThisCropVO addLikedUser)
    {

        SqlConnection connection = null;
        SqlCommand command;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        if (addLikedUser.allLikedUsers == null)  //To differentiate whether the Update call was for 'Liking' or 'Unliking' a Comment. 
        {
            string sqlquery = "update arulselv.commentsmaster set likedusers= ISNULL(likedusers, '') + ':'+ @userName where commentid =@commentId";
            command = new SqlCommand(sqlquery, connection);
            SqlParameter likedUserParam = new SqlParameter("@userName", addLikedUser.userName);
            SqlParameter commentIdParam = new SqlParameter("@commentId", addLikedUser.commentId);
            command.Parameters.Add(likedUserParam);
            command.Parameters.Add(commentIdParam);
        }
        else
        {
            string sqlquery;
            if (addLikedUser.allLikedUsers == "")
            {
                sqlquery = "update arulselv.commentsmaster set likedusers= NULL where commentid =@commentId";
            }
            else
            {
                sqlquery = "update arulselv.commentsmaster set likedusers= @allLikedUsers where commentid =@commentId";
            }
            command = new SqlCommand(sqlquery, connection);
            SqlParameter likedUserParam = new SqlParameter("@allLikedUsers", addLikedUser.allLikedUsers);
            SqlParameter commentIdParam = new SqlParameter("@commentId", addLikedUser.commentId);
            command.Parameters.Add(likedUserParam);
            command.Parameters.Add(commentIdParam);
        }

        try
        {
            connection.Open();
            int rowsAffected = command.ExecuteNonQuery();
            if (rowsAffected != null)
            {
                connection = null;
                return refreshCropComments(addLikedUser.uploadId);
            }
            else
            {
                connection.Close();
                return null;
            }
        }
        catch
        {
            connection.Close();
            return null;
        }
    }
    public userDetailsVO fetchUserDetails(userDetailsVO requestUserDetails)
    {
        userDetailsVO userDetailsResults = new userDetailsVO();
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        //string sqlquery = "select * from arulselv.userDetailsMaster where userName=@userName" ;
        string sqlquery = "select um.userId,um.userName,um.userFullName,um.location,um.occupation,um.followedCrops,um.userimg,count(up.userName) as plantedSoFar from arulselv.userDetailsMaster um right join arulselv.uploadMaster up on um.userName=up.userName where um.userName = @userName group by um.userId,um.userName,um.userFullName,um.location,um.occupation,um.followedCrops,um.userimg";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter userNameParam = new SqlParameter("@userName", requestUserDetails.userName);
        command.Parameters.Add(userNameParam);
        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            userDetailsResults.userName = table.Rows[0]["userName"].ToString();
            userDetailsResults.userFullName = table.Rows[0]["userFullName"].ToString();
            userDetailsResults.userid = Convert.ToInt32(table.Rows[0]["userId"]);
            userDetailsResults.location = table.Rows[0]["location"].ToString();
            userDetailsResults.occupation = table.Rows[0]["occupation"].ToString();
            userDetailsResults.followedCrops = table.Rows[0]["followedCrops"].ToString();
            userDetailsResults.userImageId = table.Rows[0]["userimg"].ToString();
            userDetailsResults.plantedSoFar = table.Rows[0]["plantedSoFar"].ToString();
            userDetailsResults.wallPosts = getWallPosts(userDetailsResults.userid, connection); // Use th same connection to fetch wall posts
            return userDetailsResults;
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

    public DataTable getWallPosts(int userId, SqlConnection connection)
    {
        //string sqlquery = "select commentid as [commentId],cropname as [cropName],username as [userName],date as [commentedAt],comments,likedusers as [likedUsers] from arulselv.commentsmaster where uploadId=@uploadId order by commentedAt desc";
        //string sqlquery = "select pm.postid as [postId], pm.wallname as [wallName],pm.postedBy,pm.postedDate,pm.postContent,pm.likedusers as [likedUsers],um.userimg from arulselv.postmaster pm left join arulselv.userDetailsMaster um on pm.userId = um.userId where pm.userId = @userId order by postedDate desc";
        string sqlquery = "select pm.postid as [postId], pm.wallname as [wallName],pm.postedBy,pm.postedDate,pm.postContent,pm.likedusers as [likedUsers],um.userimg from arulselv.postmaster pm left join arulselv.userDetailsMaster um on pm.postedBy = um.userName where pm.userId = @userId order by postedDate desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter userIdParam = new SqlParameter("@userId", userId);
        command.Parameters.Add(userIdParam);

        try
        {
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);

            // Fetch Replies for each Post
            if (table.Rows.Count != 0)
            {
                table.Columns.Add(new DataColumn("replies", typeof(DataTable)));
                table.Columns.Add(new DataColumn("repliesCount", typeof(Int32)));
            }
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataTable dt = fetchLatestReplies(Convert.ToInt32(table.Rows[i]["postId"]), connection);
                if (dt.Rows.Count != 0)
                {
                    table.Rows[i]["repliesCount"] = dt.Rows[0]["repliesCount"];  // Get Replies Count from the first row
                    table.Rows[i]["replies"] = dt;
                }
                else
                {
                    table.Rows[i]["repliesCount"] = 0;
                    table.Rows[i]["replies"] = dt;
                }
            }
            return table;
        }
        catch
        {
            return null;
        }
    }

    private DataTable fetchLatestReplies(int postId, SqlConnection connection)
    {
        //string sqlquery = "select  top 3 pc.commentid,pc.postId,pc.commentedUser, pc.commentedDate, pc.comments,ud.userimg  from arulselv.postComments pc left join arulselv.userDetailsMaster ud on pc.wallName = ud.userName where pc.postId=@postId order by pc.commentedDate desc";
        string sqlquery = "select top 3 pc.commentid,pc.postId,pc.commentedUser, pc.commentedDate, pc.comments,ud.userimg,(select count(*) as repliesCount from arulselv.postComments where postId=@postId) as repliesCount from arulselv.postComments pc left join arulselv.userDetailsMaster ud on pc.commentedUser = ud.userName where pc.postId=@postId group by pc.commentedDate,pc.commentid,pc.postId,pc.commentedUser,ud.userimg,pc.comments order by pc.commentedDate desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter postIdParam = new SqlParameter("@postId", postId);
        command.Parameters.Add(postIdParam);
        try
        {
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable replies = new DataTable();
            da.Fill(replies);
            return replies;
        }
        catch
        {
            return null;
        }
    }


    public DataTable refreshWallPosts(int userId)
    {
        //cropNameVO cropresults = new cropNameVO();
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());

        //string sqlquery = "select commentid,cropname as [cropName],username as [userName],date as [commentedAt],comments,likedusers as [likedUsers] from arulselv.commentsmaster where uploadId=@uploadID order by commentedAt desc";
        string sqlquery = "select pm.postid as [postId], pm.wallname as [wallName],pm.postedBy,pm.postedDate,pm.postContent,pm.likedusers as [likedUsers],um.userimg from arulselv.postmaster pm left join arulselv.userDetailsMaster um on pm.userId = um.userId where pm.userId = @userId order by postedDate desc";
        //string sqlquery = "select postid as [postId], wallname as [wallName],postedBy,postedDate,postContent,likedusers as [likedUsers] from arulselv.postmaster where userId = @userId order by postedDate desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter wallNameParam = new SqlParameter("@userId", userId);
        command.Parameters.Add(wallNameParam);

        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            // Fetch Replies for each Post
            if (table.Rows.Count != 0)
            {
                table.Columns.Add(new DataColumn("replies", typeof(DataTable)));
                table.Columns.Add(new DataColumn("repliesCount", typeof(Int32)));
            }
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataTable dt = fetchLatestReplies(Convert.ToInt32(table.Rows[i]["postId"]), connection);
                if (dt.Rows.Count != 0)
                {
                    table.Rows[i]["repliesCount"] = dt.Rows[0]["repliesCount"];  // Get Replies Count from the first row
                    table.Rows[i]["replies"] = dt;
                }
                else
                {
                    table.Rows[i]["repliesCount"] = 0;
                    table.Rows[i]["replies"] = dt;
                }
            }
            return table;
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

    public DataTable fetchCropsSupported()
    {

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "select * from arulselv.cropmaster";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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

    public int uploadUserCrop(cropUploadVO cropDetailsToUpload, Byte[] imgByte)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "INSERT INTO arulselv.uploadMaster (userName,cropId,cropName,numberOfPlantings,plantedFrom,shade,cropImage,methodFollowedByUser) VALUES(@userName,@cropId,@cropName, @totalPlantings,@plantedFrom,@shade,@cropImage,@methodFollowedByUser) SELECT @@IDENTITY";
        SqlCommand cmd = new SqlCommand(sql, connection);
        cmd.Parameters.AddWithValue("@userName", cropDetailsToUpload.userName);
        cmd.Parameters.AddWithValue("@cropId", cropDetailsToUpload.cropId);
        cmd.Parameters.AddWithValue("@cropName", cropDetailsToUpload.cropName);
        cmd.Parameters.AddWithValue("@totalPlantings", cropDetailsToUpload.totalPlantings);
        cmd.Parameters.AddWithValue("@plantedFrom", cropDetailsToUpload.plantedFrom);
        cmd.Parameters.AddWithValue("@shade", cropDetailsToUpload.shade);
        cmd.Parameters.AddWithValue("@cropImage", imgByte);
        cmd.Parameters.AddWithValue("@methodFollowedByUser", cropDetailsToUpload.productionPractice);
        //@cropName, @totalPlantings,@plantedFrom,@Shade,@cropImage)
        try
        {
            connection.Open();
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
        catch
        {
            return 0;
        }
        finally
        {
            connection.Close();
        }
    }

    public string endorseCrop(endorseCrop endorseRequest)
    {

        SqlConnection connection = null;
        SqlCommand command;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        if (endorseRequest.allEndorsedUsers == null)  //To differentiate whether the Update call was for 'Liking' or 'Unliking' a Comment
        {
            string sqlquery = "update arulselv.uploadMaster set endorsedUsers= ISNULL(endorsedUsers, '') + ':'+ @userName where uploadId =@uploadId";
            command = new SqlCommand(sqlquery, connection);
            SqlParameter endorsedUserParam = new SqlParameter("@userName", endorseRequest.userName);
            SqlParameter uploadIdParam = new SqlParameter("@uploadId", endorseRequest.uploadId);
            command.Parameters.Add(endorsedUserParam);
            command.Parameters.Add(uploadIdParam);
        }
        else
        {
            string sqlquery;
            if (endorseRequest.allEndorsedUsers == "")
            {
                sqlquery = "update arulselv.uploadMaster set endorsedUsers= NULL where uploadId =@uploadId";
            }
            else
            {
                sqlquery = "update arulselv.uploadMaster set endorsedUsers= @allEndorsedUsers where uploadId =@uploadId";
            }
            command = new SqlCommand(sqlquery, connection);
            SqlParameter endorsedUserParam = new SqlParameter("@allEndorsedUsers", endorseRequest.allEndorsedUsers);
            SqlParameter uploadIdParam = new SqlParameter("@uploadId", endorseRequest.uploadId);
            command.Parameters.Add(endorsedUserParam);
            command.Parameters.Add(uploadIdParam);
        }

        try
        {
            connection.Open();
            int rowsAffected = command.ExecuteNonQuery();
            if (rowsAffected != null)
            {
                string sqlquery = "select endorsedUsers from arulselv.uploadMaster where uploadId = @uploadId";
                command = new SqlCommand(sqlquery, connection);
                SqlParameter uploadIdParam = new SqlParameter("@uploadId", endorseRequest.uploadId);
                command.Parameters.Add(uploadIdParam);
                string endorsedUsersAfterUpdate = command.ExecuteScalar().ToString();
                connection = null;
                return endorsedUsersAfterUpdate;
            }
            else
            {
                connection.Close();
                return null;
            }
        }
        catch
        {
            connection.Close();
            return null;
        }
    }

    public string updateComments(cropCommentVO updateComments)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "update arulselv.commentsmaster set comments = @updatedComments where commentId = @commentId";
        SqlCommand command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@updatedComments", updateComments.comments);
        command.Parameters.AddWithValue("@commentId", updateComments.commentId);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "failed";
        }
        finally
        {
            connection.Close();
        }
    }
    public string deleteComment(int commentId)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "delete from arulselv.commentsmaster where commentId = @commentId";
        SqlCommand command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@commentId", commentId);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "failed";
        }
        finally
        {
            connection.Close();
        }
    }
    public DataTable queryForCrop(cropResultsVO cropSearchRequest)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "select * from arulselv.uploadMaster where cropName like @cropname order by endorsedUsers desc";
        SqlCommand command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@cropName", string.Concat("%" + cropSearchRequest.cropName + "%"));
        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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

    public object getRecentUploads()
    {

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "select * from arulselv.recentUploadsView";
        SqlCommand command = new SqlCommand(sql, connection);
        try
        {
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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

    public DataTable browseCrops()
    {
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
            connection.Open();
            //string sql = "select * from [cropresults_test_view]";
            string sql = "select cm.cropname,cm.bestPlantingid,cm.cropScientificName,count(um.CropName) as plantedtimes from arulselv.cropmaster cm left join arulselv.uploadMaster um on (cm.cropname=um.CropName) group by cm.cropname,cm.bestPlantingid,cm.cropScientificName order by plantedtimes desc";
            SqlDataAdapter da = new SqlDataAdapter(sql, connection);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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


    public object fetchStateDetails()
    {
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
            connection.Open();
            //string sql = "select * from [cropresults_test_view]";
            string sql = "select * from arulselv.stateDetailsView order by stateName asc";
            SqlDataAdapter da = new SqlDataAdapter(sql, connection);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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

    public DataTable fetchZipCodeDetails(string p)
    {
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
            connection.Open();
            //string sql = "select * from [cropresults_test_view]";
            string sql = "select distinct zipcode from arulselv.state_details where stateName like @stateName";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@stateName", p.Trim());
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            da.Fill(table);
            return table;
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

    public string insertPost(postVO post)
    {

        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "insert into arulselv.postmaster (userId,wallName,postedBy,postContent) values (@userId,@wallName,@postedBy,@postContent)";
        //string sqlquery = "insert into arulselv.postmaster(cropname,username,comments,uploadId) values (@cropname,@username,@comments,@uploadId)";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter userIdParam = new SqlParameter("@userId", post.userId);
        SqlParameter userNameParam = new SqlParameter("@wallName", post.wallName);
        SqlParameter postedByParam = new SqlParameter("@postedBy", post.postedBy);
        SqlParameter postContentParam = new SqlParameter("@postContent", post.postContent);
        command.Parameters.Add(userIdParam);
        command.Parameters.Add(userNameParam);
        command.Parameters.Add(postedByParam);
        command.Parameters.Add(postContentParam);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "fail";
        }
        finally
        {
            connection.Close();
        }
    }

    public DataTable updateWallPostLikes(likeThisPostVO likeSelectedPost)
    {
        SqlConnection connection = null;
        SqlCommand command;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        if (likeSelectedPost.allLikedUsers == null)  //To differentiate whether the Update call was for 'Liking' or 'Unliking' a Comment. The method call for unliking an user will ALWAYS have alllikedUsers content . IT will not be NULL.
        {
            string sqlquery = "update arulselv.postmaster set likedUsers= ISNULL(likedUsers, '') + ':'+ @likeduserName where postId = @postId";
            command = new SqlCommand(sqlquery, connection);
            SqlParameter likedUserParam = new SqlParameter("@likeduserName", likeSelectedPost.likedUser);
            SqlParameter commentIdParam = new SqlParameter("@postId", likeSelectedPost.postId);
            command.Parameters.Add(likedUserParam);
            command.Parameters.Add(commentIdParam);
        }
        else
        {
            string sqlquery;
            if (likeSelectedPost.allLikedUsers == "")
            {
                sqlquery = "update arulselv.postmaster set likedUsers= NULL where postId =@postId";
            }
            else
            {
                sqlquery = "update arulselv.postmaster set likedUsers= @allLikedUsers where postId =@postId";
            }
            command = new SqlCommand(sqlquery, connection);
            SqlParameter likedUserParam = new SqlParameter("@allLikedUsers", likeSelectedPost.allLikedUsers);
            SqlParameter postIdParam = new SqlParameter("@postId", likeSelectedPost.postId);
            command.Parameters.Add(likedUserParam);
            command.Parameters.Add(postIdParam);
        }

        try
        {
            connection.Open();
            int rowsAffected = command.ExecuteNonQuery();
            if (rowsAffected != null)
            {
                connection = null;
                return refreshWallPosts(likeSelectedPost.userId);
            }
            else
            {
                connection.Close();
                return null;
            }
        }
        catch
        {
            connection.Close();
            return null;
        }
    }


    public string updatePost(postVO updatePost)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "update arulselv.postmaster set postContent = @updatedPost where postId = @postId";
        SqlCommand command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@updatedPost", updatePost.postContent);
        command.Parameters.AddWithValue("@postId", updatePost.postid);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "failed";
        }
        finally
        {
            connection.Close();
        }
    }

    public string deletePost(int postId)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql1 = "delete from arulselv.postComments where postId=@postId";     // Delete Foreign Key first and then delete the post from parent table
        string sql2 = "delete from arulselv.postmaster where postId = @postId";
        SqlCommand command1 = new SqlCommand(sql1, connection);
        SqlCommand command2 = new SqlCommand(sql2, connection);
        command1.Parameters.AddWithValue("@postId", postId);
        command2.Parameters.AddWithValue("@postId", postId);
        try
        {
            connection.Open();
            command1.ExecuteNonQuery();
            command2.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "failed";
        }
        finally
        {
            connection.Close();
        }
    }


    public string insertPostComments(replyPostVO addReplyRequest)
    {
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "insert into arulselv.postComments(postid,commentedUser,wallName,comments,likedusers) values (@postId,@commentedUser,@wallName,@reply,NULL)";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter postIdParam = new SqlParameter("@postId", addReplyRequest.postId);
        SqlParameter postedBy = new SqlParameter("@commentedUser", addReplyRequest.postedBy);
        SqlParameter wallName = new SqlParameter("@wallName", addReplyRequest.wallName);
        SqlParameter reply = new SqlParameter("@reply", addReplyRequest.reply);
        command.Parameters.Add(postIdParam);
        command.Parameters.Add(postedBy);
        command.Parameters.Add(wallName);
        command.Parameters.Add(reply);
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
            return "success";
        }
        catch
        {
            return "fail";
        }
        finally
        {
            connection.Close();
        }
    }

    public DataTable refreshPost(int postId)
    {
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        try
        {
            return fetchLatestReplies(postId, connection);
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

    public DataTable viewAllReplies(replyPostVO addReplyRequest)
    {
        SqlConnection connection = null;
        connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sqlquery = "select pc.commentid,pc.postId,pc.commentedUser, pc.commentedDate, pc.comments,ud.userimg,(select count(*) as repliesCount from arulselv.postComments where postId=@postId) as repliesCount from arulselv.postComments pc left join arulselv.userDetailsMaster ud on pc.commentedUser = ud.userName where pc.postId=@postId group by pc.commentedDate,pc.commentid,pc.postId,pc.commentedUser,ud.userimg,pc.comments order by pc.commentedDate desc";
        SqlCommand command = new SqlCommand(sqlquery, connection);
        SqlParameter postIdParam = new SqlParameter("@postId",addReplyRequest.postId);
        command.Parameters.Add(postIdParam);
        try
        {
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable replies = new DataTable();
            da.Fill(replies);
            return replies;
        }
        catch
        {
            return null;
        }
    }
}