<%@ Page Language="C#" MasterPageFile="~/experiments/project-experiments/Exp17-project.master" AutoEventWireup="true" CodeFile="Exp17-Homepage.aspx.cs" Inherits="Homepage" %>
     
<asp:content id="Content1" ContentPlaceHolderID="head" runat="server"> 
    <link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="Searchbar.css"/>  
   
</asp:content>
 
<asp:content id="Content2" ContentPlaceHolderID="SearchBar" runat="server">
    <div>
   <h2><i>Experiment 17: Working with Masterpages</i></h2>
    <h3>Experiment Demo:</h3> <i>MenuBar shown above is from a masterpage. Please hover over the above MenuBar and see contents getting displayed. Menus that have subitems to display has an arrow mark next to them.</i>
        <h3>Purpose of the Experiment:</h3> <i>Since I am planning to have my menuBar dispayed in all the pages of my project, I decided to learn about masterpages. With this experiment, I learned about masterpages and how they help organise the webpages of a website.</i>
    <h2>Documentation</h2>
    <p>1. Using masterpages , we can get some content displayed in all the pages of our website.</p>
    <p>2. We need to add a masterpage into our website. ASP.NET has a special format file for master pages.</p>
    <p>3. Masterpages have a special directive of their own. Here is an example.</p>
    <pre>
        < %@ Master Language="C#" AutoEventWireup="true" CodeFile="Project.master.cs" Inherits="Project" %> 
    </pre>
    <p>4. After creating the master page, we need to decide the content of our webpage and add contentplaceholders accordingly.</p>
    <p>5. The content place holders that we place in masterpage , can be referred in the child/slave pages that link to the masterpage.</p>
    <p>6. The child pages that link to masterpages can have their content replace the masterpage content by referring the id of the contentplaceholder that they want to replace , in their pages.
        For example: In this page, The menuBar is displayed from the masterpage.</p>
        <p>The content that is specific to the child pages can choose to override the masterpage and here I am overriding the contentplaceHolder called "SearchBar" from my masterpage.
    </p>
        </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp17_masterfile.html" style="color:black; text-decoration:underline;" target="_blank">Link to master file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Exp17-Homepage.aspx" target="_blank" style="color:black; text-decoration:underline">Link to this file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/masterstyle.css" target="_blank" style="color:black; text-decoration:underline">Link to the MenuBarCss file</a>
    <h3>References:</h3>
   <a href="http://www.w3schools.com/" target="_blank" style="color:black; text-decoration:underline;">1. W3schools</a>
  </asp:content>
    

