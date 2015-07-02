using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;

namespace WebApplication13.Controllers
{
    public class KasController : Controller
    {
        private nextdhoomEntities db = new nextdhoomEntities();
        // GET: /Kas/

        public JsonResult contrieslist()
        {
            var contry = from s in db.Countries                        
                        select s;
            return Json(new SelectList(contry.ToArray(), "countryid", "countryname"), JsonRequestBehavior.AllowGet);
        }
        public JsonResult StateList(int Id)
        {
            var state = from s in db.states
                        where s.countryid == Id
                        select s;
            return Json(new SelectList(state.ToArray(), "StateId", "StateName"), JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public JsonResult StList(int id)
        {
            var states = db.states.Where(s => s.countryid == id).ToList();
            var st = states.Select(x => new
                {
                    stateid = x.stateid,
                    StateName = x.statename
                });
            return Json(st, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Citylist(int id)
        {
            var city = from c in db.citytables
                       where c.stateid == id
                       select c;
            return Json(new SelectList(city.ToArray(), "CityId", "CityName"), JsonRequestBehavior.AllowGet);
        
        }
        [HttpGet]
        public JsonResult ctList(int id)
        {
            var city = db.citytables.Where(s => s.stateid == id).ToList();
            var ct = city.Select(x => new
            {
                cityid = x.cityid,
                cityname = x.cityname 
            });
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
        public IList<state> Getstate(int CountryId)
        {
            return db.states.Where(m => m.countryid == CountryId).ToList();
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public JsonResult LoadClassesByCountryId(string CountryName)
        {
            var stateList = this.Getstate(Convert.ToInt32(CountryName));
            var stateData = stateList.Select(m => new SelectListItem()
            {
                Text = m.statename,
                Value = m.countryid.ToString(),
            });
            return Json(stateData, JsonRequestBehavior.AllowGet);
        }

        //public JsonResult ClsCatList()
        //{
        //    var category = from s in db.classified_category 
        //                 select s;
        //    return Json(new SelectList(category.ToArray(), "catid", "category"), JsonRequestBehavior.AllowGet);
        //}
        //public JsonResult clsSucatList(int Id)
        //{
        //    var subcat = from s in db.classified_SubCategory 
        //                where s.catid == Id
        //                select s;
        //    return Json(new SelectList(subcat.ToArray(), "subcatid", "subcategory"), JsonRequestBehavior.AllowGet);
        //}
        //public JsonResult clsModelList(int id)
        //{
        //    var model = from c in db.classified_models 
        //               where c.subcatid == id
        //               select c;
        //    return Json(new SelectList(model.ToArray(), "modelID", "model"), JsonRequestBehavior.AllowGet);
        //}

	}
}