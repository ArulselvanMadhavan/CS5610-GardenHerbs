<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cropSuggestor_doc.aspx.cs" Inherits="project_Documentation_cropSuggestor_doc" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Crop Suggestor</h3>
    </div>
    <strong class="subheading">Features included in this page:
    </strong>
    <li>An user can select his location and view the details about
        <ul>
            <li>Crops that have maximum sales in his area.</li>
            <li>Crops that has produced good yield in the past</li>
            <li>Crops that has been harvested the most in the user selected area.</li>
        </ul>
    </li>
    <li>The statistics displayed are fetched from QuickStats API (an API released by US Department of Agriculture).</li>
    <li>Interaction with QuickStats API and the parsing of retrieved results are done via AJAX. A spinner is displayed when the user awaits for results.</li>
    <i class="inline-heading">How are the State Names populated in the dropdown list ?
    </i>
    <p class="para text-justify">
        I have loaded all the US state names into my SQL database. During the pageLoad event , we connect to the database and fetch the state names and bind it to the dropdown list.
        Table used - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a>
    </p>
    <i class="inline-heading">How are the details fetched from USDA ?
    </i>
    <p class="inline-heading">
        When the user selects an option asking for stats that he wishes ,we construct a URL to hit the Quickstats API. The response provided by Quickstats is in XML form and the data is unorganized. The retrieved XML results are parsed in the .NET server.
        I wrote an algorithm to recurse through the retrieved results and sort the retrieved results . ALL THE RESULTS DISPLAYED ARE SORTED BY DEFAULT.
    </p>
    <i class="inline-heading">How does the spinner appear and disappear during backend processing?
    </i>
    <p class="para text-justify">
        The entire operation of fetching the stats from API is done via AJAX. The button that initiates the process is under an update panel. I have placed an 'update Progress panel' to keep track of the processing done for fetching the stats.
        I have placed a spinner inside the update progress panel and it is diplayed while the button click action is under progres. When the processsing initiated by button click completes, the 'update progress panel' realizes that the processing is complete and stops displaying the spinner.
        The results are displayed via an 'asp.net gridview' which is under a seperate update panel. The update mode of this panel is set to conditional. So, after completion of the processing initiated by button click event, we have to manually trigger the update method of the panel which displays the results to users.
    </p>
    <p class="para text-justify">
        This page uses a Jquery plugin called Footable.js to achieve pagination over a asp:Listview. Please refer
         <a href="../../experiments/project-experiments/Exp25-Grid_View_Pagination.aspx this experiment for more details about how I have implemented this plugin for my site.">this</a> experiment where I have detailed the steps to achieve pagination on a grid view using Footable.js
    </p>
    <p class="para text-justify">The main reason to use Footable.js is the responsiveness that it provides along with a cool pagination feature. There are many responsive datatable plugins , but I find Footable.js to provide the best User friendly responsiveness.</p>
    <i class="inline-heading">Problems Faced:
    </i>
    <p>1. When I moved the 'Fetch Crop Stats' button inside an update panel to keep track of the status of the background process, the results were not getting loaded into the aso.net gridview. After carefully reading the updatepanel documentation given by MSDN, I found out that the asp.net gridview must also be inside an update panel.</p>
    <p>Solution: Moving the asp.net gridview inside a seperate update panel and setting the update mode of both the panels as 'Conditional'. We have to manually call the update method of the panel which holds the gridview as soon as the results to display are available.</p>
    <p>
        2. I moved the gridview inside asp:updatepanel, but the footable plugin stopped working on the gridview.
    </p>
    <p>
        Reason: Since gridview became part of AJAX, the page was not getting loaded. Since Footable plugin is applied when the page loads , the footable plugin couldn't sense the changes to the gridview done via AJAX.
    </p>
    <p>Solution: We have to initiate the redraw event of the footable plugin after the AJAX call is completes </p>
    <p>
        3.But after this,both spinner and the grid view started displaying one below the other.
         So, I had to find a way to hide the already  populated grid view before submitting a new request.
    </p>
    <p>Solution: We need to keep track of the AJAX request and show the gridview when the request is complete and hide it when a new request is placed.Solution: 'Sys.WebForms.PageRequestManager' enables us to keep track of the begin request and end request. When a request begins, the gridview is hidden and when the request we show the gridview. </p>

    <i class="inline-heading">Experiments that were helpful for the design of this page:</i>
    <li><a href="../../experiments/project-experiments/Exp25-Grid_View_Pagination.aspx">Experiment on achieving pagination in dynamic tables using Footable.js</a></li>
    <strong class="subheading">Database tables used in this page
    </strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.state_details" target="_blank">StateDetails</a></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/cropSuggestor.aspx" target="_blank" class="text-indent">cropSuggestor.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/cropSuggestor.aspx.cs" target="_blank">cropSuggestor.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file(Used to fetch the State Name)</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/cropSuggestor/cropSuggestor.css" target="_blank">cropSuggestor.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/cropSuggestor/loader.css" target="_blank">Loader.css</a></li>
    <i class="inline-heading">JS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.js">Footable.js</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.paginate.js">Footable.paginate.js</a></li>
</asp:Content>
