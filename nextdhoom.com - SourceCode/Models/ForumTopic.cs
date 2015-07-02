//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication13.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ForumTopic
    {
        public ForumTopic()
        {
            this.ForumTopicAnswers = new HashSet<ForumTopicAnswer>();
        }
    
        public long TopicId { get; set; }
        public string TopicTitle { get; set; }
        public string TopicDesc { get; set; }
        public long catid { get; set; }
        public long SubCatId { get; set; }
        public string UpdateCandiName { get; set; }
        public Nullable<long> UpdateCandiId { get; set; }
        public System.DateTime StartDate { get; set; }
        public Nullable<System.DateTime> UpdateDate { get; set; }
        public Nullable<long> LastAnsId { get; set; }
        public string IsApproved { get; set; }
        public long TotalView { get; set; }
        public long memsid { get; set; }
    
        public virtual ForumMainCategory ForumMainCategory { get; set; }
        public virtual ForumSubCategory ForumSubCategory { get; set; }
        public virtual Mem Mem { get; set; }
        public virtual ICollection<ForumTopicAnswer> ForumTopicAnswers { get; set; }
    }
}