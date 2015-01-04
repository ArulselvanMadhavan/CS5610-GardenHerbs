<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homePage.aspx.cs" Inherits="project_Documentation_homePage" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Features in HomePage</h3>
    </div>

    <br />
    <div>
        <strong class="sub-heading">Common Features
        </strong>
        <p class="para text-indent">
            I have designed some features that are attributed to all the pages of my project.
        <li>Site Logo</li>
            <li>Navigation Bar</li>
            <li>PageFooter</li>
        </p>
    </div>
    <i class="inline-heading">Logo</i>
    <p class="para text-justify">
        I chose to have my project title 'GardenHerbs' as the logo of my website. Using an Online logo generator , I created a sitelogo, a site subtextLogo, a siteSymbol and a favicon for my website.
        Below are the list of images that I designed for my project.
    </p>
    <div class="listWrapper">
        <div class="listHolder">
            <div class="listDescription">
                <p class="p_listDescription">Site Logo</p>
            </div>
            <div class="listImgHolder">
                <img class="sitelogo" src="../images/logo.png" />
            </div>
        </div>
        <div class="listHolder">
            <div class="listDescription">
                <p class="p_listDescription">SubText Logo</p>
            </div>
            <div class="listImgHolder">
                <img class="sitelogo" src="../images/log-subtext.png" />
            </div>
        </div>
        <div class="listHolder">
            <div class="listDescription">
                <p class="p_listDescription">SiteSymbol</p>
            </div>
            <div class="listImgHolder">
                <img class="sitelogo" src="../images/minilogo.png" />
            </div>
        </div>
        <div class="listHolder">
            <div class="listDescription">
                <p class="p_listDescription">Favicon</p>
            </div>
            <div class="listImgHolder">
                <img class="sitelogo" src="../images/favicon.ico" />
            </div>
        </div>
    </div>
    <p class="para text-center">
        All the images were designed by me using Online logo generator called Coollogo.com
    </p>
    <i class="inline-heading">Responsive navigation Menu:
    </i>
    <p class="para text-justify">
        I have as many as 7 menu items in the menu bar. The navigation bar is responsive and it adjusts itself based on the screen width. The technique used to achieve responsiveness for the naviagatio menu is CSS3 media queries.
        My Experiments on responsive naviation menu helped me a lot. Here is a link to my Experiment where I have described the steps to achieve responsive navigation menu.
        <br />
        <a href="../../experiments/CSS3/CSS3-exp3.html" target="_blank">CSS3 Experiment - Responsive Navigation Menu</a>
    </p>
    <i class="inline-heading">Login Controls
    </i>
    <p class="para text-justify">
        I have used asp.Net LoginName Control and asp.Net LoginStatus control to display the logged In user Name and to indicate the login status of any user browsing the site.
        Both these controls appear in all the pages , but LoginName is visible only when a user is logged in.
    </p>
    <i class="inline-heading">Copyright Footer
    </i>
    <p class="para text-justify">
        Next, I have a footer at the bottom of every page to indicate the copyright protection rights to the users of the website.
    </p>

    <br />
    <strong class="subheading">Responsive Carousal
    </strong>
    <p class="para text-justify">
        My Homepage explains the features of the website via slides. These slides consists of images of plants along with a text explaining a feature of the website.
        All the images used in this page were released under Creative Commons license and these images 'free to share,modify or even commercially'. I have accompanied text to these images using Microsoft paint.
        The text that accompanies these images were written by me. No modifications were made to the look of the image. The image was modified to be transparent to suit the site's theme.
    </p>
    <p class="para text-justify">
        The responsive jQuery carousal features 4 slides that portrays the features of the site to the user. The carousal is a product of FilamentGroup, an open source developers community and is released under GPL license.
The carousal uses three javascript files for its smooth operation namely,responsive-carousel.js. 
        <a href="https://github.com/filamentgroup/responsive-carousel" target="_blank">Link for the source of Responsive Carousal.js</a>
    </p>
    <strong class="subheading">Recent Uploads Section
    </strong>
    <p class="para text-justify">
        Recent Uploads Section displays 4 most recent plantings that were planted by GardenHerbs Users. All the images used in this page were released under Creative Commons license and these images 'free to share,modify or even commercially'. No modifications were made to any of the images.
        Sources of all these images have listed in a seperate link under this story utility.
    </p>
    <i class="inline-heading">DynamicNess:</i>
    <p class="para text-justify">
        As soon as user uploads a planting , it will be displayed in this section . The images displayed in the recent uploads section are animated images. When a User hovers over these images , the image flips 180 degress horizontally and displays
        <li>Name of the planting</li>
        <li>Name of the User who planted the crop</li>
        <li>Date and time at which the crop was planted</li>
    </p>
    <i class="inline-heading">How are the details for the Recent uploads section retrieved?
    </i>
    <p class="para text-justify">
        On the pageLoad event of the Homepage , I am establishing a connection to my database table - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster(Click here to view the Table Structure)</a>
        and sort the top 4 most recent uploads from the plantedOn column.
    </p>
    <i class="inline-heading">What happens on clicking the image or the links that appear on the back of the image</i>
    <p class="para text-justify">
        User will get directed to the CropDetails page which will give all the details of that particular planting.
    </p>
    <i class="inline-heading">What happens on mobile screens?
    </i>
    <p class="para text-justify">
        The images will get displayed as individual blocks and the animation or every other feature that usually works on a normal page would still work.
    </p>
      <strong class="subheading">Database Table Used in this Page
    </strong>
    <br />
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/Home.aspx" target="_blank">Home.aspx</a><br /></li>
    
    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/Home.aspx.cs" target="_blank">Home.aspx.cs</a><br /></li>
    
    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br /></li>
    
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/imageFlipper/imageFlipper.css" target="_blank">imageFlipper.css</a><br /></li>
    
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br /></li>
    
    <i class="inline-heading">Javascript Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/carousal/responsive-carousel.js" target="_blank">ResponsiveCarousal.js</a><br /></li>
    
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/carousal/responsive-carousel.autoplay.js" target="_blank">Responsive carousal.autoplay.js</a><br /></li>
    
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/carousal/responsive-carousel.autoinit.js" target="_blank">responsive-carousel.autoinit.js</a><br /></li>
    
</asp:Content>
