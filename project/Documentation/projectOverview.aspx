<%@ Page Language="C#" AutoEventWireup="true" CodeFile="projectOverview.aspx.cs" Inherits="project_Documentation_projectOverview" MasterPageFile="~/project/Documentation/documentation.master" %>


<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div >
        <h3 class="heading">GardenHerbs - Project Overview</h3>
    </div>
    <div>
        <strong class="sub-heading">GardenHerbs Project Theme:</strong>
    </div>
    <div class="para">
        <p class="para text-center">
The theme of this project is to build a website that facilitates Gardeners/Farmers in making their planting decisions. 
        </p>
    </div>
    <div>
        <strong class="sub-heading">Motive behind the project:</strong>
    </div>
    <p class="para text-justify">
        We all know that the World's food production capacity is not growing as much as its population and thereby causing an ecological imbalance which never ceases to grow. 
        Even in this age of technological advancements, the amount of technology that went to aid farmers/agriculture is very minimal.
    </p>
    <p class="para text-justify">
        Since I am from a family that once did farming/agriculture on a large scale basis and was aware of how much a bad farming decision can affect a farmer, I decided to build a website where farmers
        can learn about production practices of various crops, connect with farmers around the world and discuss about production practices,write about plant diseases that had affected them in the past and seek for help, seek assistance on kind of irrigation methods that they can follow,
        trade for seeds etc ., 
    </p>
    <p class="para text-justify">
       <i> In a nutshell, this project is about building an online farming community and aiding the farmers' planting decision by providing them with the statistics that will help them to make an advised farming decision. </i>
    </p>

    <div>
        <strong class="subheading">
           Features Included in the Project:
            </strong>
    </div>
    
        <li class="inline-heading">Crop Suggestor:</li>
    <p class="para text-justify">
        Crop Suggestor Tool enables users to find the crops that have BEST sale value in their area, find crops that has given good yield in the past , find crops that has been harvested the most by other farmers in their area.
    </p>
    <li class="inline-heading">Search Crops</li>
     <p class="para text-justify">
         Search Crops allows users to search for all the plantings that had been planted by other farmers/users of this site.
    </p>
    <li class="inline-heading">Browse Crops</li>
     <p class="para text-justify">
         Browse Crops allows users to browse this site for the different kinds of crops supported by it.
    </p>
    <li class="inline-heading">Crop Details</li>
     <p class="para text-justify">
         Crop Details provides details about the selected planting/crop. Details include standard production practices, production method followed by users , how many plantings did the planter of the crop harvest, what type of shading he used?,when did he plant the crop ,
         how many users have ENDORSED the production method used by the planter etc., Crop Details page also allows LOGGED IN users to comment/ask questions related to this selected planting.
         Any comment or post can be 'Voted' as a good post by 'LOGGED IN' users. 
         The author of the comment will have access to edit/update/delete his/her comment.
    </p>
    <li class="inline-heading">User Details</li>
     <p class="para text-justify">
         User Details page lists details about a Garden Herbs user. Each user has a wall onto which a LOGGED IN user can post any questions that he wants the wallOwner to answer.
         An UNLOGGED IN user can still view all the posts that are on a user's wall , but he cannot post anything until he is logged in. The decision to allow unlogged in user to view posts on users wall in intentional as the professor asked us to keep significant amount of facilities for unlogged in users.
    </p>
       <li class="inline-heading">Upload Plantings</li>
     <p class="para text-justify">
         A LOGGED IN user can upload details about the planting that he successfully harvested. An LOGGED IN user can upload a picture of his crop into the site.
         As soon as a planting is uploaded , it will be immediately visible in the 'Recent Uploads' section of the homepage and in the search results fetched by the 'searchCrops' page of this website.
    </p>
     <li class="inline-heading">Farmers Market:</li>
    <p class="para text-justify">
        GardenHerbs allows users to view details about the farmers market that are in their area. Details include  products sold in the market,timings of the market, distance of the market from their location and of course the market name and address.
    </p>
    <li class="inline-heading">Weather Forecaster</li>
     <p class="para text-justify">
         This feature allows users to view weather details for the next 5 days. Farming is largely dependent on weather conditions. An accurate weather forecast, will allow farmers to reduce the damage to their crops if not prevent them completely.
    </p>
</asp:Content>
