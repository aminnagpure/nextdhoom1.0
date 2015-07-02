
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebApplication13.Models;
using WebApplication13.Models.membersview;


namespace WebApplication13.Controllers
{

    [Authorize]

    
    public class MembersController : Controller
    {
        //
        
        nextdhoomEntities db = new nextdhoomEntities();
        //ChatHub hubby=new ChatHub();
    
        // GET: /Members/
        public ActionResult Index()
        {
            var mod = from r in db.Mems.Take(10)
                      orderby r.memsid descending
                      select new MemListViewModel
                      {
                          fname = r.fname,
                          lname = r.lname,
                          gimg = r.gimg,
                          aboutme=r.aboutme,
                          countryname=r.Country.countryname,
                          statename=r.state.statename,
                          cityname=r.citytable.cityname,
                          memsid=r.memsid

                      };         

            return View(mod);
            
        }

    

        [HttpGet]
        public ActionResult Edit()
        {
            long id = 0;
            

            
            id = Convert.ToInt32(Request.Cookies["memsid"].Value);
            var kk = (from u in db.Mems where u.memsid.Equals(id) select u).FirstOrDefault();

            var abc = new ViewEditRegi
            {
                fname = kk.fname,
                lname = kk.lname,
                Gender=kk.gender,
                email=kk.email,
                passw=kk.passw,
                countryid = kk.Country.COUNTRYID,
                stateid=kk.state.stateid,
                cityid=kk.citytable.cityid,
                aboutme=kk.aboutme,
                isJobseeker = kk.isJobseeker ,
                jobcategoryid = kk.jobcategoryid ,
                designation = kk.designation 

            };

            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", kk.countryid);
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename", kk.stateid);
            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", kk.cityid);
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", kk.jobcategoryid);

             return View(abc);
        }

        [HttpPost]
        public ActionResult Edit(ViewEditRegi mm)
        {
            if(ModelState.IsValid)
            {
               // db.Entry(mm).State = EntityState.Modified;
                
                

                try
                {
                    var fname = mm.fname; //mm["fname"];
                    var lname =mm.lname;// mm["lname"];
                    var gender =mm.Gender; //mm["gender"];
                    var email =mm.email; //mm["email"];
                    var passw =mm.passw; //mm["passw"];
                    short countryid =mm.countryid; //Convert.ToInt16(mm["Country"]);
                    short State =mm.stateid; //Convert.ToInt16(mm["State"]);
                    short city = mm.cityid;//Convert.ToInt16(mm["city"]);
                    var aboutme = mm.aboutme;
                    var jobcatgoryid = mm.jobcategoryid;
                    var designation = mm.designation;
                    var isjobseeker = mm.isJobseeker;

                    db.Editmem(Convert.ToInt32(Request.Cookies["memsid"].Value), fname, lname, passw, gender, countryid, State, city, aboutme, isjobseeker, jobcatgoryid, designation);

                    
                }
                catch (DbEntityValidationException ex)
                {


                    // Retrieve the error messages as a list of strings.
                    var errorMessages = ex.EntityValidationErrors
                            .SelectMany(x => x.ValidationErrors)
                            .Select(x => x.ErrorMessage);

                    // Join the list to a single string.
                    var fullErrorMessage = string.Join("; ", errorMessages);

                    // Combine the original exception message with the new one.
                    var exceptionMessage = string.Concat(ex.Message, " The validation errors are: ", fullErrorMessage);

                    // Throw a new DbEntityValidationException with the improved exception message.
                    throw new DbEntityValidationException(exceptionMessage, ex.EntityValidationErrors);
                }
                return RedirectToAction("index");
            }
            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname",mm.countryid);
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename",mm.stateid);
            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname",mm.cityid);
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", mm.jobcategoryid);

            return View(mm);
        }
        public ActionResult Chat()
        {
          

                      

            return View();

        }
        
        public ActionResult Vchat()
        {
           

            return View();
        }

        public ActionResult LogOff()
        {
            

            HttpCookie memsid = new HttpCookie("memsid");
            memsid.Expires = DateTime.Now.AddDays(-1);  
            memsid.Value = "";
            Response.Cookies.Add(memsid);

            HttpCookie fname = new HttpCookie("fname");
            fname.Value = "";

            HttpCookie lname = new HttpCookie("lname");
            lname.Value = "";

            FormsAuthentication.SignOut();
            
            return RedirectToAction("Index", "Home");
        }
       
        
        public ActionResult ViewProfile(long id)
        {
            //id = Convert.ToInt32(Request.Cookies["memsid"].Value); // (long)Session["memsid"];


            var kk = db.Mems.Find(id);

                              
                
            return View(kk);
            //var dd=new ViewProfilemem();

            

        }
        
        public ActionResult GroupVideo()
        {
            return View();
        }
        public ActionResult GroupVideoPvt()
        {
            return View();
        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
	}
}