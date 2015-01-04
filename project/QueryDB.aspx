<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QueryDB.aspx.cs" Inherits="project_QueryDB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>02120</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btn_getStateDetails" runat="server" Text="GetStateDetails" OnClick="btn_getStateDetails_Click" />
        <br />
        <asp:GridView ID="g_stateDetails" runat="server">
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
