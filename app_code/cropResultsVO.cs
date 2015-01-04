using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class cropResultsVO
{
    public string cropName { set; get;}
    public int uploadId { set; get; }
    public string userName { set; get; }
    public string plantedOn { set; get; }
    public string endorsedUsers { set; get; }
    public cropResultsVO()
    {

    }
    public cropResultsVO(String cropName)
    {
        this.cropName = cropName;
    }
}
