using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

public class cropCommentVO
{
    public string cropName { set; get; }
    public int commentId { set; get; }
    public string commentedUser { set; get; }
    public string comments { set; get; }
    public string likedUsers { set; get; }
    public int uploadId {set;get;}
    public cropCommentVO()
    {

    }
    public cropCommentVO(string crop)
    {
        this.cropName = crop;
    }
    public cropCommentVO(string cropName, string commentedUser, string comments,int uploadId)
    {
        this.cropName = cropName;
        this.commentedUser = commentedUser;
        this.comments = comments;
        this.uploadId = uploadId;
    }
}
