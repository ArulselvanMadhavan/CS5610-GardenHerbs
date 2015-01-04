<%@ WebHandler Language="C#" Class="DisplayImg" %>

using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;

public class DisplayImg : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        Int32 theID;
        if (context.Request.QueryString["id"] != null)
            theID = Convert.ToInt32(context.Request.QueryString["id"]);
        else
            throw new ArgumentException("No parameter specified");

        context.Response.ContentType = "image/jpeg";
        Stream strm = DisplayImage(theID);
        byte[] buffer = new byte[2048];
        int byteSeq = strm.Read(buffer, 0, 2048);

        while (byteSeq > 0)
        {
            context.Response.OutputStream.Write(buffer, 0, byteSeq);
            byteSeq = strm.Read(buffer, 0, 2048);
        }
    }
    
    public Stream DisplayImage(int theID)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "SELECT CropImage FROM arulselv.user_crop_images WHERE ImageId = @ID";
        SqlCommand cmd = new SqlCommand(sql,connection);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@ID", theID);
        connection.Open();
        object theImg = cmd.ExecuteScalar();
        try
        {
            return new MemoryStream((byte[])theImg);
        }
        catch
        {
            return null;
        }
        finally
        {
            connection.Close();
        }
    }
 
    public bool IsReusable {
        get
        {
            return false;
        }
    }

}