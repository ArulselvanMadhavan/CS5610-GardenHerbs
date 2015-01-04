<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkWeather_Doc.aspx.cs" Inherits="project_Documentation_checkWeather_Doc" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Weather Forecaster</h3>
    </div>
    <strong class="subheading">Features Included in this page:
    </strong>
    <li class="para text-justify">An user can check the weather forecast details for this location by selecting his area.</li>
    <li class="para text-justify">The weather details are fetched from the worldweatherAPI.</li>
    <li class="para text-justify">The results are provided in XML is format which is processed at the ASP.NET server  and rendered to the user in a user friendly format. </li>
    <i class="inline-heading">API Call
    </i>
    <p class="para text-justify">
        When the page loads we fill the State Name dropdown list with values from the database. When a user selects a stateName, 
        we handle the OnselectedItemChanged event and connect to database <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a>
        and fetch the zipcode that correspond to the user selected state name.        
    </p>
    <p class="para text-justify">
        The user is then allowed to narrow down his location in the state by selecting his zip code location. 
    </p>
    <p class="para text-justify">On clicking the 'Fetch Weather Forecast details' button , we call the below API url with the user's selected zipcode.</p>
    <p>http://api.worldweatheronline.com/free/v1/weather.ashx?key=" + w_key + "&q=" + zipCode + "&num_of_days=5&format=xml" </p>
    <i class="inline-heading">AJAX Controls
    </i>
    <p class="para text-justify">
        All 3 dropdown lists are under an AJAX update panel. 
        <li class="para text-justify">The StateName dropdown will trigger a full postback when its selecteditem index changes.</li>
        <li class="para text-justify">A trigger is setup on the zipcode dropdown to monitor and trigger a partial post back in response to the selecteditemindex change event of the statename dropdown list.</li>
        <li class="para text-justify">The Fetch button is is under an update panel and its postback progress is monitored via an update progress control</li>
        <li class="para text-justify">This update progress control displays a spinner while the postback initiaed by the fetch button runs on the background.</li>
        <li class="para text-justify">The Resuls grid is under a seperate update panel and will get an update by conditional method. In this page, the results grid view will receive an update on completion of the post back initiated by the fetch button.</li>
    </p>
    <i class="inline-heading">Pagination and Responsiveness:
    </i>
    <p class="para text-justify">
        This page uses a Jquery plugin called <a href="http://themergency.com/footable/" target="_blank">Footable.js</a> to achieve pagination over a asp:Listview. Please refer
         <a href="../../experiments/project-experiments/Exp25-Grid_View_Pagination.aspx this experiment for more details about how I have implemented this plugin for my site.">this</a> experiment where I have detailed the steps to achieve pagination on a grid view using Footable.js
    </p>
    <p class="para text-justify">The main reason to use Footable.js is the responsiveness that it provides along with a cool pagination feature. There are many responsive datatable plugins , but I find Footable.js to provide the best User friendly responsiveness.</p>
<i class="inline-heading">
        Experiment that helped me design this page:
    </i>
    <li><a href="../../experiments/project-experiments/weatherForecast.aspx" target="_blank">Experiment to learn XML parsing with C#</a></li>
    <strong class="subheading">
        Database Tables used in this page
    </strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/weatherForecast.aspx" target="_blank" class="text-indent">weatherForecast.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/weatherForecast.aspx.cs" target="_blank">weatherForecast.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file(Used to fetch the State Name and zipcode)</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/farmersMarket/farmersMarket.css" target="_blank">farmersMarket.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
    <i class="inline-heading">JS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.js">Footable.js</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.paginate.js">Footable.paginate.js</a></li>

</asp:Content>

