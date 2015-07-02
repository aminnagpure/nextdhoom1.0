using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models.membersview
{
    public class Invite
    {
        [Required(ErrorMessage = "Required")]
        [EmailAddress(ErrorMessage = "Enter Valid Email")]
        [DisplayName("Your Email")]
        
        public string email { get; set; }
    }
}