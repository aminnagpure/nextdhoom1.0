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
    
    public partial class User_Complaints_VerifyUser_Result
    {
        public long ComplaintID { get; set; }
        public string UserMobile { get; set; }
        public string EmailID { get; set; }
        public string UserName { get; set; }
        public string ComplaintHead { get; set; }
        public string ComplaintDesc { get; set; }
        public System.DateTime ComplaintDate { get; set; }
        public string IsResolved { get; set; }
        public Nullable<System.DateTime> ResolvedDate { get; set; }
        public long ResolvedBy { get; set; }
        public string ResolvedByName { get; set; }
    }
}