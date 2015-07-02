using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;

namespace WebApplication13.Controllers
{
    [Authorize]
    public class AdminController : Controller
    {

        private nextdhoomEntities db = new nextdhoomEntities();
        //
        // GET: /ContentManage/
        public ActionResult Index()
        {
            if (Request.Cookies["memsid"].Value == "14")
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        #region[Forum moderators]
        // Insert : /ContentManage/InsertCategory/
        [HttpGet]
        public ActionResult InsertCategory()
        {

            if (Request.Cookies["memsid"].Value == "14")
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        [HttpPost]
        public ActionResult InsertCategory(ForumMainCategory maincat)
        {
            if (Request.Cookies["memsid"].Value == "14")
            {
                long memid = Convert.ToInt64(Request.Cookies["memsid"].Value);
                if (maincat.Category != null || maincat.descrip != null)
                {
                    System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("rowEffect", typeof(int));
                    db.ForumAddCategory(maincat.Category, maincat.descrip, memid, output, System.DateTime.Now);

                    int i = Convert.ToInt32(output.Value);
                    if (i > 0)
                    {
                        ViewBag.Success = true;
                        ViewBag.message = "Category Added Successfully";
                    }
                    else if (i == -2)
                    {
                        ViewBag.Success = false;
                        ViewBag.message = maincat.Category + " Allredy Exist Please add new Category";
                    }
                    else
                    {
                        ViewBag.Success = false;
                        ViewBag.message = "Unable to add Category";
                    }
                }
                else
                {
                    ViewBag.Success = false;
                    ViewBag.message = "Unable to add Category";
                }
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        [HttpGet]
        public ActionResult InsertSubCategory()
        {
            if (Request.Cookies["memsid"].Value == "14")
            {
                var catlist = (from d in db.ForumMainCategories
                               select new
                               {
                                   d.catid,
                                   d.Category
                               });
                var x = catlist.ToList().Select(c => new SelectListItem
                            {
                                Text = c.Category,
                                Value = c.catid.ToString()

                            }).ToList();
                ViewBag.category = x;
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }
        [HttpPost]
        public ActionResult InsertSubCategory(ForumSubCategory subcat)
        {
            if (Request.Cookies["memsid"].Value == "14")
            {


                long memsid = Convert.ToInt64(Request.Cookies["memsid"].Value);
                subcat.StartDate = System.DateTime.Now;
                subcat.StartedBy = Convert.ToInt64(Request.Cookies["memsid"].Value);

                if (subcat.SubCatTitle != null && subcat.SubCatDesc != null)
                {
                    System.Data.Entity.Core.Objects.ObjectParameter output = new System.Data.Entity.Core.Objects.ObjectParameter("rowEffect", typeof(int));
                    db.forumInsertSubCat(subcat.CatId, subcat.SubCatTitle, subcat.SubCatDesc, System.DateTime.Now, memsid, memsid, output);
                    //db.ForumSubCategories.Add(subcat);
                    //i = db.SaveChanges();
                    int i = Convert.ToInt32(output.Value);


                    if (i > 0)
                    {
                        ViewBag.Success = true;
                        ViewBag.message = "sub category Added Succsessfully";
                    }
                    else if (i == -2)
                    {
                        ViewBag.Success = false;
                        ViewBag.message = subcat.SubCatTitle + " Allredy Exist Please add new SubCategory";
                    }
                    else
                    {
                        ViewBag.Success = false;
                        ViewBag.message = "Unable to add SubCategory";
                    }
                }
                else
                {
                    ViewBag.Success = false;
                    ViewBag.message = "Unable to add SubCategory";
                }
                var catlist = (from d in db.ForumMainCategories
                               select new
                               {
                                   d.catid,
                                   d.Category
                               });
                var x = catlist.ToList().Select(c => new SelectListItem
                {
                    Text = c.Category,
                    Value = c.catid.ToString()

                }).ToList();
                ViewBag.category = x;
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }

        public ActionResult ViewUnAproveTopic(int? id, int? i)
        {
            var gettopic = (from ft in db.ForumTopics
                            join me in db.Mems on ft.memsid equals me.memsid
                            where ft.IsApproved == "N"
                            select new ViewTopicModel
                            {
                                TopicId = ft.TopicId,
                                TopicDesc = ft.TopicDesc,
                                TopicTitle = ft.TopicTitle,
                                fname = me.fname,
                                Photo = me.gimg,
                                SubCatId = ft.SubCatId,
                                memsid = ft.memsid,
                                StartDate = ft.StartDate.ToString(),


                            }).ToList();

            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Topic Is Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Approve";
            }
            if (i > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Topic Is deleted";
            }
            else if (i == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to delete";
            }

            return View(gettopic);
        }

        public ActionResult deleTopic(long id)
        {
            int i = -1;
            i = db.forumdeleteTopic(id);

            return RedirectToAction("ViewUnAproveTopic", new { i = i });
        }

        public ActionResult DeleAns(long id)
        {
            int i = -1;
            i = db.ForumdeleteAnswer(id);

            return RedirectToAction("ViewUnAprovedAnswer", new { i = i });
        }
        public ActionResult AproveTopic(long id)
        {
            int i = -1;

            i = db.ForumAproveTopic(id);



            return RedirectToAction("ViewUnAproveTopic", new { id = i });

        }

        public const int PageSize = 10;


        public ActionResult searchTp(int? id, String searchtext = null, int page = 1)
        {
            var topic = new PagedData<ViewTopicModel>();
            topic.Data = (from ft in db.ForumTopics
                          join me in db.Mems on ft.memsid equals me.memsid
                          where (ft.IsApproved == "Y") &&
                          (ft.TopicDesc.Contains(searchtext) || ft.TopicTitle.Contains(searchtext) || me.fname.Contains(searchtext))
                          orderby ft.StartDate
                          select new ViewTopicModel
                          {
                              TopicId = ft.TopicId,
                              TopicDesc = ft.TopicDesc,
                              TopicTitle = ft.TopicTitle,
                              fname = me.fname,
                              Photo = me.gimg,
                              SubCatId = ft.SubCatId,
                              memsid = ft.memsid,
                              StartDate = ft.StartDate.ToString(),

                          }).Skip(PageSize * (page - 1)).Take(PageSize).Distinct().ToList();

            topic.NumberOfPages = Convert.ToInt32(Math.Ceiling((double)db.ForumTopics.Where(c => (c.IsApproved == "Y")
                &&
                          (c.TopicDesc.Contains(searchtext) || c.TopicTitle.Contains(searchtext) || c.Mem.fname.Contains(searchtext))
            ).Distinct().Count() / PageSize));
            topic.CurrentPage = page;


            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Topic Is Un Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Un Approve";
            }
            return View("ViewAprovedTopics", topic);
        }

        public ActionResult ViewAprovedTopics(int? id, int page = 1)
        {
            var topic = new PagedData<ViewTopicModel>();
            topic.Data = (from ft in db.ForumTopics
                          join me in db.Mems on ft.memsid equals me.memsid
                          where ft.IsApproved == "Y"
                          orderby ft.StartDate
                          select new ViewTopicModel
                          {
                              TopicId = ft.TopicId,
                              TopicDesc = ft.TopicDesc,
                              TopicTitle = ft.TopicTitle,
                              fname = me.fname,
                              Photo = me.gimg,
                              SubCatId = ft.SubCatId,
                              memsid = ft.memsid,
                              StartDate = ft.StartDate.ToString(),

                          }).Skip(PageSize * (page - 1)).Take(PageSize).ToList();

            topic.NumberOfPages = Convert.ToInt32(Math.Ceiling((double)db.ForumTopics.Where(c => c.IsApproved == "Y").Count() / PageSize));
            topic.CurrentPage = page;


            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Topic Is Un Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Un Approve";
            }
            return View(topic);
        }

        public ActionResult UnAproveTopic(long id)
        {
            int i = -1;

            i = db.ForumUnAproveTopic(id);

            //if (i > 0)
            //{
            //    return RedirectToAction("ViewUnAproveTopic");
            //}

            return RedirectToAction("ViewAprovedTopics", new { id = i });

        }


        public ActionResult ViewUnAprovedAnswer(int? id, int? i)
        {
            var topicAnswers = (from fta in db.ForumTopicAnswers
                                join me in db.Mems on fta.memsid equals me.memsid
                                where fta.IsApproved == "N"
                                orderby fta.AnsDate
                                select new TopicAnsModel
                                {
                                    TopicAns = fta.TopicAns,
                                    TopicId = fta.TopicId,
                                    AnsId = fta.AnsId,
                                    gimg = me.gimg,
                                    fname = me.fname,
                                    memsid = fta.memsid,
                                    AnsDate = fta.AnsDate.ToString()
                                }).ToList();
            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Reply Is Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Approve";
            }
            if (i > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Reply Is Deleted";
            }
            else if (i == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Delete";
            }
            return View(topicAnswers);
        }
        public ActionResult ViewAprovedAnswer(int? id)
        {
            var topicAnswers = (from fta in db.ForumTopicAnswers
                                join me in db.Mems on fta.memsid equals me.memsid
                                where fta.IsApproved == "Y"
                                orderby fta.AnsDate
                                select new TopicAnsModel
                                {
                                    TopicAns = fta.TopicAns,
                                    TopicId = fta.TopicId,
                                    AnsId = fta.AnsId,
                                    gimg = me.gimg,
                                    fname = me.fname,
                                    memsid = fta.memsid,
                                    AnsDate = fta.AnsDate.ToString()
                                }).ToList();
            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Answer Is Un Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Un Approve";
            }
            return View(topicAnswers);
        }
        //UnAproveAns
        public ActionResult AproveAns(long id)
        {
            int i = -1;

            i = db.ForumAproveTopicAns(id);

            //if (i > 0)
            //{
            //    return RedirectToAction("ViewAprovedAnswer");
            //}

            return RedirectToAction("ViewUnAprovedAnswer", new { id = i });

        }

        public ActionResult UnAproveAns(long id)
        {
            int i = -1;

            i = db.ForumUnAproveTopicAns(id);

            //if (i > 0)
            //{
            //    return RedirectToAction("ViewUnAprovedAnswer");
            //}

            return RedirectToAction("ViewAprovedAnswer", new { id = i });

        }
        #endregion


        #region[Users moderator]




        private const int defaultPageSize = 10;
        public ActionResult AllMem(int? page, membsrebySearching mm)
        {
            int currentPageIndex = page.HasValue ? page.Value : 1;

            System.Data.Entity.Core.Objects.ObjectParameter Count = new System.Data.Entity.Core.Objects.ObjectParameter("Count", typeof(int));
            string searchData = "";
            string criteria = "";
            string bydate = "";
            if(!string.IsNullOrEmpty(mm.searchText) )
            {
                searchData = " And ( .fname like '%" + mm.searchText + "' OR mems.lname like '%" + mm.searchText + "' OR mems.aboutme like '%" + mm.searchText + "')";
            }
            if(!string.IsNullOrEmpty(mm.byday))
            {
                if(mm.byday == "Today")
                {
                    bydate = " And convert(date,mems.regdate) = convert(date,getdate())";
                }
                else if (mm.byday == "Yesterday")
                {
                    bydate = " And convert(date,mems.regdate) = convert(date,getdate()-1)";
                }
                else if (mm.byday == "LastWeek")
                {
                    bydate = " And convert(date,mems.regdate) between convert(date,getdate()-7) and convert(date,getdate())";
                }
            }

            criteria = "mems.Susp= 'N' " + bydate + searchData;
            mm.data = db.memberbySearch(currentPageIndex, defaultPageSize, criteria , Count).ToList();

            mm.TotalCount =Convert.ToInt64(Count.Value);

            mm.pagesize = defaultPageSize;

            return PartialView(mm);

        }
        //[HttpPost]
        //public ActionResult AllMem(int? id,string criteria = "All", int page = 1)
        //{
        //    DateTime dt = DateTime.Today.Date  ; 
        //    var kk = new PagedData<Mem>();

        //    kk.Data = getFilteredData(criteria).OrderByDescending(c=> c.memsid).Skip(PageSize * (page - 1)).Take(PageSize).ToList()  ;
        //    ViewBag.count = getFilteredData(criteria).Count();
        //    kk.NumberOfPages = Convert.ToInt32(Math.Ceiling((double)getFilteredData(criteria).Count() / PageSize));
        //    kk.CurrentPage = page;

        //    return PartialView(kk);
        //}
        //public static IQueryable<Mem> getFilteredData(string criteria = "All", string searchM = null)
        //{
        //    nextdhoomEntities db = new nextdhoomEntities();
        //    IQueryable<Mem> filterMem = db.Mems;

        //    if (searchM != null)
        //    {
        //        filterMem = filterMem.Where(c => c.fname.Contains(searchM) || c.lname.Contains(searchM));
        //    }
        //    if (criteria == "All")
        //    {
        //        filterMem = filterMem.Where(c => c.susp == "N");
        //    }
        //    if (criteria == "Today")
        //    {

        //        var mm = db.Mems.AsEnumerable().Where(c => c.regDate.Value.Date == DateTime.Today.Date).ToList();
        //        filterMem = mm.AsQueryable();

        //    }
        //    else if (criteria == "Yesterday")
        //    {
        //        var mm = db.Mems.AsEnumerable().Where(c => c.regDate.Value.Date == DateTime.Now.AddDays(-1).Date).ToList();
        //        filterMem = mm.AsQueryable();

        //    }
        //    else if (criteria == "week")
        //    {
        //        var mm = db.Mems.AsEnumerable().Where(c => c.regDate.Value.Date > DateTime.Now.AddDays(-7).Date && c.regDate < DateTime.Today.Date).ToList();
        //        filterMem = mm.AsQueryable();
        //    }


        //    return filterMem;
        //}

        public ActionResult ViewSuspMem()
        {
            var kk = db.Mems.Where(c => c.susp == "Y").ToList();



            return View(kk);
        }
        public ActionResult ViewProfile(long id)
        {
            //id = Convert.ToInt32(Request.Cookies["memsid"].Value); // (long)Session["memsid"];


            var kk = db.Mems.Find(id);



            return View(kk);
            //var dd=new ViewProfilemem();
        }

        public ActionResult suspendUser(long id)
        {
            int i = db.SuspendMem(id);
            if (i > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("ViewProfile", new { id = id });
        }
        public ActionResult ResumeUser(long id)
        {
            int i = db.ResumeMem(id);
            if (i > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("ViewProfile", new { id = id });
        }
        #endregion

        #region[jobs]

        public ActionResult ViewUnAproveJob(int? id, int? i)
        {
            var joblistns = db.joblistns.OrderByDescending(a => a.Jobid).Include(j => j.citytable).Include(j => j.jobcategory).Include(j => j.Mem).Include(j => j.state).Include(j => j.Country).Where(c => c.isApproved == "N").ToList();

            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Job Is Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Approve";
            }
            if (i > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Job Is Deleted";
            }
            else if (i == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Delete";
            }
            return View(joblistns);
        }

        public ActionResult ApproveJob(long id)
        {
            int i = -1;

            i = db.jobApprove(id);

            return RedirectToAction("ViewUnAproveJob", new { id = i });
        }

        public ActionResult ViewAproveJob(int? id)
        {
            var joblistns = db.joblistns.OrderByDescending(a => a.Jobid).Include(j => j.citytable).Include(j => j.jobcategory).Include(j => j.Mem).Include(j => j.state).Include(j => j.Country).Where(c => c.isApproved == "Y").ToList();
            if (id > 0)
            {
                ViewBag.Success = true;
                ViewBag.message = "Job Is Un Approved";
            }
            else if (id == -1)
            {
                ViewBag.Success = false;
                ViewBag.message = "Unable to Un Approve";
            }

            return View(joblistns);
        }

        public ActionResult UnApproveJob(long id)
        {
            int i = 0;

            i = db.jobUnApprove(id);

            return RedirectToAction("ViewAproveJob", new { id = i });
        }

        public ActionResult DeleJob(long id)
        {
            joblistn joblistn = db.joblistns.Find(id);
            db.joblistns.Remove(joblistn);
            int i = -1;

            i = db.SaveChanges();
            return RedirectToAction("ViewUnAproveJob", new { i = i });
        }
        #endregion
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