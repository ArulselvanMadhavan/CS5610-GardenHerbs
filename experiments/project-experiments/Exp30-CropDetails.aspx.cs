using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Net;
using System.Configuration;
public partial class experiments_project_experiments_Exp30_CropDetails : System.Web.UI.Page
{
    cropDetailsDAO cropDAO = new cropDetailsDAO();

    protected void Page_Load(object sender, EventArgs e)
    {

        //string cropname_request = Request.QueryString["cropname"];
        string cropname_request = "tomato"; //For the purposes of showcasing this experiment to Instructors, I am defaulting this variable to 'tomato'. In realtime, the code commented above will be used.
        if(cropname_request==null)
        {
            lbl_cropname.Text = "No Crops selected to display" ;
            return;
        }
        lbl_cropname.Text = char.ToUpper(cropname_request[0]) + cropname_request.Substring(1);  //Capitalize First letter and display it.
        //cropNameVO crop = new cropNameVO(lbl_cropname.Text);
        //cropNameVO cropResultsFromDB = cropDAO.getCropDetails(crop);
        //if (cropResultsFromDB == null) 
        //{
        //    lblStatus.Text = "There are no details available for this crop." ;
        //}
        //else
        //{
        //    lbl_crop_sciname.Text = cropResultsFromDB.cropScientificName;
        //    lbl_prod_practices.Text = cropResultsFromDB.cropProductionPractices;
        //}
    }
}