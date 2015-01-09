using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class likeThisCropVO
{
    public int commentId { set; get; }
    public string userName{set;get;}
    public string cropName { set; get; }
    public string allLikedUsers { set; get; }

    public int uploadId { set; get; }
    public likeThisCropVO()
    {
    
    }
    public likeThisCropVO(int commentId,string userName,int uploadId)
    {
        this.commentId = commentId;
        this.userName = userName;
        this.uploadId = uploadId;
    }
    public likeThisCropVO(int commentId, string userName, int uploadId,string allLikedUsers)
    {
        this.commentId = commentId;
        this.userName = userName;
        this.uploadId = uploadId;
        this.allLikedUsers = allLikedUsers;
    }
}
