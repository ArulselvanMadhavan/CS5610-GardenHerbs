<%@ Page Language="C#" MasterPageFile="~/experiments/project-experiments/project.master" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Homepage" %>
     
<asp:content id="Content1" ContentPlaceHolderID="head" runat="server"> 
<link rel="stylesheet" href="Searchbar.css"/>  
   <link rel="stylesheet" href="css/bootstrap.css" />
</asp:content>
 
<asp:content id="Content2" ContentPlaceHolderID="SearchBar" runat="server">
    <div class="search-bar-wrapper">
        <table class="t_searchBar">
            <tr>
                <td class="searchText">
                    <input type="text" id="search" placeholder="Enter the Job Title...." required>
                </td>
                <td class="searchButton">
        <input type="submit" value="Find jobs" id="submit">
                    </td>
                </tr>
            </table>
    </div>
    <div>
        <h2>Experiment 18: Adding a Login Form to the MenuBar and adding a search bar.</h2>
        <h3>Experiment Demo: Please click the login link in the above menubar to find a new form opening right below the login item in the menuBar</h3>
        <h3>Purpose of the Experiment:</h3><p>I need to have my users login to the website that I am developing as a project. I didn't want to create a seperate login form just to get the users logged in. So, I have added a new login form to the menubar.Also, Since I am planning to provide a search utility to the users of my website , I have designed a search Bar that I will use in my project.</p>
        <h2>Documentation:</h2>
        <p>1. First, to display a form right below the login link in the menubar, I have added the following lines in my masterpage. </p>
        <pre>
             < li id ="login">< a id="login-trigger" href="#">Login < span>&#65516;< /span> < /a>
                            < div id="login-content">
                                < form>
            <%--Field set for Input HTML Elements--%>
                                    < fieldset id="login-inputs">
                                        < input id="username" type="email" name="Email" placeholder="Your email address" required>
                                        < input id="password" type="password" name="Password" placeholder="Password" required>
                                    < /fieldset>
            <%--Field set for Input Action Elements--%>
                                    < fieldset id="login-actions">
                                        < input type="submit" id="submit" value="Log in">
                                        < label>
                                        < input type="checkbox" checked="checked">Keep me signed in< /label>
                                    < /fieldset>
                                < /form>
        </pre>
        <p>2. Here I have used the fieldset directive to group HTML elements.</p>
        <p>3. When the user clicks the login link in the menu, a Jquery function is called. This function uses sligeToggle and togglecalss methods to display the login form based on the user click. This function also sets the arrow mark next to the login link.</p>
        <pre>
        $(document).ready(function () {
        $('#login-trigger').click(function () {
        //slideToggle Function method - > Display or hide the matched elements with a sliding motion.
        $(this).next('#login-content').slideToggle(); 
        $(this).toggleClass('active');

        if ($(this).hasClass('active')) $(this).find('span').html('&#65514;')
        else $(this).find('span').html('&#65516;')
    })
});
        </pre>
        <p>
            4. Since I am planning to provide a search utility to the users of my website , I have designed a search Bar that I will use in my project.
        </p>
    </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/project.master" style="color:black; text-decoration:underline;" target="_blank">Link to master file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Homepage.aspx" target="_blank" style="color:black; text-decoration:underline">Link to this file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/masterstyle.css" target="_blank" style="color:black; text-decoration:underline">Link to the MenuBarCss file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/Searchbar.css" target="_blank" style="color:black; text-decoration:underline">Link to the Searchbar file</a>
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/login.js" target="_blank" style="color:black; text-decoration:underline">Link to the login.js file</a>
    <hr />
    <h3>References</h3>
    <a href="http://www.w3schools.com/" target="_blank" style="color:black; text-decoration:underline;">1. W3schools</a>
  </asp:content>
    

