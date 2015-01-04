using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class experiments_project_experiments_Exp29_ListGrid_dynamic_update : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        cropDetailsDAO cropDAO = new cropDetailsDAO();
        CropList.DataSource = cropDAO.browseCrops();
        CropList.DataBind();
    }
}