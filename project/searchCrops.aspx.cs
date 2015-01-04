using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class project_searchCrops : System.Web.UI.Page
{
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void submit_Click(object sender, EventArgs e)
    {

            cropResultsVO cropSearchRequest = new cropResultsVO(search.Value);
            DataTable dt = cropDAO.queryForCrop(cropSearchRequest);
            searchResults.DataSource = cropDAO.queryForCrop(cropSearchRequest);
            searchResults.DataBind();

    }

    public string getendorsedUsersCount(string allendorsedUsers)
    {
        List<string> listOfEndorsedUsers = allendorsedUsers.Split(':').ToList<string>();
        listOfEndorsedUsers.RemoveAt(0);   // First value is always empty
        return listOfEndorsedUsers.Count.ToString();
    }

}