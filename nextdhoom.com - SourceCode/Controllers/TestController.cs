using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;

namespace WebApplication13.Controllers
{
    public class TestController : Controller
    {
        private nextdhoomEntities db = new nextdhoomEntities();
        //
        // GET: /Test/
        public ActionResult Index()
        {
            ViewBag.CountryId = new SelectList(db.Countries, "CountryId", "CountryName");
            return View();
        }

        public ActionResult contrylist()
        {
            var objA = db.Countries.ToList();
            
            return PartialView(objA);
        }
	}
}