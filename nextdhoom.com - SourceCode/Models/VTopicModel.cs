using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class VTopicModel
    {
        public ViewTopicModel Vtp { get; set; }
        public List<TopicAnsModel> TpAns { get; set; }

        public insertAnsModel insAns { get; set; } 
    }
}