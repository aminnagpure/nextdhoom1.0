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
    
    public partial class Jokescatmaster
    {
        public Jokescatmaster()
        {
            this.tbl_Jokes = new HashSet<tbl_Jokes>();
            this.tbl_Jokes1 = new HashSet<tbl_Jokes>();
        }
    
        public int catid { get; set; }
        public string category { get; set; }
    
        public virtual ICollection<tbl_Jokes> tbl_Jokes { get; set; }
        public virtual ICollection<tbl_Jokes> tbl_Jokes1 { get; set; }
    }
}