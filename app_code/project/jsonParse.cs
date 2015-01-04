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

/// <summary>
/// Summary description for jsonParse
/// </summary>
public class jsonParse
{
	public jsonParse()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    [DataContract]
    public class MarketResults
    {
        [DataMember(Name = "Address")]
        public string Address { get; set; }
        [DataMember(Name = "GoogleLink")]
        public string GoogleLink { get; set; }
        [DataMember(Name = "Products")]
        public string Products { get; set; }
        [DataMember(Name = "Schedule")]
        public string Schedule { get; set; }

    }

    public class MarketResponse
    {
        [DataMember(Name = "marketdetails")]
        public MarketResults marketdetails { get; set; }
    }

    public object getMarketDetails(string p)
    {
        try
        {
            string marketDetailsRequest = createMarketDetailsRequest(p);
            MarketResponse MarketResponse = makeMarketDetailsRequest(marketDetailsRequest);
            return processMarketResponse(MarketResponse);
        }
        catch (Exception exc)
        {
            return null;
        }

    }

    private static MarketResponse makeMarketDetailsRequest(string marketDetailsRequest)
    {
        try
        {
            HttpWebRequest request = WebRequest.Create(marketDetailsRequest) as HttpWebRequest;
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                    throw new Exception(String.Format(
                    "Server error (HTTP {0}: {1}).",
                    response.StatusCode,
                    response.StatusDescription));
                DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(MarketResponse));
                object objResponse = jsonSerializer.ReadObject(response.GetResponseStream());
                MarketResponse marketres = objResponse as MarketResponse;
                //JSONResponse jsonres = objResponse as JSONResponse;
                return marketres;
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return null;
        }
    }

    private static MarketResults processMarketResponse(MarketResponse MarketResponse)
    {
        MarketResults marketResults = new MarketResults();
         marketResults.Address = MarketResponse.marketdetails.Address.ToString();
         marketResults.Products = MarketResponse.marketdetails.Products.ToString();
         marketResults.Schedule = MarketResponse.marketdetails.Schedule.Trim();
         marketResults.GoogleLink = MarketResponse.marketdetails.GoogleLink.ToString();
        return marketResults;
    }

    private static string createMarketDetailsRequest(string p)
    {
        string UrlRequest = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=" + p;
        return (UrlRequest);
    }
}