<%@ Page Language="C#" MasterPageFile="~/project/project.master" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Homepage" %>
     
<asp:content id="Content1" ContentPlaceHolderID="head" runat="server"> 
<link rel="stylesheet" href="Searchbar.css"/>  
   
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
  </asp:content>
    

