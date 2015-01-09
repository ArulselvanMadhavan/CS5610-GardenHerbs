using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

public class cropNameVO
{
    public int commentid { set; get; }
    public int requestedCropID { set; get; } 
    public int cropImageId { set; get; }
    public string cropName { set; get; }
    public string cropScientificName { set; get; }
    public string suggestedProductionPractices { set; get; }
    public string methodFollowedByUser { set; get; }
    public string numberOfPlantings {set;get;}
    public string PlantedOn {set;get;}
    public string plantedFrom {set;get;}
    public string shade {set;get;}
    public string endorsedUsers { set; get; }
    public DataTable cropComments { set; get; }

    public string userName { set; get; }
    public cropNameVO()
    {

    }
    public cropNameVO(int requestedCropID)
    {
        this.requestedCropID = requestedCropID;
    }


}
