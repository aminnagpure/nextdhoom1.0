using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;


using System.Data.Entity.Core.Objects;

namespace WebApplication13.Controllers
{
    [Authorize]
    public class JobsController : Controller
    {
        private nextdhoomEntities db = new nextdhoomEntities();

        // GET: /Jobs/
        public ActionResult Index(int? page, jobsbyPaging jp)
        {
            int currentPageIndex = page.HasValue ? page.Value : 1;
            string criteria = "";
           
            criteria = "joblistn.isApproved = 'Y' ";

            System.Data.Entity.Core.Objects.ObjectParameter Count = new System.Data.Entity.Core.Objects.ObjectParameter("Count", typeof(int));
            // output = 0;


            jp.data = db.jobbySearchnpage(currentPageIndex, defaultPageSize, criteria, Count).ToList();

            jp.pagesize = defaultPageSize;

            jp.TotalCount = Convert.ToInt64(Count.Value);

            return View(jp);
            
        }

        // GET: /Jobs/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            joblistn joblistn = db.joblistns.Find(id);
            if (joblistn == null)
            {
                return HttpNotFound();
            }
            return View(joblistn);
        }

        // GET: /Jobs/Create
        public ActionResult Create()
        {
            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname");
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category");
            //ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname");
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename");
            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname");
            return View();
        }

        public ActionResult ManageJobs(int? page, jobsbyPaging jp)
        {
            int currentPageIndex = page.HasValue ? page.Value : 1;
            string criteria = "";
            long id;
            id = Convert.ToInt32(Request.Cookies["memsid"].Value);
            criteria = "joblistn.isApproved = 'Y' And   joblistn.memsid="+id  ;

            System.Data.Entity.Core.Objects.ObjectParameter Count = new System.Data.Entity.Core.Objects.ObjectParameter("Count", typeof(int));
            // output = 0;
           

            jp.data = db.jobbySearchnpage(currentPageIndex, defaultPageSize, criteria, Count).ToList();

            jp.pagesize = defaultPageSize;

            jp.TotalCount = Convert.ToInt64(Count.Value);

            return View(jp);
            
          }


        // POST: /Jobs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Jobid,memsid,jobcategoryid,sysentrydate,designation,jobdescription,minexp,maxexp,salary,countryid,stateid,cityid,contact,telephone,email,website")] joblistn joblistn)
        {
            joblistn jb = new joblistn();

            long kk;
            if (ModelState.IsValid)
            {
                try
                {
                    //joblistn.jobdescription=joblistn.jobdescription.Replace()
                    long memid = Convert.ToInt64(Request.Cookies["memsid"].Value);
                    
                    joblistn.sysentrydate = System.DateTime.Now;
                    var cnt = db.joblistns.Where(c => c.memsid == memid && c.isApproved == "Y").Count();

                    if (cnt > 10)
                    {
                        joblistn.isApproved = "Y";
                    }
                    else
                    { joblistn.isApproved = "N"; }


                    db.joblistns.Add(joblistn);
                    db.SaveChanges();
                    kk = joblistn.Jobid;

                    ModelState.Clear();
                    ViewBag.success = true;
                    ViewBag.Message = "Job Posted Successfully";

                    //return RedirectToAction("Index");
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
                    ViewBag.success = false;
                    ViewBag.Message = "Unable to post job";
                    return View(joblistn);
                }
            }
            else
            {
                ViewBag.success = false;
                ViewBag.Message = "Unable to post job";
                ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", joblistn.jobcategoryid);
                //ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", joblistn.memsid);

                ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", joblistn.countryid);
                ViewBag.stateid = new SelectList(db.states, "stateid", "statename", joblistn.stateid);
                ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", joblistn.cityid);
                return View(joblistn);
            }


            //ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", joblistn.jobcategoryid);
            ////ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", joblistn.memsid);

            //ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", joblistn.countryid);
            //ViewBag.stateid = new SelectList(db.states, "stateid", "statename", joblistn.stateid);
            //ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", joblistn.cityid);
            //return View(jb);

            return RedirectToAction("Details", "Jobs", new {id=kk });

        }

        // GET: /Jobs/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            joblistn joblistn = db.joblistns.Find(id);
            if (joblistn == null)
            {
                return HttpNotFound();
            }
            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", joblistn.cityid);
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", joblistn.jobcategoryid);
            // ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", joblistn.memsid);
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename", joblistn.stateid);
            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", joblistn.countryid);
            joblistn.memsid = Convert.ToInt64(Request.Cookies["memsid"].Value);
            return View(joblistn);
        }

        // POST: /Jobs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Jobid,memsid,jobcategoryid,sysentrydate,designation,jobdescription,minexp,maxexp,salary,countryid,stateid,cityid,contact,telephone,email,website")] joblistn joblistn)
        {
            if (ModelState.IsValid)
            {
                string app = db.joblistns.Where(c => c.Jobid == joblistn.Jobid).Select(c => c.isApproved).FirstOrDefault();
                joblistn.isApproved = app;
                db.Entry(joblistn).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", joblistn.cityid);
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category", joblistn.jobcategoryid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", joblistn.memsid);
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename", joblistn.stateid);
            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", joblistn.countryid);
            return View(joblistn);
        }

        // GET: /Jobs/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            joblistn joblistn = db.joblistns.Find(id);
            if (joblistn == null)
            {
                return HttpNotFound();
            }
            return View(joblistn);
        }

        // POST: /Jobs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            joblistn joblistn = db.joblistns.Find(id);
            db.joblistns.Remove(joblistn);
            db.SaveChanges();
            return RedirectToAction("ManageJobs");
        }



        private const int defaultPageSize = 10;
        public ActionResult SearchJobs(int? page, jobsbyPaging jp)
        {
            int currentPageIndex = page.HasValue ? page.Value : 1;
            string criteria = "";
            string country = "";
            string city = "";
            string state = "";
            string category = "";

            if (jp.countryid > 0)
            {
                country = " AND joblistn.countryid=" + jp.countryid;
            }
            if (jp.stateid > 0)
            {
                state = " AND joblistn.stateid=" + jp.stateid;
            }
            if (jp.cityid > 0)
            {
                city = " AND joblistn.cityid=" + jp.cityid;
            }
            if (jp.jobcategoryid > 0)
            {
                category = " AND joblistn.jobcategoryid=" + jp.jobcategoryid;
            }

            criteria = "joblistn.isApproved = 'Y'  " + city + country + state + category ;

            System.Data.Entity.Core.Objects.ObjectParameter Count = new System.Data.Entity.Core.Objects.ObjectParameter("Count", typeof(int));
            // output = 0;

            jp.data = db.jobbySearchnpage(currentPageIndex, defaultPageSize, criteria, Count).ToList();

            jp.pagesize = defaultPageSize;

            jp.TotalCount = Convert.ToInt64(Count.Value);

            // members = mm.OrderByDescending(p => p.pid).ToPagedList(currentPageIndex, defaultPageSize);

            ViewBag.cityid = new SelectList(db.citytables, "cityid", "cityname", ViewData["cityid"]);
            ViewBag.countryid = new SelectList(db.Countries, "COUNTRYID", "countryname", ViewData["countryid"]);
            ViewBag.stateid = new SelectList(db.states, "stateid", "statename", ViewData["stateid"]);
            ViewBag.jobcategoryid = new SelectList(db.jobcategories, "jobcategoryid", "category");

            return View(jp);
            
        }

        public ActionResult Sharethisjob()
        {

            return View();
        }



        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }

}