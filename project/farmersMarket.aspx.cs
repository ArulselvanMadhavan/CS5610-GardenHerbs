using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Data;
using System.Collections;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Text.RegularExpressions;

public partial class project_JSON_parse : System.Web.UI.Page
{
    DataSet RunDS = new DataSet();
    cropDetailsDAO cropDAO = new cropDetailsDAO();
    [DataContract]
    public class JSONResults
    {
        [DataMember(Name = "id")]
        public string id { get; set; }
        [DataMember(Name = "marketname")]
        public string marketname { get; set; }
    }

    public class JSONResponse
    {
        [DataMember(Name = "results")]
        public List<JSONResults> results { get; set; }
    }



    protected void Page_Load(object sender, EventArgs e)
    {
        lblError.Visible = false;
        if (!IsPostBack)
        {
            ddl_statelist.DataTextField = "stateName";
            ddl_statelist.DataValueField = "stateName";
            ddl_statelist.DataSource = cropDAO.fetchStateDetails();
            ddl_statelist.DataBind();
            ddl_zipCodeList.Items.Add("Select a ZipCode");
        }
       
    }
    protected void btn_MarketSchedule_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddl_zipCodeList.Value == "Select a ZipCode")
            {
                lblError.Visible = true;
                lblError.Text = "Please select a zipcode to continue";
            }
            else
            {
                string locationsRequest = CreateRequest(ddl_zipCodeList.Value.Trim());
                JSONResponse JSONResponse = MakeRequest(locationsRequest);
                RunDS.Tables.Add(ProcessResponse(JSONResponse));
                g_Marketdetails.DataSource = RunDS;
                g_Marketdetails.DataBind();
                g_Marketdetails.Visible = true;
                g_Marketdetails.UseAccessibleHeader = true;
                g_Marketdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
                TableCellCollection cells = g_Marketdetails.HeaderRow.Cells;
                cells[0].Attributes.Add("data-class", "expand");
                cells[1].Attributes.Add("data-hide", "phone");
                cells[2].Attributes.Add("data-hide", "phone,tablet");
                cells[3].Attributes.Add("data-hide", "phone,tablet");
                cells[4].Attributes.Add("data-hide", "phone,tablet");
                cells[5].Attributes.Add("data-hide", "phone,tablet");
                g_Marketdetails.FooterRow.TableSection = TableRowSection.TableFooter;
                update_MarketDetails.Update();

            }
        }
        catch (Exception exc)
        {
            lblError.Text = exc.Message;
            //Console.WriteLine(exc.Message);
            //Console.Read();
        }

    }
    public static string CreateRequest(string zipCode)
    {
        string UrlRequest = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip=" + zipCode;
        return (UrlRequest);
    }

    public static JSONResponse MakeRequest(string requestUrl)
    {
        try
        {
            HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                    throw new Exception(String.Format(
                    "Server error (HTTP {0}: {1}).",
                    response.StatusCode,
                    response.StatusDescription));
                DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(JSONResponse));
                object objResponse = jsonSerializer.ReadObject(response.GetResponseStream());
                JSONResponse jsonres = objResponse as JSONResponse;
                return jsonres;
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return null;
        }

    }
    static public DataTable ProcessResponse(JSONResponse JSONres)
    {
        jsonParse MarketDetails = new jsonParse();
        jsonParse.MarketResults marketResults = new jsonParse.MarketResults();
        int total_markets = JSONres.results[0].id.Length;

        DataTable dt = new DataTable("MarketDetails_Table");
        dt.Columns.Add("Market_Id");
        dt.Columns.Add("Market_Name");
        dt.Columns.Add("Address");
        dt.Columns.Add("Products");
        dt.Columns.Add("Schedule");
        dt.Columns.Add("Miles from the center of Zipcode");
        //dt.Columns.Add("Map");
        for (int i = 0; i < total_markets; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Market_Id"] = JSONres.results[i].id;
            string myString = JSONres.results[i].marketname;
            string alphabet = String.Empty;
            string digit = String.Empty;

            Match regexMatch = Regex.Match(myString, "[a-z]");
            if (regexMatch.Success) //Found numeric part in the coverage string
            {
                int digitStartIndex = regexMatch.Index; //Get the index where the numeric digit found
                digit = myString.Substring(0, digitStartIndex - 1);
                digit.Trim();
                dr["Miles from the center of Zipcode"] = digit;
                alphabet = myString.Substring(digitStartIndex - 1);
                dr["Market_Name"] = alphabet;
            }
            //getMarketName(JSONres.results[i].marketname);
            //= JSONres.results[i].marketname;

            marketResults = (jsonParse.MarketResults)MarketDetails.getMarketDetails(JSONres.results[i].id);
            //getMarketDetails(JSONres.results[i].id);
            dr["Address"] = marketResults.Address;

            try
            {
                if (marketResults.Products == null || marketResults.Products == "")
                {
                    dr["Products"] = "No Specific Products to list.";
                }
                else
                {
                    dr["Products"] = marketResults.Products;
                }
                // Remove Junk Characters from the End of Schedule 
                if (marketResults.Schedule.Length == 0)
                {
                    dr["Schedule"] = "Schedule for this market hasn't been posted yet.";
                }
                else
                {
                    string s = marketResults.Schedule.Substring(0, marketResults.Schedule.Length - 15);
                    dr["Schedule"] = s;
                }
                //dr["Map"] = marketResults.GoogleLink;
                //dr["Miles from the center of Zipcode"] = ;
                dt.Rows.Add(dr);
            }
            catch (Exception ex)
            {

                continue; // Skip Invalid Records 
            }
        }
        return dt;
    }
    protected void ddl_Statelist_SelectedIndexChanged(object sender, EventArgs e)
    {

        //g_Marketdetails.Visible = false;
        ddl_zipCodeList.DataTextField = "zipcode";
        ddl_zipCodeList.DataValueField = "zipcode";
        ddl_zipCodeList.DataSource = cropDAO.fetchZipCodeDetails(ddl_statelist.SelectedValue);
        ddl_zipCodeList.DataBind();
        //updateZip.Update();
        //update_Statelist.Update();
        //update_Statelist.Update();
        g_Marketdetails.Visible = false;
        //g_Marketdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        //g_Marketdetails.Visible = true;

        //g_Marketdetails.DataBind();

    }
    protected void onRowCreate(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            int colSpan = e.Row.Cells.Count;

            for (int i = (e.Row.Cells.Count - 1); i >= 1; i -= 1)
            {
                e.Row.Cells.RemoveAt(i);
                e.Row.Cells[0].ColumnSpan = colSpan;
            }

            e.Row.Cells[0].Controls.Add(new LiteralControl("<div id=page class='pagination pagination-centered hide-if-no-paging'></div>"));
        }
    }
    protected void g_Marketdetails_PreRender(object sender, EventArgs e)
    {

        if ((g_Marketdetails.ShowHeader == true && g_Marketdetails.Rows.Count > 0)
      || (g_Marketdetails.ShowHeaderWhenEmpty == true))
        {
            //Force GridView to use <thead> instead of <tbody>
            g_Marketdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        //if (g_Marketdetails.ShowFooter == true && g_Marketdetails.Rows.Count > 0)
        //{
        //    //Force GridView to use <tfoot> instead of <tbody> - 11/03/2013 - MCR.
        //    g_Marketdetails.FooterRow.TableSection = TableRowSection.TableFooter;
        //}
        base.OnPreRender(e);
    }

}