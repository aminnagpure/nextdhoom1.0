using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplication13.Models.membersview
{
    public class MailModel
    {
        [Required(ErrorMessage = "Required")]
        [EmailAddress(ErrorMessage = "Enter Valid Email")]
        [DisplayName("Your Email")]
        
        public string From { get; set; }
        public string To { get; set; }

        [Required(ErrorMessage = "Required")]
        public string Subject { get; set; }
        [Required(ErrorMessage = "Required")]
        public string Body { get; set; }

    }
}