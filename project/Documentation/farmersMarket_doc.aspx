<%@ Page Language="C#" AutoEventWireup="true" CodeFile="farmersMarket_doc.aspx.cs" Inherits="project_Documentation_farmersMarket_doc" MasterPageFile="~/project/Documentation/documentation.master" %>
<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Farmers Market </h3>
    </div>
    <strong class="subheading">
        Features included in this page
    </strong>
    <li>An User can find the details about the farmers Markets in the area that he chooses by selecting the options in the State Name and Zip Code dropdown list.</li>
    <li>State Names and Zipcode details are fetched from the <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a> database</li>
    <li>The farmersMarket details are fetched from the USDA's AMS(Agricultural Marketing Service API)</li>
    <i class="inline-heading">
        What are the details that are displayed to the User?
    </i>
    <p class="para text-justify">
        <li> Products sold in the market </li>
        <li>Timing Schedule of the market </li>
        <li>Distance of the market from their location</li>
         <li>Market name</li>
        <li>Address of the Market</li>
        <li>Market Id</li>
    </p>
    <i class="inline-heading">
        Where are these details fetched from?
    </i>
    <p class="para text-justify">
        These details are fetched from the USDA's Agricultural Marketing Services API.
    </p>
    <i class="inline-heading">
        API Calls
    </i>
    <li>1. API call to get the farmers Market ID - SearchByZip- http://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip= </li>
    <li>2. API call to get the farmers Market schedule - SearchByMarketId- http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id= </li>

    <i class="inline-heading">
        How are the details fetched and displayed?
    </i>
     <p class="para text-justify">
       When the page loads,we fill the State Name dropdown list with values from the database. When a user selects a stateName, 
        we handle the OnselectedItemChanged event and connect to database <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a>
        and fetch the zipcode that correspond to the user selected state name.        
    </p>
    <p class="para text-justify">
        The user is then allowed to narrow down his location in the state by selecting his zip code location. 
    </p>
    <p class="para text-justify">
        The details displayed to the user are the results from 2 different Web services.
        First , we hit the searchByZip web services and fetch all the markets associated with the user's zipcode.
        Next , we iterate over the results and fetch the market details by passing the market Id to the SearchByMarketId web service.
    </p>
    <p>Noe:There is no proper documentation on how to use these webservices. The only documentation that is available is <a href="http://search.ams.usda.gov/farmersmarkets/v1/svcdesc.html" target="_blank">this.</a>
        Everything other than the wsdl call url had to be learned on our own via experiments</p>
    <i class="inline-heading">Spinner:</i>
    <p class="para text-justify">
        An animated spinner is displayed to user when the server is busy the user's request. The user may not even notice the spinner if the request gets processed quickly.
    </p>
    <i class="inline-heading">
        Pagination and Responsiveness:
        </i>
        <p class="para text-justify">
        This page uses a Jquery plugin called <a href="http://themergency.com/footable/" target="_blank">Footable.js</a> to achieve pagination over a asp:Listview. Please refer
         <a href="../../experiments/project-experiments/Exp25-Grid_View_Pagination.aspx this experiment for more details about how I have implemented this plugin for my site.">this</a> experiment where I have detailed the steps to achieve pagination on a grid view using Footable.js
    </p>
    <p class="para text-justify">The main reason to use Footable.js is the responsiveness that it provides along with a cool pagination feature. There are many responsive datatable plugins , but I find Footable.js to provide the best User friendly responsiveness.</p>
    
    <i class="inline-heading">
        Experiment that helped me design this page:
    </i>
    <li><a href="../../experiments/project-experiments/JSONparse.aspx" target="_blank">JSON parsing with C#</a></li>
    <strong class="subheading">
        Database Tables used in this page
    </strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/farmersMarket.aspx" target="_blank" class="text-indent">farmersMarket.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/farmersMarket.aspx.cs" target="_blank">farmersMarket.aspx.cs</a><br />
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