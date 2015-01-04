using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class likeThisPostVO
{
    public int postId { set; get; }
    public int userId { set; get; }
    public string likedUser {set; get;}
    public string allLikedUsers { set; get; }

    public likeThisPostVO()
    {

    }

    public likeThisPostVO(int postId, string likedUser, int userId)
    {
        // TODO: Complete member initialization
        this.postId = postId;
        this.likedUser = likedUser;
        this.userId = userId;
    }
    public likeThisPostVO(int postId, string likedUser, int userId, string allLikedUsers)
    {
        this.postId = postId;
        this.likedUser = likedUser;
        this.userId = userId;
        this.allLikedUsers = allLikedUsers;
    }
}
