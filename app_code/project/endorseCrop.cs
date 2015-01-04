using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class endorseCrop
{
    public string userName { set; get; }
    public string allEndorsedUsers { set; get; }

    public int uploadId { set; get; }
    public endorseCrop()
    {

    }
    public endorseCrop (string userName , string allEndorsedUsers, int uploadId)
    {
        this.userName = userName;
        this.allEndorsedUsers = allEndorsedUsers;
        this.uploadId = uploadId;
    }
    public endorseCrop(string userName, int uploadId)
    {
        this.userName = userName;
        this.uploadId = uploadId;
    }
}
