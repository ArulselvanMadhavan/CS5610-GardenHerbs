<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login_doc.aspx.cs" Inherits="project_Documentation_login_doc" MasterPageFile="~/project/Documentation/documentation.master" %>
<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Login Page</h3>
    </div>
    <strong class="subheading">
        Features included in the login page
    </strong>
    <li class="para text-justify">Uses Windows Forms Authentication to Authenticate Users</li>
    <li class="para text-justify">Validators have been put in place to validate all the fields present in the login form</li>
    <li class="para text-justify"> User friendly error messages have been put in place to communicate errors to users</li>
    <i class="inline-heading">
        Forms  Authentication:
    </i>
    <p class="para text-justify">
        This website uses ASP.NET Login control and uses Forms Authentication to authenticate users.
    </p>
    <i class="inline-heading">
        Privileges Enjoyed by Signed In Users
    </i>
    <li class="para text-justify">Signed In Users can comment on any Crops</li>
    <li class="para text-justify">Signed In Users can post any User's wall</li>
    <li class="para text-justify">Signed In Users can upload their planting into this website and see it get reflected in several pages of this site.</li>
    <li class="para text-justify">Signed In Users can Endorse/unEndorse a planting.</li>
    <li class="para text-justify">Signed In Users can 'Vote a comment as good post'</li>
    <li class="para text-justify">Signed In Users can 'Like a Comment on Users wall'</li>
    <li class="para text-justify">Signed In Users can edit/update/delete any of their comments/posts</li>
    <li class="para text-justify">
        An User can SignIn/SignOut from any page in the website. 
    </li>
     <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/Login.aspx" target="_blank" class="text-indent">Login.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/BrowseCrops.aspx.cs" target="_blank">Login.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/login/loginPageStyle.css" target="_blank">LoginStyle.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
</asp:Content>
