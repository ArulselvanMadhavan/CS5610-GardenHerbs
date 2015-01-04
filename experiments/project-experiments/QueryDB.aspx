<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QueryDB.aspx.cs" Inherits="project_QueryDB" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace= "System.Data" %>
<%@ Import Namespace= "System.Collections" %>
<%@ Import Namespace= "System.Collections.Generic"%>
<%@ Import Namespace= "System.IO" %>
<%@ Import Namespace= "System.Xml" %>
<%@ Import Namespace= "System.Xml.XPath" %>
<%@ Import Namespace= "System.Xml.Linq" %>
<%@ Import Namespace="System.Net" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp 22: First attempts in Connecting to SQL DB</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
</head>
<body>
    <h2>Experiment 22: Connecting to SQL DB and retrieving records</h2>
    <p><i><b>Purpose Of the Experiment:</b></i> Since , I will be using the SQL DB to retrieve data , I decided to experiment in connecting to SQL DB from my website.</p>
    <p>Experiment Demo: On clicking the button 'Get State details' , data stored in my data should get displayed ina grid view below.</p>
    <p>Caveat: When you click the button a long list of zipcodes that relate to the value in the dropdown box will get displayed and you may have to scroll down to view the rest of the documentation.</p>
    <form id="form1" runat="server">
    <div>
    
        <asp:DropDownList ID="DropDownList1" runat="server">
             <asp:ListItem>CT</asp:ListItem>
 <asp:ListItem>DE</asp:ListItem>
 <asp:ListItem>DC</asp:ListItem>
 <asp:ListItem>FL</asp:ListItem>
 <asp:ListItem>GA</asp:ListItem>
 <asp:ListItem>HI</asp:ListItem>
 <asp:ListItem>ID</asp:ListItem>
 <asp:ListItem>IL</asp:ListItem>
 <asp:ListItem>IN</asp:ListItem>
 <asp:ListItem>IA</asp:ListItem>
 <asp:ListItem>KS</asp:ListItem>
 <asp:ListItem>KY</asp:ListItem>
 <asp:ListItem>LA</asp:ListItem>
 <asp:ListItem>ME</asp:ListItem>
 <asp:ListItem>MD</asp:ListItem>
 <asp:ListItem>MA</asp:ListItem>
 <asp:ListItem>MI</asp:ListItem>
 <asp:ListItem>MN</asp:ListItem>
 <asp:ListItem>MS</asp:ListItem>
 <asp:ListItem>MO</asp:ListItem>
 <asp:ListItem>MT</asp:ListItem>
 <asp:ListItem>NE</asp:ListItem>
 <asp:ListItem>NV</asp:ListItem>
 <asp:ListItem>NH</asp:ListItem>
 <asp:ListItem>NJ</asp:ListItem>
 <asp:ListItem>NM</asp:ListItem>
 <asp:ListItem>NY</asp:ListItem>
 <asp:ListItem>NC</asp:ListItem>
 <asp:ListItem>ND</asp:ListItem>
 <asp:ListItem>OH</asp:ListItem>
 <asp:ListItem>OK</asp:ListItem>
 <asp:ListItem>OR</asp:ListItem>
 <asp:ListItem>PA</asp:ListItem>
 <asp:ListItem>RI</asp:ListItem>
 <asp:ListItem>SC</asp:ListItem>
 <asp:ListItem>SD</asp:ListItem>
 <asp:ListItem>TN</asp:ListItem>
 <asp:ListItem>TX</asp:ListItem>
 <asp:ListItem>UT</asp:ListItem>
 <asp:ListItem>VT</asp:ListItem>
 <asp:ListItem>VA</asp:ListItem>
 <asp:ListItem>WA</asp:ListItem>
 <asp:ListItem>WV</asp:ListItem>
 <asp:ListItem>WI</asp:ListItem>
 <asp:ListItem>WY</asp:ListItem>

        </asp:DropDownList>
        <asp:Button ID="btn_getStateDetails" runat="server" Text="GetStateDetails" OnClick="btn_getStateDetails_Click" CssClass="btn-info" />
        <br />
        <asp:GridView ID="g_stateDetails" runat="server">
        </asp:GridView>
    
    </div>
    </form>
    <div>
    <h2>Documentation:</h2>
    <p>
        1. In my project, I need to fetch the zipcode, statecode, state name , city name and latitude and longitude information of states. 
    </p>
    <p>
        2. I downloaded the zipcode details data from USPS site and framed around 50000 queries to insert data into my DB.
    </p>
    <p>
        3. After successfully inserting all the data into the DB, we can frame queries to extract data from the Db.
    </p>
        <p>4. In this experiment, I am attempting to fetch all the zipcodes that correspond to a state code selected in the dropdown box.</p>
    <p>
        Issues: I encountered several issues in connecting to DB. Here is a piazza post that details that I have had in connecting to SQL DB.
        <a href="https://piazza.com/class/hzjweqipsld4r4?cid=81" target="_blank">Piazza post</a>
    </p>
    </div>
     <br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/QueryDB.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a>
    <div>
        <h2>References</h2>
        <a href="http://www.ccs.neu.edu/teaching/web/accessing_sql.htm" target="_blank">Prof. Rasala's Experiments</a>
    </div>
</body>
</html>
