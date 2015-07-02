using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.AccessControl;
using System.Web;

namespace WebApplication13.Models
{
    [MetadataType(typeof(joblistnMetaData))]
    public partial class joblistn
    {
        public class joblistnMetaData
        {

        [Required(ErrorMessage="Reguired")]
        [DisplayName("Job Category")]
        
        public short jobcategoryid { get; set; }

        [Required(ErrorMessage = "Reguired")]
        [DisplayName("Designation")]
        [StringLength(250)]
        public string designation { get; set; }

        [Required(ErrorMessage = "Reguired, you can type upto 2000 characters")]
            
        [DisplayName("Job Description")]
        [DataType(DataType.MultilineText) ]
        [DisplayFormat(DataFormatString = "{0,20}")]
        [StringLength(2000)]
        public string jobdescription { get; set; }

         [Required(ErrorMessage = "Reguired, only numeric values accepted")]
         [DisplayName("Min Exp")]
        public short minexp { get; set; }

         [Required(ErrorMessage = "Reguired, only numeric values accepted")]
         [DisplayName("Min Exp")]
         public short maxexp { get; set; }


         [Required(ErrorMessage = "Reguired")]
         [DisplayName("Salary")]
         [StringLength(50)]
         public string salary { get; set; }

         [DisplayName("Country")]
         [Required]
         public short countryid { get; set; }

         [DisplayName("State")]
         [Required]
         public short stateid { get; set; }


         [DisplayName("City")]
         [Required]
         public short cityid { get; set; }

         [Required(ErrorMessage = "Reguired")]
         [DisplayName("Contact Person")]
         
         public string contact { get; set; }

        [Required(ErrorMessage = "Required")]
         [DisplayName("Telephone")]
         
         public string telephone { get; set; }

         [Required(ErrorMessage="Required")]         
         [EmailAddress(ErrorMessage="Enter Valid Email")]
         [DisplayName("Email")]
         
         public string email { get; set; }

        
         [DisplayName("Website")]
         [Required]
         [Url(ErrorMessage="Website should start with http://www.")]
         public string website { get; set; }

         

        }


      
    }
    [MetadataType(typeof(MemMetadata))]
    public partial class Mem
    {
      
        public class MemMetadata
        {

            public long memsid { get; set; }
            public string fname { get; set; }
            public string lname { get; set; }
            public string gender { get; set; }
            public string email { get; set; }
            public string passw { get; set; }
            public long photoid { get; set; }
            public short countryid { get; set; }
            public short stateid { get; set; }
            public short cityid { get; set; }
            public string gurl { get; set; }
            public string gimg { get; set; }
            public string aboutme { get; set; }
            public string susp { get; set; }
            public DateTime? regDate { get; set; }
        }

      
    }
    [MetadataType(typeof(User_ComplaintsMetaData))]
    public partial class User_Complaints
    {
        public class User_ComplaintsMetaData
        {
            [DisplayName("Your Name")]
            [Required]
            public string UserName { get; set; }

            [DisplayName("Your Mobile")]
            [Required]
            [Phone(ErrorMessage = "Please Enter Phone Number") ]
            public string UserMobile { get; set; }

            [DisplayName("Email")]
            [Required]
            [EmailAddress(ErrorMessage = "Enter Valid Email")]
            public string EmailID { get; set; }

            [DisplayName("Subject")]
            [Required]
            public string ComplaintHead { get; set; }

            [DisplayName("Description")]
            [Required]
            public string ComplaintDesc { get; set; }
        }
    }


    public class PagedData<T> where T : class
    {
        public IEnumerable<T> Data { get; set; }
        public int NumberOfPages { get; set; }
        public int CurrentPage { get; set; }
    }
  
  
   
    public class jobsbyPaging
    {
        public List<jobbySearchnpage_Result> data { get; set; }
        public int pagesize { get; set; }
        public long TotalCount { get; set; }
        public long countryid { get; set; }
        public long cityid { get; set; }
        public long stateid { get; set; }

        public long jobcategoryid { get; set; }
        public Country country { get; set; }
        public citytable city { get; set; }
        public state state { get; set; }

        public jobcategory jobcategory { get; set; }
    }

    public class membsrebySearching
    {
        public List<memberbySearch_Result> data { get; set; }
        public int pagesize { get; set; }
        public long TotalCount { get; set; }
      
        public string byday { get; set; }
        public string searchText { get; set; }
     
    }
   
}