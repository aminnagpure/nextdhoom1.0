using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class getForum
    {
        public getForum()
        {
            this.ForumSubCategories = new HashSet<ForumSubCategory>();
            //this.ForumMainCategory = new HashSet<ForumMainCategory>();
            this.ForumTopics = new HashSet<ForumTopic>();
        }
        public long catid { get; set; }
        public string Category { get; set; }
        public string descrip { get; set; }
        public long SubCatId { get; set; }
        public string SubCatTitle { get; set; }
        public Nullable<long> UpdatedBy { get; set; }
        public Nullable<long> LastTopic { get; set; }
        public string SubCatDesc { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime lastupdate { get; set; }
        public string TopicTitle { get; set; }
        public Nullable<long> memsid { get; set; }
        public string fname { get; set; }
        public string lname { get; set; }
        public string photo { get; set; }
        public string photopassw { get; set; }
        public string UpdatedByName { get; set; }
        public string TopicsCount { get; set; }
        public string ReplyCount { get; set; }

        public virtual Mem Mem { get; set; }
        public virtual ForumMainCategory ForumMainCategory { get; set; }
        public virtual ICollection<ForumSubCategory> ForumSubCategories { get; set; }
        public virtual ICollection<ForumTopic> ForumTopics { get; set; }
    }
}