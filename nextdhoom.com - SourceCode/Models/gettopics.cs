using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class gettopics
    {
        public gettopics()
        {
            this.ForumSubCategories = new HashSet<ForumSubCategory>();
            this.ForumMainCategory = new HashSet<ForumMainCategory>();
            this.ForumTopics = new HashSet<ForumTopic>();
            this.ForumTopicAnsers = new HashSet<ForumTopicAnswer>();
        }
        public long TopicId { get; set; }
        public long CatId { get; set; }
        public long memsid { get; set; }
        public string TopicTitle { get; set; }
        public string fname { get; set; }
        public string starteddate { get; set; }
        public string UpdateCandiId { get; set; }
        public string updatedate { get; set; }
        public string UpdateCandiName { get; set; }
        public string Photo { get; set; }
        public int rowid { get; set; }
        public int ReplayCount { get; set; }
        public virtual Mem Mem { get; set; }
        public virtual ICollection<ForumMainCategory> ForumMainCategory { get; set; }
        public virtual ICollection<ForumSubCategory> ForumSubCategories { get; set; }
        public virtual ICollection<ForumTopic> ForumTopics { get; set; }

        public virtual ICollection<ForumTopicAnswer> ForumTopicAnsers { get; set; } 
    }
}