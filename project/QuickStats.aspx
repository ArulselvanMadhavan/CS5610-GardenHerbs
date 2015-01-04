<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuickStats.aspx.cs" Inherits="project_QuickStats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <div class="d_getpastdata">
      <table class="t_getpastdata">
            <tr>
                <td class="b_getpastdata">
                    <asp:Button ID="btn_getpastdata" runat="server" 
                        Text="Fetch Stats"
                        onclick="btn_getpastdata_Click" />
                    </td>
                <td class="dd_stateList">
                    <asp:DropDownList ID="stateList" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="dd_cities_List">
                    <asp:DropDownList ID="citiesList" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                </td>
            </tr>
        </table>
         <div class="d_searchResults">
    <table class="t_census_Results">
    <tr>
    <td class="g_census_Results">
        <asp:GridView ID="g_census_Results" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        </td>
        </tr>
        </table>
    </div>
    <div>
    <table>
    <tr>
    <td>
    <p id="errorMsg" runat="server" visible="false" style="text-align: center; background-color: Silver; border: 1px dotted gray"></p>
        </td>
    </tr>
    </table>
    </div>
         </div>
    </form>
</body>
</html>
