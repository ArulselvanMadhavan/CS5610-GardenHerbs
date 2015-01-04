using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class project_QueryDB : System.Web.UI.Page
{
    string sqlQuery = "";
    DataSet RunDS = new DataSet();
    public void fetchFromDB(string query)
    {
        try
        {
            
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "arulselv.state_details");

                g_stateDetails.DataSource = ds.Tables["arulselv.state_details"];
                g_stateDetails.DataBind();
                g_stateDetails.Visible = true;

            }
        }
        catch
        {

            //errorMsg.InnerText= "Unable to establish connection with the database!";

            //errorMsg.Visible = true;

        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btn_getStateDetails_Click(object sender, EventArgs e)
    {
        string state_code = DropDownList1.SelectedItem.ToString();
        sqlQuery = "select * from arulselv.state_details where stateCode ='" + state_code+"'";
        fetchFromDB(sqlQuery);
    }
}