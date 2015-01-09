using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
public class userDetailsVO
{
    public int userid { set; get; }
    public string userName { set; get; }
    public string userFullName { set; get; }
    public string location { set; get; }
    public string occupation { set; get; }
    public string followedCrops { set; get; }
    public string userImageId { set; get; }

    public DataTable wallPosts { set; get; }
    public string plantedSoFar { set; get; }
    public userDetailsVO()
    {

    }
    public userDetailsVO(String userName)
    {
        this.userName = userName;
    }
}
