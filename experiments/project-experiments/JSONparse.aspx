<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JSONparse.aspx.cs" Inherits="project_JSON_parse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exp 20: Parsing JSON Data in C#</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
</head>
<body>
     <div id="d_heading">
        <h1>Experiment 20: Parsing JSON Data in C#</h1>
         <h2><i>Purpose of the Experiment:</i></h2><p>So far, I have only been parsing JSON in the client side using JQuery,Angular JS etc., Since the data I will use in my project comes as JSON, I decided to experiment on parsing JSON data in C#.</p>
        <h2>Experiment Demo:</h2>         
     </div>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="btn_MarketSchedule" runat="server" Text="Get Farmers Market in Boston"  CssClass="btn-success"
            onclick="btn_MarketSchedule_Click" />
    
        <br />
        <asp:GridView ID="g_Marketdetails" runat="server"></asp:GridView>
    </div>
        <div>
            <h2>Documentation:</h2>
            <p>1. Parsing JSON in C# is quite harder in comparison with XML. </p>
            <p>2. First we have to write the data contract for the kind of data that we will parsing. This totally depends on the key-value pairs that is returned to us in the form of JSON.</p>
            <p>Here is a sample data contract. </p>
            <pre>
    DataSet RunDS = new DataSet();
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
            public List< JSONResults> results { get; set; }
        }
            </pre>
            <p>
                4. Having a data contract for all the fields will help us extract the data easily using objects.
            </p>
            <p>
                5. Next we need to initiate a connection request and retrieve the data to parse.
                Once the data is receieved, we need to use the deserialize the JSON data.
                Microsoft provides 2 classes for JSON serialization - "using System.Runtime.Serialization;"
"using System.Runtime.Serialization.Json;"
            </p>
            <pre>
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
            </pre>
            <p>
                5. Next, we can access all the HJSON data using the data contracts that we specified earlier. 
                Here is a sample code
            </p>
            <pre>
    static public DataTable ProcessResponse(JSONResponse JSONres)
    {

        int total_markets = JSONres.results[0].id.Length;
        
        DataTable dt = new DataTable("MarketDetails_Table");
        dt.Columns.Add("Market_Id");
        dt.Columns.Add("Market_Name");
        for (int i = 0; i < total_markets; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Market_Id"] = JSONres.results[i].id;
            dr["Market_Name"] = JSONres.results[i].marketname;
            dt.Rows.Add(dr);
        }
        return dt;
        
    }
            </pre>
        </div>
        <div>
            <hr />
            <br />
            <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/JSONparse.aspx" style="color:black; text-decoration:underline" target="_blank">Link to source file</a><br />
            <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/project-experiments/JSONparse.aspx.cs" style="color:black; text-decoration:underline" target="_blank">Link to C# file</a>
        </div>
        <div>
            <h2>References:</h2>
            <a href ="http://msdn.microsoft.com/en-us/library/hh674188.aspx" target="_blank">MSDN Library</a>
        </div>
    </form>
</body>
</html>
