using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication13.Models;


namespace WebApplication13.Controllers
{
    public class ForumController : Controller
    {
        nextdhoomEntities db = new nextdhoomEntities();

        //
        // GET: /Forum/
        public ActionResult Index()
        {
            var category = db.ForumMainCategories.OrderByDescending(c => c.StartDate).ToList();
            return View(category);
        }

        public ActionResult subcategories(long id)
        {
            var forumlist = (from p in db.ForumSubCategories
                             join t in db.Mems on p.memsid equals t.memsid
                             where p.CatId == id
                             orderby p.UpdatedDate descending
                             select new getForum
                             {
                                 Category = db.ForumMainCategories.Where(c => c.catid == id).Select(c => c.Category).FirstOrDefault(),
                                 // catid = r.catid,
                                 SubCatId = p.SubCatId,
                                 // descrip = r.descrip,
                                 fname = db.Mems.Where(c => c.memsid == p.UpdatedBy).Select(c => c.fname).FirstOrDefault(),
                                 lname = t.lname,
                                 LastTopic = p.LastTopic,
                                 TopicTitle = db.ForumTopics.Where(c => c.TopicId == p.LastTopic && c.IsApproved == "Y").Select(c => c.TopicTitle).FirstOrDefault().ToString(),
                                 SubCatTitle = p.SubCatTitle,
                                 SubCatDesc = p.SubCatDesc,
                                 memsid = p.memsid,
                                 photo = db.Mems.Where(c => c.memsid == p.UpdatedBy).Select(c => c.gimg).FirstOrDefault(),
                                 TopicsCount = db.ForumTopics.Where(c => c.SubCatId == p.SubCatId && c.IsApproved == "Y").Count().ToString(),
                                 ReplyCount = db.ForumTopicAnswers.Join(db.ForumTopics, fa => fa.TopicId, ft => ft.TopicId, (fa, ft) => new { ForumTopicAnswers = fa, ForumTopics = ft }).Where(c => c.ForumTopics.SubCatId == p.SubCatId).Count().ToString(),
                                 UpdatedBy = p.UpdatedBy,
                                 lastupdate = p.UpdatedDate.Value,
                                 UpdatedByName = ""

                             }).Distinct().ToList();

            return View(forumlist);
        }
        public ActionResult topics(long id)
        {
            //string o = Convert.ToString(id);
            //var topic = db.ForumgetTopics(o).ToString();
            TopicsModel topic = new TopicsModel();

            topic.gettopic = (from t in db.ForumTopics
                              join m in db.Mems on t.memsid equals m.memsid
                              where t.SubCatId == id && t.IsApproved == "Y"
                              orderby t.UpdateDate descending
                              select new gettopics
                              {
                                  CatId = t.catid,
                                  TopicId = t.TopicId,
                                  TopicTitle = t.TopicTitle,
                                  memsid = t.memsid,
                                  fname = m.fname,
                                  starteddate = t.StartDate.ToString(),
                                  updatedate = t.UpdateDate.ToString(),
                                  ReplayCount = db.ForumTopicAnswers.Where(c => c.TopicId == t.TopicId).Count(),
                                  Photo = m.gimg, //db.Photos.Where(r => r.memsid == r.Mem.memsid).Select(r => r.photoname).ToString(),
                                  UpdateCandiId = t.UpdateCandiId.ToString(),
                                  UpdateCandiName = t.UpdateCandiName

                              }).ToList();

            topic.forumcategory = (from s in db.ForumSubCategories
                                   join m in db.Mems on s.memsid equals m.memsid
                                   where s.SubCatId == id
                                   select new forumcat
                                   {

                                       CatID = s.CatId,
                                       SubCatId = s.SubCatId,
                                       SubCatTitle = s.SubCatTitle,
                                       SubCatDesc = s.SubCatDesc,
                                       memsid = m.memsid,
                                       fname = m.fname,
                                       lname = m.lname,
                                       lastupdate = s.UpdatedDate.ToString(),
                                       gimg = m.gimg,
                                       TopicsCount = db.ForumTopics.Where(c => c.SubCatId == s.SubCatId && c.IsApproved == "Y").Count(),
                                       ReplyCount = db.ForumTopicAnswers.Join(db.ForumTopics, f => f.TopicId, o => o.TopicId, (f, o) => new { f.AnsId, o.SubCatId })
                                       .Where(f => f.SubCatId == s.SubCatId).Count()

                                   }).FirstOrDefault();

            //if ( )
            //{
            //    return View(topic);

            // }
            //else
            //{
            return View(topic);
            //}

        }
        [HttpGet]
        public ActionResult PostTopic(long id, long cid)
        {
            posttopicModel topic = new posttopicModel();

            topic.forumcategory = (from s in db.ForumSubCategories
                                   join m in db.Mems on s.memsid equals m.memsid
                                   where s.SubCatId == id
                                   select new forumcat
                                   {
                                       CatID = s.CatId,
                                       SubCatId = s.SubCatId,
                                       SubCatTitle = s.SubCatTitle,
                                       SubCatDesc = s.SubCatDesc,
                                       memsid = m.memsid,
                                       fname = m.fname,
                                       lname = m.lname,
                                       lastupdate = s.UpdatedDate.ToString(),
                                       gimg = m.gimg,
                                       TopicsCount = db.ForumTopics.Where(c => c.SubCatId == s.SubCatId).Count(),
                                       ReplyCount = db.ForumTopicAnswers.Join(db.ForumTopics, f => f.TopicId, o => o.TopicId, (f, o) => new { f.AnsId, o.SubCatId })
                                       .Where(f => f.SubCatId == s.SubCatId).Count()

                                   }).FirstOrDefault();
            return View(topic);
        }
        [Authorize]
        [HttpPost]
        public ActionResult PostTopic(long id, long cid, posttopicModel ins)
        {
            posttopicModel topic = new posttopicModel();

            topic.forumcategory = (from s in db.ForumSubCategories
                                   join m in db.Mems on s.memsid equals m.memsid
                                   where s.SubCatId == id
                                   select new forumcat
                                   {
                                       CatID = s.CatId,
                                       SubCatId = s.SubCatId,
                                       SubCatTitle = s.SubCatTitle,
                                       SubCatDesc = s.SubCatDesc,
                                       memsid = m.memsid,
                                       fname = m.fname,
                                       lname = m.lname,
                                       lastupdate = s.UpdatedDate.ToString(),
                                       gimg = m.gimg,
                                       TopicsCount = db.ForumTopics.Where(c => c.SubCatId == s.SubCatId).Count(),
                                       ReplyCount = db.ForumTopicAnswers.Join(db.ForumTopics, f => f.TopicId, o => o.TopicId, (f, o) => new { f.AnsId, o.SubCatId })
                                       .Where(f => f.SubCatId == s.SubCatId).Count()

                                   }).FirstOrDefault();

            long memid = Convert.ToInt32(Request.Cookies["memsid"].Value);
            string fname = Request.Cookies["fname"].Value;

            commonFun rtp = new commonFun();

            if (ModelState.IsValid)
            {
                string topicttl = rtp.ReplaceBadWords(ins.insertTp.topicTitle);
                string topicdesc = rtp.ReplaceBadWords(ins.insertTp.topicDesc);

                int i = db.forumInsertTopic(topicttl, topicdesc, cid, id, memid, fname, memid, System.DateTime.Now, System.DateTime.Now);
                if (i > 0)
                {
                    ViewBag.Success = true;

                    ViewBag.Message = "Topic posted successfully Queued For approval";
                    return View(topic);
                }
                else
                {
                    ViewBag.Success = false;
                    ViewBag.Message = "Unable to Post";
                    return View(topic);
                }

            }
            else
            {
                ViewBag.Success = false;
                ViewBag.Message = "Unable to Post";
                return View(topic);
            }

        }

        [HttpGet]
        public ActionResult ViewTopic(long id, long catid)
        {
            VTopicModel viewTop = new VTopicModel();

            viewTop.Vtp = (from ft in db.ForumTopics
                           join me in db.Mems on ft.memsid equals me.memsid
                           where ft.TopicId == id && ft.IsApproved == "Y"
                           select new ViewTopicModel
                           {
                               TopicId = ft.TopicId,
                               TopicDesc = ft.TopicDesc,
                               TopicTitle = ft.TopicTitle,
                               fname = me.fname,
                               Photo = me.gimg,
                               SubCatId = ft.SubCatId,
                               memsid = ft.memsid,
                               UpdateCandiId = ft.UpdateCandiId.ToString(),
                               UpdateCandiName = ft.UpdateCandiName,
                               UpdateDate = ft.UpdateDate.ToString(),
                               StartDate = ft.StartDate.ToString(),
                               LastAnsId = db.ForumTopics.Where(c => c.memsid == me.memsid).Count(),
                               TotalThread = db.ForumSubCategories.Where(c => c.SubCatId == ft.SubCatId).Count(),
                               TotalReplay = db.ForumTopicAnswers.Where(c => c.TopicId == ft.TopicId).Count(),
                           }).FirstOrDefault();

            viewTop.TpAns = (from fta in db.ForumTopicAnswers
                             join me in db.Mems on fta.memsid equals me.memsid
                             where fta.TopicId == id && fta.IsApproved == "Y"
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
            return View(viewTop);
        }
        [Authorize]
        [HttpPost]
        public ActionResult ViewTopic(long id, long catid, VTopicModel vt)
        {
            VTopicModel viewTop = new VTopicModel();

            viewTop.Vtp = (from ft in db.ForumTopics
                           join me in db.Mems on ft.memsid equals me.memsid
                           where ft.TopicId == id && ft.IsApproved == "Y"
                           select new ViewTopicModel
                           {
                               TopicId = ft.TopicId,
                               TopicDesc = ft.TopicDesc,
                               TopicTitle = ft.TopicTitle,
                               fname = me.fname,
                               Photo = me.gimg,
                               SubCatId = ft.SubCatId,
                               memsid = ft.memsid,
                               UpdateCandiId = ft.UpdateCandiId.ToString(),
                               UpdateCandiName = ft.UpdateCandiName,
                               UpdateDate = ft.UpdateDate.ToString(),
                               StartDate = ft.StartDate.ToString(),
                               LastAnsId = db.ForumTopics.Where(c => c.memsid == me.memsid).Count(),
                               TotalThread = db.ForumSubCategories.Where(c => c.SubCatId == ft.SubCatId).Count(),
                               TotalReplay = db.ForumTopicAnswers.Where(c => c.TopicId == ft.TopicId).Count(),
                           }).FirstOrDefault();



            long memid = Convert.ToInt32(Request.Cookies["memsid"].Value);
            string fname = Request.Cookies["fname"].Value;
            if (vt.insAns.TopicAns != null)
            {
                if (ModelState.IsValid)
                {

                    commonFun rpb = new commonFun();
                    string tpans = string.Empty;

                    tpans = rpb.ReplaceBadWords(vt.insAns.TopicAns);

                    int i = db.forumInsertAnswer(id, tpans, memid, System.DateTime.Now, fname);

                    if (i > 0)
                    {
                        ViewBag.Success = true;
                        ViewBag.Message = "Reply Posted Successfully Queued For Approval";
                        return View(viewTop);
                    }
                    else
                    {
                        ViewBag.Success = false;
                        ViewBag.Message = "Unable to Post";
                        return View(viewTop);
                    }
                }
            }
            else
            {
                ViewBag.Success = false;
                ViewBag.Message = "Unable to Post";
                return View(viewTop);
            }
            return View(viewTop);
        }

        [Authorize]
        public ActionResult DelTopic(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ForumTopic frmtopic = db.ForumTopics.Find(id);
            if (frmtopic == null)
            {
                return HttpNotFound();
            }
            return View(frmtopic);


        }

        [HttpPost, ActionName("DelTopic")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            int i = db.forumdeleteTopic(id);
            if (i > 0)
            {
                return RedirectToAction("Index", "Forum");
            }
            return RedirectToAction("topics", new { id = id });
        }


        [Authorize]
        public ActionResult DelAns(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ForumTopicAnswer frmtopicAns = db.ForumTopicAnswers.Find(id);
            if (frmtopicAns == null)
            {
                return HttpNotFound();
            }
            return View(frmtopicAns);


        }

        [HttpPost, ActionName("DelAns")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirm(long id)
        {
            int i = db.ForumdeleteAnswer(id);
            if (i > 0)
            {
                return RedirectToAction("Index", "Forum");
            }
            return RedirectToAction("topics", new { id = id });
        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

    }
}