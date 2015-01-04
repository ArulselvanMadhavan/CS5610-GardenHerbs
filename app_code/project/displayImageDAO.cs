using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for displayImageDAO
/// </summary>
public class displayImageDAO
{
	public displayImageDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Stream DisplayCropImage(int theID)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "SELECT CropImage FROM arulselv.uploadMaster WHERE uploadId = @ID";
        SqlCommand cmd = new SqlCommand(sql, connection);
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

    public Stream DisplayUserImage(int theID)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "SELECT userimg FROM arulselv.userDetailsMaster WHERE userId = @ID";
        SqlCommand cmd = new SqlCommand(sql, connection);
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
    public Stream DisplayUploadedImage(int theID)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["arulselv"].ToString());
        string sql = "SELECT cropImage FROM arulselv.uploadMaster WHERE uploadID = @ID";
        SqlCommand cmd = new SqlCommand(sql, connection);
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
}