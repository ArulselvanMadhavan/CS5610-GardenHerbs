<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DesignFeatures.aspx.cs" Inherits="project_Documentation_DesignFeatures" MasterPageFile="~/project/Documentation/documentation.master" %>

<asp:Content ContentPlaceHolderID="pageBody" runat="server">
    <div>
        <h3 class="heading">Design Features
        </h3>
    </div>
    <strong class="subheading">Design Specifications Followed in this Project:
    </strong>
    <p class="para text-justify">
        Professor Jose G Annunziato has advised us to follow standard design practices that are followed in the current software industry. This project obeys all the design specifications that the professor advised us to follow.
    </p>
    <li class="para text-justify">Seperate Data Access Layer/Data Access Object for establishing connections to database.
        <ul>
            <li>All the SQL connections are written in a seperate C# Class file. Example- <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/app_code/project/cropDetailsDAO.cs" target="_blank">DAO file</a></li>
            <li>All the aspx pages that needs a database connection, instantiate this file to access the methods that this class file offers for its objects.</li>
        </ul>
    </li>
    <li class="para text-justify">Seperate Value Objects(VO) for each function call. 
        <ul>
            <li>All the paramaters that are passed into the DAO object and retrieved from the DAO object are encapsulated within a value object(VO). No values are directly passed into/retrieved from the DAO layer without proper encapsulation.
            </li>
        </ul>
    </li>
    <li class="para text-justify">This project follows the industry standard Camel Case naming conventions for naming variables, throughout my project.
    </li>
    <li class="para text-justify">All the CSS files and Javascript files are placed in a seperate folder and are accessed via links from the main aspx source page.
    </li>
    <li class="para text-justify">All the text and images that are seen in this website are under Creative Commons license that are free to use,share or modify, even commercially.
        <ul>
            <li class="para text-justify">I have discussed about using Creative commons content in my website with Professor Jose G Annunziato in 2 different sessions just to make sure that I am not violating any policies. 
        I have followed all the specifications that he advised for this project. All the images used in this site are documented under a seperate story file.
            </li>
        </ul>
    </li>

</asp:Content>
