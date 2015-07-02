using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class insertTopicModel
    {
        [DisplayName("Title")]
        [Required]
        public string  topicTitle { get; set; }

       
        [DisplayName("Description")]
        [Required]
        public string  topicDesc { get; set; } 
        public long catId { get; set; } 
        public long subCatId { get; set; } 
        public long memsid { get; set; } 
        public long updateCandiId { get; set; }  
        public string  updateCandiName { get; set; }
        public System.DateTime  startDate { get; set; }
        public System.DateTime  updateDate { get; set; }
        
    }
}