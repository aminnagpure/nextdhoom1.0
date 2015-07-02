using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;

namespace WebApplication13.Controllers
{
    public class JokesController : Controller
    {
        private nextdhoomEntities db = new nextdhoomEntities();

        // GET: /Jokes/
        public ActionResult Index()
        {
            var tbl_jokes = db.tbl_Jokes.Include(t => t.Jokescatmaster).Include(t => t.Jokescatmaster1).Include(t => t.Mem).Include(t => t.Mem1).Include(t => t.Mem2);
            return View(tbl_jokes.ToList());
        }

        // GET: /Jokes/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_Jokes tbl_jokes = db.tbl_Jokes.Find(id);
            if (tbl_jokes == null)
            {
                return HttpNotFound();
            }
            return View(tbl_jokes);
        }

        // GET: /Jokes/Create
        public ActionResult Create()
        {
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category");
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category");
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname");
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname");
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname");
            return View();
        }

        // POST: /Jokes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="Jokesid,memsid,Jokesdate,Jokessub,JokesDesc,Jokespic,ipaddress,IsApproved,categoryId,TotalView")] tbl_Jokes tbl_jokes)
        {
            if (ModelState.IsValid)
            {
                db.tbl_Jokes.Add(tbl_jokes);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            return View(tbl_jokes);
        }

        // GET: /Jokes/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_Jokes tbl_jokes = db.tbl_Jokes.Find(id);
            if (tbl_jokes == null)
            {
                return HttpNotFound();
            }
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            return View(tbl_jokes);
        }

        // POST: /Jokes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="Jokesid,memsid,Jokesdate,Jokessub,JokesDesc,Jokespic,ipaddress,IsApproved,categoryId,TotalView")] tbl_Jokes tbl_jokes)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_jokes).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.categoryId = new SelectList(db.Jokescatmasters, "catid", "category", tbl_jokes.categoryId);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            ViewBag.memsid = new SelectList(db.Mems, "memsid", "fname", tbl_jokes.memsid);
            return View(tbl_jokes);
        }

        // GET: /Jokes/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_Jokes tbl_jokes = db.tbl_Jokes.Find(id);
            if (tbl_jokes == null)
            {
                return HttpNotFound();
            }
            return View(tbl_jokes);
        }

        // POST: /Jokes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            tbl_Jokes tbl_jokes = db.tbl_Jokes.Find(id);
            db.tbl_Jokes.Remove(tbl_jokes);
            db.SaveChanges();
            return RedirectToAction("Index");
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
