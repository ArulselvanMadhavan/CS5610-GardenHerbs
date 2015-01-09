using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class cropUploadVO
{
    public string userName {set; get;}
    
    public int cropId { set; get; }
    public string cropName { set; get; }
    public int totalPlantings { set; get; }
    public string plantedFrom { set; get; }
    public string shade { set; get; }
    public int uploadId { set; get; }

    public string productionPractice { set; get; }
    public cropUploadVO()
    {

    }

    public cropUploadVO(string userName, int cropId, string cropName, int totalPlantings, string plantedFrom, string shade, string productionPractice)
    {
        this.userName = userName;
        this.cropId = cropId;
        this.cropName = cropName;
        this.plantedFrom = plantedFrom;
        this.shade = shade;
        this.productionPractice = productionPractice;
        this.totalPlantings = totalPlantings;
    }


}
