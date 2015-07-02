using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication13.Controllers
{
    public class classifiedsController : Controller
    {
        //
        // GET: /classifieds/
        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /classifieds/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /classifieds/Create
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /classifieds/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /classifieds/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /classifieds/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /classifieds/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /classifieds/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
