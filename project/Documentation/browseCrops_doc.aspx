<%@ Page Language="C#" AutoEventWireup="true" CodeFile="browseCrops_doc.aspx.cs" Inherits="project_Documentation_browseCrops_doc" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Browse Crops</h3>
    </div>
    <strong class="subheading">Features Included in this page:
    </strong>
    <li>An user can browse the different crops that this website offers support to.</li>
    <li>By default the crops listed are sorted by the ones that is planted the most number of times.</li>
    <li>The search results are paginated.</li>
    <li>The planted times displayed in this page will get updated on its own as soon as a user uploads a planting of a crop type.</li>
    <i class="inline-heading">How are the results displayed on this page obtained?
    </i>
    <p class="para text-justify">
        Each Result displayed in this page consists of an image of the crop, name of the crop, scientific name of the crop and a count which says how many times this crop has been planted by different users.
        These values are obtainted by JOINing the tables cropmaster and uploadmaster tables on the value cropId.
    </p>
    <p class="para text-justify">
        1. Image of the crop is fetched from the uploadMaster table. But the cropmaster gives the imageid that has to be displayed in this page.
        This is because , there can be many uploads for a particular crop but the site administrator would want to display the best planting in their browseCrops page.
        
        So , the design allows site admins to change the planting that they want to display in their browseCrops page by setting the bestPlantingid of the table - <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.cropmaster" target="_blank">cropmaster</a>
    </p>
    <p class="para text-justify">
        2. Scientific Name of a crop is fetched from cropmaster table.
    </p>
    <p class="para text-justify">
        3. Planted times is calculated from the uploadMaster table
    </p>

    <p class="para text-justify">
        This page uses a Jquery plugin called Footable.js to achieve pagination over a asp:Listview. Please refer to my experiments given in the below links to find more details about how I have implemented this plugin for my site.
    </p>
    <i class="inline-heading">Experiments that were helpful for the design of this page:</i>
    <li><a  href="../../experiments/project-experiments/Exp25-Grid_View_Pagination.aspx">Experiment on achieving pagination in dynamic tables</a></li>
    <li><a  href="../../experiments/project-experiments/Exp30-ListGrid-dynamic-update.aspx">Experiment on ListView Grid</a></li>
    <strong class="subheading">
        Database tables used in this page
    </strong>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">uploadMaster</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.cropmaster" target="_blank">cropMaster</a></li>
     <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/BrowseCrops.aspx" target="_blank" class="text-indent">BrowseCrops.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/BrowseCrops.aspx.cs" target="_blank">BrowseCrops.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/browseCrops/browseCrops.css" target="_blank">browseCrops.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
    <i class="inline-heading">JS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.js">Footable.js</a></li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/js/footable/footable.paginate.js">Footable.paginate.js</a></li>
    
</asp:Content>
