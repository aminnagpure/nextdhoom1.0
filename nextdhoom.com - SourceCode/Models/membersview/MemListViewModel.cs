using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace WebApplication13.Models.membersview
{
    public class MemListViewModel
    {
        public string fname{get;set;}
        public string lname { get; set; }

        public string gurl { get; set; }
        public string gimg { get; set; }
        public string aboutme { get; set; }
        public string countryname { get; set; }
        public string statename { get; set; }
        public string cityname { get; set; }
        public long memsid { get; set; }
    }
    public class ViewEditRegi
    {
        [Required]
        [DisplayName("First name")]
        [StringLength(50)]
        public string fname { get; set; }
        [Required]
        [DisplayName("Surname")]
        [StringLength(50)]
        public string lname { get; set; }

        [Required]
        [DisplayName("Gender")]
        [StringLength(1)]
        public string Gender { get; set; }
        [StringLength(50)]
        [DisplayName("Email")]
        public string email { get; set; }
        [Required]
        [DisplayName("Password")]
        [StringLength(50)]
        public string passw { get; set; }

        [Required]
        [DisplayName("Country")]
       
        public short countryid { get; set; }

        [Required]
        [DisplayName("State")]
       
        public short stateid { get; set; }

        [Required]
        [DisplayName("City")]
       
        public short cityid { get; set; }
        [Required]
        [DisplayName("About Me")]
        [StringLength(1050)]
        public string aboutme { get; set; }
        [DisplayName("Looking for Job")]
        public string isJobseeker { get; set; }

        [DisplayName("Designation")]
        public string designation { get; set; }

        [DisplayName("Job category")]

        public Nullable<short> jobcategoryid { get; set; }
        
    }
    public class ViewProfilemem
    {
        public string fname { get; set; }
        public string lname { get; set; }
        public string country { get; set; }
    }

}