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
    
    public partial class ForumSubCategory
    {
        public ForumSubCategory()
        {
            this.ForumTopics = new HashSet<ForumTopic>();
        }
    
        public long SubCatId { get; set; }
        public long CatId { get; set; }
        public string SubCatTitle { get; set; }
        public string SubCatDesc { get; set; }
        public long StartedBy { get; set; }
        public Nullable<long> UpdatedBy { get; set; }
        public Nullable<long> LastTopic { get; set; }
        public System.DateTime StartDate { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public string IsApprover { get; set; }
        public long TotalView { get; set; }
        public long memsid { get; set; }
    
        public virtual ForumMainCategory ForumMainCategory { get; set; }
        public virtual Mem Mem { get; set; }
        public virtual ICollection<ForumTopic> ForumTopics { get; set; }
    }
}
