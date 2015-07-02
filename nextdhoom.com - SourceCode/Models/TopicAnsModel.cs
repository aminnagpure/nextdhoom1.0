using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class TopicAnsModel
    {
        public long AnsId{ get; set; }
        public long TopicId { get; set; }
        public long memsid { get; set; }

        [Required]
        public string TopicAns { get; set; }
        public string  AnsDate { get; set; }
        public string fname { get; set; }
        public string  gimg { get; set; }
    }
}