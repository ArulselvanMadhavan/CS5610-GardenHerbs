using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class postCommentVO
{
    public int commentid { get; set; }
    public Nullable<int> postId { get; set; }
    public string commentedUser { get; set; }
    public string wallName { get; set; }
    public Nullable<System.DateTime> commentedDate { get; set; }
    public string comments { get; set; }
    public string likedusers { get; set; }

    public postCommentVO()
    {

    }
}
