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
    
    public partial class joblistn
    {
        public long Jobid { get; set; }
        public long memsid { get; set; }
        public short jobcategoryid { get; set; }
        public System.DateTime sysentrydate { get; set; }
        public string designation { get; set; }
        public string jobdescription { get; set; }
        public short minexp { get; set; }
        public short maxexp { get; set; }
        public string salary { get; set; }
        public short countryid { get; set; }
        public short stateid { get; set; }
        public short cityid { get; set; }
        public string contact { get; set; }
        public string telephone { get; set; }
        public string email { get; set; }
        public string website { get; set; }
        public string isApproved { get; set; }
    
        public virtual citytable citytable { get; set; }
        public virtual Country Country { get; set; }
        public virtual jobcategory jobcategory { get; set; }
        public virtual Mem Mem { get; set; }
        public virtual state state { get; set; }
    }
}
