using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class ViewTopicModel
    {
        public long TopicId { get; set; }
        public long CatId { get; set; }
        public long SubCatId { get; set; }
        public long LastAnsId { get; set; }
        public long memsid { get; set; }
        public string TopicTitle { get; set; }
        public string TopicDesc { get; set; }
        public string fname { get; set; }
        public string StartDate { get; set; }
        public string  UpdateCandiId { get; set; }
        public string UpdateDate { get; set; }
        public string UpdateCandiName { get; set; }
        public string Photo { get; set; }
        public int TotalReplay { get; set; }
        public int TotalThread { get; set; }
    }
}