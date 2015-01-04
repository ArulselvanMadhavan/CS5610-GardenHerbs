<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userDetails_doc.aspx.cs" Inherits="project_Documentation_userDetails_doc" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">User Details Page</h3>
    </div>
    <strong class="subheading">Featured included in this page
    </strong>
    <li>Displays all the details about the User</li>
    <li>Provides a 'Wall' interface for any logged in User with the owner of the Wall.</li>
    <li>Any logged IN User can post on a user's wall.</li>
    <li>Any logged In user will have access to like any post present in the user's wall.</li>
    <li>The owner of the post will have access to edit/delete his post.</li>
    <li>The owner of the wall will only have access to delete posts on his wall. He cannot edit posts from other users.</li>
    <li>A logged in user can reply to any post</li>
    <li>3 most recent replies will be displayed by default. If the user wishes to see all the replies , he can do so by clicking "View all replies" option. He can revert back to the default by clicking the same link again.</li>
    <li>An Unlogged In user can view all the details of the user and even the posts and replies on the user's wall. This is intentional as the professor requested us to have significant amount of features for the unlogged in user.</li>
    <i class="inline-heading">Dependency:
    </i>
    <p class="para text-justify">
        This page is dependent on the userName that is retrieved as a input Query string parameter.
    </p>
    <i class="inline-heading">What happens when the page is accessed directly without passing a QueryString?
    </i>
    <p class="para text-justify">
        All the  controls in the page will be invisible and an error message will be thrown .
    </p>
    <i class="inline-heading">What details are displayed in this page?
    </i>
    <p class="para text-justify">
        <li>Profile Picture of the Wall Owner</li>
        <li>Name of the WallOwner</li>
        <li>Occupation of the WallOwner</li>
        <li>Location of the WallOwner</li>
        <li>Total Number of Crops planted by this User</li>
    </p>
    <i class="inline-heading">Where are these details fetched from?</i>
    <p class="para text-justify">These Details are obtained by JOINing 2 different tables - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster">UploadMaster</a> <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.userDetailsMaster" target="_blank">userDetailsMaster</a></p>
    <i class="inline-heading">How is the total Count calculated?
    </i>
    <p class="para text-justify">
        Total Count of the plants planted by the User is calculated by joining the uploadMaster table and userDetailsMaster table based on the userName field and counting the number of records.
    </p>
    <strong class="subheading">Wall Section
    </strong>
    <i class="subheading">How does the wall Posts get loaded into the page?
    </i>
    <p class="para text-justify">
        In the page_Load event, I am retrieving all the posts corresponding to a user from the table - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.postMaster" target="_blank">PostMaster</a> table.
        Since any user can post on the wall , we need some details (for example: Profile Picture id) from the userDetailsMaster table. So I am joining these tables based on the wallName and postId.
        The extracted posts are applied to a asp:Repeater. The repeater then iterates over the assigned datasource and binds the values to the controls inside the repeater.
    </p>
    <i class="inline-heading">How are the likes displayed and updated in DB?
    </i>
    <p class="para text-justify">
        When a User likes a post, I am appending his/her username to the already present data in the likedUsers column of <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.postMaster" target="_blank">postMaster</a> table with a seperator ':'. 
        When we query the DB to load the likes for a post, we will get all the likedUsers of a particular comment as SINGLE STRING. I am using string.split method with seperator ':' to seperate all the users who have liked a comment.
        Once we have the LIST OF USERS who have liked this comment, we can iterate through that list and find out whether the currently logged in User has already liked this crop .
        Once we have that information , we can toggle the text of the 'Like' button displayed in the page between 'Like' and 'UnLike'.
    </p>
    <p>
        For example: If there is a new post with zero likes and user 'whunting' likes it, 
        then the likedUsers column of the commentsmaster table is updated as ':whunting'.
         When user 'mzuckerberg' likes the same post, the likedUsers column of this post is updated as ':whunting:mzuckerberg'.
    </p>
    <p>
        When we retrieve data from the database , we will get all the likedUsers as a single string. (ex:":whunting:mzuckerberg").
         We have to parse this string by split it with the seperator ":". This will  give 2 strings "whunting" and "mzuckerberg".
        If the logged in User is "whunting", then we change the text as "UnVote" else the text remains as "Vote as good post".
    </p>
    <i class="inline-heading">How does the replies to each post are fetched and updated dynamically?
    </i>
    <p class="para text-justify">
        This page implements the concept of nested repeaters. The parent repeater repeats the posts that should be displayed under a user profile.
            The child repeater takes care of updating the replies that are specific to a particular post.
    </p>
    <p class="para text-justify">
        Whenever a change happens on a post , we just have to refresh the datasource of the child repeater and the parent repeater can remain intact.
    </p>
    <p>
        For example, when a user replies to a post, the corresponding post id is taken as an argument to identify the post and insert the reply into database.
        On successful insertion, only the datasource of the child repeater is refreshed with the new data from the database. 
        All the inserts/updates/deletes to the database are performed via AJAX so that the page doesn't get loaded for every click and the changes are refreshed smoothly in the page.
    </p>
    <i class="inline-heading">How does the view all and view latest replies work?
    </i>
    <p class="para text-justify">
        Similar to how we update/fetch replies, we use the postId to fetch the required results from the database. We keep track which view the user is currently viewing by fetching the repeater item count.
    </p>
    <p>For example: If the number of replies to a post is 8 and the repeater item count is 3 , then the user is viewing only the latest replies. On click of the linkbuttton, we have to fetch all the replies corresponding to that post.</p>
    <p>On Contrary,If the repeater item count is greater than 3 , then the user is viewing all the replies. On click of the linkbuttton, we have to fetch just the 3 most recent replies.</p>
    <strong class="subheading">Experiments related to the design of this page</strong>
    <li><a href="../../experiments/project-experiments/Exp31-Working_with_Repeaters.aspx" target="_blank" >Here is my experiment on Repeaters which helped me to design this page.</a></li>
    <strong class="subheading">Database Tables used in this page</strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.postmaster" target="_blank">postmaster</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.postComments" target="_blank">postComments</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/userDetails.aspx" target="_blank" class="text-indent">userDetails.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/userDetails.aspx.cs" target="_blank">userDetails.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">VO Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/userDetailsVO.cs" target="_blank">userDetailsVO</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/postVO.cs" target="_blank">postVO</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/likeThisPostVO.cs" target="_blank">likeThisPostVO</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/replyPostVO.cs" target="_blank">replyPostVO</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/cropDetails/cropDetail.css" target="_blank">cropDetails.css</a><br />
    </li>

    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
</asp:Content>




