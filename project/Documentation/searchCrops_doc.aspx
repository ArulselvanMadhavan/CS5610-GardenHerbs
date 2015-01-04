<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchCrops_doc.aspx.cs" Inherits="project_Documentation_searchCrops_doc" MasterPageFile="~/project/Documentation/documentation.master" %>
<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Search Crops</h3>
    </div>
    <strong class="inline-heading">
        Features included in this page
    </strong>
    <li>An User can enter a search string and search our database for the crops that he wishes.</li>
    <li>The search results are sorted by endorsement count.</li>
    <li>The search results provide the user a link to navigate to the cropDetails which will give more details about the selected planting</li>
    <i class="inline-heading">
        How does the search operation Operate?
    </i>
    <p class="para text-justify">
        The search string entered by the user is queried against the 
        <a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a>
        The search results are by default sorted by endorsement count.
        </p>
    <p>
        For example, if potato has been planted by 20 times by various users so far, the search for 'potato' will return all potatoes but the one with the MOST ENDORSEMENT COUNT will be the first result.
        </p>
    <p class="para text-justify">
        The search string doesn't have to exactly equal to the cropname. The search results will display results that have any part of the input string in them.
        The max length of search string that can be entered is 15.
    </p>
    
    <strong class="subheading">Database Tables used in this page</strong>
        <li><a href="http://net4.ccs.neu.edu/home/arulselv/database/database.aspx?cs=arulselv&db=arulselv.uploadMaster" target="_blank">UploadMaster</a><br /></li>
    <strong class="subheading">Links to Source Code
    </strong>
    <br />
    <i class="inline-heading">ASPX file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/searchCrops.aspx" target="_blank" class="text-indent">searchCrops.aspx</a><br />
    </li>

    <i class="inline-heading">C# file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/searchCrops.aspx.cs" target="_blank">searchCrops.aspx.cs</a><br />
    </li>

    <i class="inline-heading">DAO file</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a><br />
    </li>
    <i class="inline-heading">VO Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropResultsVO.cs" target="_blank">cropResultsVO</a><br />
    </li>
    <i class="inline-heading">CSS Files</i>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/cropDetails/searchBar.css" target="_blank">searchBar.css</a><br />
    </li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/searchCrop/searchCrop.css"></a>searchCrop.css</li>
    <li><a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/project/css/home/masterStyle.css" target="_blank">masterStyle.css</a><br />
    </li>
</asp:Content>
    