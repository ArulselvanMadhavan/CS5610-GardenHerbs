<%@ WebHandler Language="C#" Class="DisplayImg" %>

using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;

public class DisplayImg : IHttpHandler {

    displayImageDAO displayImageDAO = new displayImageDAO();
    public void ProcessRequest (HttpContext context)
    {
        Int32 theID;
        Int32 userID;
        Int32 uploadID;
        if (context.Request.QueryString["id"] != null)
        {
            theID = Convert.ToInt32(context.Request.QueryString["id"]);

            context.Response.ContentType = "image/jpeg";
            Stream strm = displayImageDAO.DisplayCropImage(theID);
            byte[] buffer = new byte[2048];
            int byteSeq = strm.Read(buffer, 0, 2048);

            while (byteSeq > 0)
            {
                context.Response.OutputStream.Write(buffer, 0, byteSeq);
                byteSeq = strm.Read(buffer, 0, 2048);
            }
        }
        else if (context.Request.QueryString["userid"] != null)
        {
            userID = Convert.ToInt32(context.Request.QueryString["userid"]);

            context.Response.ContentType = "image/jpeg";
            Stream strm = displayImageDAO.DisplayUserImage(userID);
            byte[] buffer = new byte[2048];
            int byteSeq = strm.Read(buffer, 0, 2048);

            while (byteSeq > 0)
            {
                context.Response.OutputStream.Write(buffer, 0, byteSeq);
                byteSeq = strm.Read(buffer, 0, 2048);
            }
        }
        else if (context.Request.QueryString["uploadId"] != null)
        {
            uploadID = Convert.ToInt32(context.Request.QueryString["uploadId"]);

            context.Response.ContentType = "image/jpeg";
            Stream strm = displayImageDAO.DisplayUploadedImage(uploadID);
            byte[] buffer = new byte[2048];
            int byteSeq = strm.Read(buffer, 0, 2048);

            while (byteSeq > 0)
            {
                context.Response.OutputStream.Write(buffer, 0, byteSeq);
                byteSeq = strm.Read(buffer, 0, 2048);
            }
        }
        else
        {
            throw new ArgumentException("No parameter specified");
        }
    }
    
   
 
    public bool IsReusable {
        get
        {
            return false;
        }
    }

}