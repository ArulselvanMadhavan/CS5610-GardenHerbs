using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class replyPostVO
{
    //private int postId1;

    public int postId { set; get; }
    public string wallName { set; get; }
    public string postedBy { set; get; }
    public string reply { set; get; }

    public replyPostVO()
    {

    }

    public replyPostVO(int postId, string wallName, string postedBy, string reply)
    {
        // TODO: Complete member initialization
        this.postId = postId;
        this.wallName = wallName;
        this.postedBy = postedBy;
        this.reply = reply;
    }

    public replyPostVO(int postId)
    {
        // TODO: Complete member initialization
        this.postId = postId;
    }

}
