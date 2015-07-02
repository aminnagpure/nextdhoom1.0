using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SignalRChat.Common
{
    public class UserDetail
    {
        public string ConnectionId { get; set; }
        public string UserName { get; set; }
        public long memsid { get; set; }

        public string gimg { get; set; }
    }
}