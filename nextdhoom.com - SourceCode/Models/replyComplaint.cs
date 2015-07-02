using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class replyComplaint
    {
        public User_Complaints  user_complaints { get; set; }
        public User_Complaints_Comments user_complaints_comments { get; set; }

        public List<User_Complaints_Comments> replyComments { get; set; }
    }
}