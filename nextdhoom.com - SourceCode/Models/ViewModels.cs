using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    
    public class LoginView
    {
        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "User Email")]
        public string email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Passw { get; set; }

       
    }

 
}