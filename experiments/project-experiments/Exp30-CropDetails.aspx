<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp30-CropDetails.aspx.cs" Inherits="experiments_project_experiments_Exp30_CropDetails" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp30-Crop details</title>
    <%--<link href="css/crophome/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/cropdetails/cropdetail.css" rel="stylesheet" />
    <%--<link href="css/cropdetail/cropdetail.css" rel="stylesheet" />--%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script runat="server">
       
    </script>
</head>
<body>
    <div class="wrapper">
    <form id="cropform" runat="server">
        <h3 id="cropnameheader">
    <asp:Label runat="server" id="lbl_cropname"></asp:Label>
<%--            <asp:DataList ID="cropdetails" runat="server">
            </asp:DataList>--%>
            </h3>
        <table class="croptable">
            <tr class="row">
                <td class="selector">
                    <span>Crop Scientific Name:</span>
                </td>
                <td>
                    <i>
                     <asp:Label ID="lbl_crop_sciname" runat="server"
                                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                
                        </i>
                </td>
            </tr>
            <tr class="row">
                <td class="selector">
                    <span>Production Practices:</span>
                </td>
                <td>
                    <i>
                     <asp:Label ID="lbl_prod_practices" runat="server"
                                                Font-Size="10pt" ForeColor="#336699" Width="100%" />
                
                        </i>
                </td>
            </tr>
        </table>

        <div>
            <asp:TextBox ID="Commentbox" runat="server" TextMode="MultiLine" />
        </div>
         <div>
              <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        </div>
        <div class="div_commentbtn">
            <asp:Button ID="btn_comment" runat="server" Text="Post Your Comment" /> 
        </div>
    </form>
        </div>
</body>
</html>
