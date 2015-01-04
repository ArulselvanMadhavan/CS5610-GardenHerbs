using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class postVO
{
    public int postid { get; set; }
    public string wallName { get; set; }
    public string postedBy { get; set; }
    public Nullable<System.DateTime> postedDate { get; set; }
    public string postContent { get; set; }
    public string likedusers { get; set; }
    public int userId { get; set; }

    public postVO()
    {

    }
    public postVO(int userId , string wallName,string postedBy,string postContent)
    {
        this.userId = userId;
        this.wallName = wallName;
        this.postedBy = postedBy;
        this.postContent = postContent;
    }     
}
