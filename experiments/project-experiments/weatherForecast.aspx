<%@ Page Language="C#" AutoEventWireup="true" CodeFile="weatherForecast.aspx.cs" Inherits="Project_weatherForecast" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <title>Experiment 19: Parsing XML Data and working with ASP.NET Grid View</title>
    <link rel="stylesheet" href="weatherForecast.css"/>
    <link rel="stylesheet" href="css/bootstrap.css" />
</head>
<body>
    <div>
        <h2>Experiment 19: Parsing XML Data and working with ASP.NET Grid view</h2>
        <h3><i>Experiment Demo: Click the below button to get the weather forecast for the next 10 days. </i></h3>
        <h3>Purpose of the Experiment:</h3>
        <p>Since, some of the data that I will be using in my project are of XML form, I decided to get myself familiarized with the process involved in parsing XML data.</p>
    </div>
    <form id="form1" runat="server">
    <div class="d_weatherForecastRequest">
      
        <table class="t_WeatherForecastRequest">
            <tr>
                <td class="b_WeatherForecast">
                    <asp:Button ID="btnWeatherForecast" runat="server" 
                        Text="Get Weather Forecast for the next 5 days" CssClass="btn-info"
                        onclick="btnWeatherForecast_Click" />
                    </td>
            </tr>
        </table>
      
    </div>
    <div class="d_searchResults">
    <table class="t_forecastResults">
    <tr>
    <td class="g_forecastResults">
        <asp:GridView ID="g_forecastResults" runat="server" CellPadding="4" ForeColor="#333333" 
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
    </tr>
    </table>
    </div>
    </form>
    <div>
        <h2>Documentation:</h2>
        <p>1. In this experiment , I am fetching weather forecast details in the form of XML data from worldweather API.</p>
        <p>2. The retrieved XML data contains weather forecast details for the next 5 days.</p>
        <pre>
Here is the URI , that I use : "http://api.worldweatheronline.com/free/v1/weather.ashx?key="+w_key+"&q=boston&num_of_days=5&format=xml"
        </pre>
<p>
    3. Once the data is retrieved , I am querying the XML data using LINQ and assigning the elements to a dataset.
</p>
        <pre>
       public static XmlDocument makeAPIRequest(string requestUrl)
            {try
                {
                HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(response.GetResponseStream());
                return (xmlDoc);

                }
           }
    public void ProcessResponse(XmlDocument locationsResponse)
    {
        //Create namespace manager
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(locationsResponse.NameTable);
        nsmgr.AddNamespace("rest", "http://schemas.microsoft.com/search/local/ws/rest/v1");
        XmlNodeList locationElements = locationsResponse.SelectNodes("//rest:data", nsmgr);
        DataSet RunDS = new DataSet();
        DataTable dt = new DataTable("weatherForecastTable");
        dt.Columns.Add("Date");
        dt.Columns.Add("tempMaxC");
        dt.Columns.Add("windspeedMiles");
        dt.Columns.Add("Wind Direction");
        dt.Columns.Add("Wind Direction Degree");
        dt.Columns.Add("Precip MM");
        string UrlRequest = " http://api.worldweatheronline.com/free/v1/weather.ashx?key=" + w_key + "&q=boston&num_of_days=5&format=xml";
        XDocument doc = XDocument.Load(UrlRequest);
    }
        </pre>
        <p>
            4. Once all the elements are added to the dataset, I am assigning it to the data grid.
            <pre>
        foreach (XElement weather in doc.Descendants("data").Elements("weather"))
        {
            DataRow dr = dt.NewRow();
            dr["Date"] = weather.Element("date").Value;
            dr["tempMaxC"] = weather.Element("tempMaxC").Value;
            dr["windspeedMiles"] = weather.Element("windspeedMiles").Value;
            dr["Wind Direction"] = weather.Element("winddirection").Value;
            dr["Wind Direction Degree"] = weather.Element("winddirDegree").Value;
            dr["Precip MM"] = weather.Element("precipMM").Value;
            dt.Rows.Add(dr);
        }
        RunDS.Tables.Add(dt);
        g_forecastResults.DataSource = RunDS;
        g_forecastResults.DataBind();
        g_forecastResults.Visible = true;
    }
        

            </pre>
        </p>
        <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/weatherForecast.aspx" style="color:black; text-decoration:underline;" target="_blank">Link to the source file</a><br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/weatherForecast.css" target="_blank" style="color:black; text-decoration:underline">Link to Stylesheet</a><br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/weatherForecast.aspx.cs" target="_blank" style="color:black; text-decoration:underline">Link to the C# file</a><br />
        <hr />
        <h3>References</h3>
        <a  href="https://developer.worldweatheronline.com/page/documentation" target="_blank">1. World Weather Online API Documentation</a><br />
        <a href="http://msdn.microsoft.com/en-us/library/cc189056(VS.95).aspx" target="_blank">2. MSDN Libraray</a>
    </div>    
</body>
</html>
