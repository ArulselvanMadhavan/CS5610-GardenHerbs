<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cropDetails.aspx.cs" Inherits="project_Documentation_Default"  MasterPageFile="~/project/Documentation/documentation.master"%>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">
           CropDetails Page
        </h3>
    </div>
    <strong class="subheading">
         Features in CropDetails Page
    </strong>
    <li>Displays all the details of a crop</li>
    <li>Allows logged in users to 'Endorse' a crop</li>
    <li>Allows logged in users to Comment on this crop.</li>
    <li>Allows logged in Users to Vote any comment as a good post</li>
    <li>Allows logged in Users to UnVote any of his previously 'voted' post</li>
    <li>Allows the owner of a comment to edit,update,delete his comment</li>
    <li>An Un logged In user can view all the details of the crop and comments(including the count of votes) but cannot make changes unless he is logged in.</li>
    <i class="inline-heading">
        Dependency:
    </i>
    <p class="para text-justify">
        This page is dependent on the crop id that is retrieved as a input Query string parameter.
    </p>
    <i class="inline-heading">
        What happens when the page is accessed directly without passing a QueryString?
    </i>

    <p class="para text-justify">
        All the  controls in the page will be invisible and an error message will be thrown .
    </p>
    <i class="inline-heading">
        What details are displayed in this page?
    </i>
    <p class="para text-justify">
        <li>Image corresponding to the selected Crop(Planting)</li>
        <li>CropName</li>
        <li>Crop's Scientific Name</li>
        <li>Planted User's name-(This also acts as a link to the User Details page)</li>
        <li>Planted Date</li>
        <li>Standard Production Practices</li>
        <li>Production method followed by the User</li>
        <li>Total Endorsements that this crop has received so far</li> 
        <li>Button to endorse this crop(planting method)- Logged In users can click this button and see the endorsed Users count change on its own.(Using Ajax)</li>
    </p>
    <i class="inline-heading">Where are these details fetched from?</i>
    <p class="para text-justify">These Details are obtained by JOINing 2 different tables - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster">UploadMaster</a> <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.cropmaster" target="_blank">cropMaster</a></p>
    <i class ="inline-heading">
        How does endorsed Users count get updated?
    </i>
    <p class="para text-justify">Endorsed users count is refreshed using AJAX update panel</p>
    <strong  class="subheading">
        Comments Section
    </strong>
    <br />
    <i class="inline-heading">How does the new comment get loaded?</i>
    <p class="para text-justify"> I am using AJAX to load new comments into Database. I have the comment box and the comments section wrapped inside an asp:update panel. The entire insert operation is done via AJAX. Once a comment is inserted , we refresh the commments section data by binding the new data(with the added comment) from the database.
        For storing comments , I am using a seperate table - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.commentsmaster" target="_blank">CommentsMaster</a></p>
    <p class="para text-justify">'uploadId' column of updloadMaster table is used as a foreign key in this table , so that we have many to one relationship between the commentsmaster and uploadmaster tables.</p>
    <p class="para text-justify">In the client side , all the comments are displayed using asp:Repeater Control.
        <a href="../../experiments/project-experiments/Exp31-Working_with_Repeaters.aspx" target="_blank" >Here is my experiment on Repeaters which helped me to design this page.</a></p>
    <i class="inline-heading">
        How are the votes displayed and updated into DB?
    </i>
    <p class="para text-justify"> When a User Votes a comment as a good post, I am appending his/her username to the already present data in the likedUsers column of <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.commentsmaster" target="_blank">CommentsMaster</a> table with a seperator ':'. When we query the DB to load the comments for a crop, we will get all the likedUsers of a particular comment as SINGLE STRING. I am using string.parse method to seperate all the users who have liked a comment. Once we have the LIST OF USERS who have liked this comment, we can iterate through that list and find out whether the currently logged in User has already liked this crop . Once we have that information , we can toggle the text of the 'Vote' or 'Like' button displayed in the page between 'Unvote' and 'Vote as good post'.
    </p>
    <p>
        For example: If there is a new post with zero likes and user 'whunting' likes it, then the likedUsers column of the commentsmaster table is updated as ':whunting'. When user 'mzuckerberg' votes/likes the same post, the likedUsers column of this post is updated as ':whunting:mzuckerberg'.
    </p>
    <p>
        When we retrieve data from the database , we will get all the likedUsers as a single string. (ex:":whunting:mzuckerberg"). We have to parse this string by split it with the seperator ":". This will  give 2 strings "whunting" and "mzuckerberg".
        If the logged in User is "whunting", then we change the text as "UnVote" else the text remains as "Vote as good post".
    </p>
    <i class="inline-heading"> How are the edit/update/delete comment operations performed?</i>
    <p class="para text-justify">A Logged In user is provided with the links to edit/delete his comment. When the user click on the edit link , he is presented with a textbox and 2 links to 'Update' or 'Cancel'.</p>
    <p class="para text-justify">If the User clicks on delete, then the appropriate commentId is taken as an argument and the delete operation is performed via AJAX. After delete, the datasource of the repeater that holds the comments is bound again with the data from database so that the changes inflicted by the 'delete' operation is immediately visible to the user.</p>
        <p class="para text-justify">If the User clicks on update, then the appropriate commentId is taken as an argument and the update operation is performed via AJAX. After delete, the datasource of the repeater that holds the comments is rebinded so that the changes inflicted by the 'update' operation is immediately visible to the user.</p>
    <p class="para text-justify">If the User clicks on cancel, then no action is performed and the page is unaltered.</p>
    <strong class="subheading">Database Tables used in this page</strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.commentsmaster" target="_blank">CommentsMaster</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/CropDetails.aspx" target="_blank" class="text-indent">cropDetails.aspx</a><br /></li>
    
    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/CropDetails.aspx.cs" target="_blank">CropDetails.aspx.cs</a><br /></li>
    
    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br /></li>
    <i class="inline-heading"> VO Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropNameVO.cs" target="_blank">cropNameVO</a><br /></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/likeThisCropVO.cs" target="_blank">likeThisCropVO</a><br /></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/endorseCrop.cs" target="_blank">endorseCrop</a><br /></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropNameVO.cs" target="_blank">cropNameVO</a><br /></li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/cropDetails/cropDetail.css" target="_blank">cropDetails.css</a><br /></li>
    
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br /></li>
    </asp:Content>


<%--http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/"
 <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/" target="_blank"></a><br /></li>--%>