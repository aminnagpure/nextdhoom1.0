using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace WebApplication13.Models
{
    public class forumcat
    {
     

            public long CatID { get; set; }
            public long SubCatId { get; set; }
            [DisplayName("Title")]
            public String SubCatTitle { get; set; }
            [DisplayName("Description")]
            public string SubCatDesc { get; set; }

            public string lastupdate { get; set; }
            public long memsid { get; set; }
            public string fname { get; set; }

            public string lname { get; set; }

            public string gimg { get; set; }
            public int TopicsCount { get; set; }

            public int ReplyCount { get; set; }

    }
}