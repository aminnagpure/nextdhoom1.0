using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebApplication13.Models;
using WebApplication13.Models.membersview;

namespace WebApplication13.Controllers
{
    public class HomeController : Controller
    {
        string jmem = "";
        string fname1 = "";
        string lname1 = "";
        dynamic objcont;
        string jsonString = "";
        dynamic obj;

        Mem mm = new Mem();
        nextdhoomEntities db = new nextdhoomEntities();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [HttpGet]
        public ActionResult Login(string returnUrl)
        {

            if (returnUrl != null)
            {
                Regex regex = new Regex("^/(?<Controller>[^/]*)(/(?<Action>[^/]*)(/(?<id>[^?]*)(/?(?<QueryString>.*))?)?)?$");
                Match match = regex.Match(returnUrl);

                Int32 id = 0;

                var a = match.Groups["Controller"].Value;
                var b = match.Groups["Action"].Value;
                var aid = match.Groups["id"].Value;
                var d = match.Groups["QueryString"].Value;

                if (aid != "")
                {
                    id = Convert.ToInt32(aid);
                }


                ViewBag.ReturnUrl = returnUrl;

                if (a == "Jobs")
                {
                    if (id == 0)
                    {
                        return View();
                    }

                    joblistn joblistn = db.joblistns.Find(id);

                    if (joblistn == null)
                    {
                        // return HttpNotFound();
                        return View();
                    }

                    ViewBag.jobid = joblistn.Jobid;
                    ViewBag.designation = joblistn.designation;
                    ViewBag.gimg = joblistn.Mem.gimg;
                    ViewBag.location = joblistn.citytable.cityname;
                    ViewBag.fname = joblistn.Mem.fname + " " + joblistn.Mem.lname;
                    var kk = joblistn.jobdescription;
                    var ln = kk.Length;
                    if (ln > 80)
                    {
                        ln = 80;
                    }
                    ViewBag.desc = kk.Substring(1, ln - 1);
                    //return View(joblistn);
                }
            }

            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginView model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var kk = (from u in db.Mems where u.email.Equals(model.email) && u.passw.Equals(model.Passw) select u).FirstOrDefault();

                if (kk != null)
                {
                    //Session["memsid"] = kk.memsid;
                    //Session["fname"] = kk.fname;
                    //Session["lname"] = kk.lname;

                    HttpCookie memsid = new HttpCookie("memsid", kk.memsid.ToString());
                    Response.Cookies.Add(memsid);


                    HttpCookie fname = new HttpCookie("fname", kk.fname);
                    Response.Cookies.Add(fname);

                    HttpCookie lname = new HttpCookie("lname", kk.lname);
                    Response.Cookies.Add(lname);

                    if (kk.susp == "Y")
                    {
                        HttpCookie scammer = new HttpCookie("scammer", "Yes");

                        Response.Cookies.Add(scammer);
                        Response.Cookies["scammer"].Expires = DateTime.Now.AddDays(30);
                        //return RedirectToAction("Index","Scammer"); 
                    }


                    var imgl = kk.gimg.Replace("sz=50", "sz=20");
                    HttpCookie gmailimage = new HttpCookie("gmailimage", imgl);

                    Response.Cookies.Add(gmailimage);


                }


                if (kk == null)
                {
                    // Invalid user name or password
                    ModelState.AddModelError("", "Invalid username or password.");
                }

                else
                {
                    FormsAuthentication.SetAuthCookie(kk.email, false);

                    if (Url.IsLocalUrl(returnUrl))
                    {
                        return Redirect(returnUrl);
                        //return RedirectToAction("Index", "members");
                    }
                    else
                    {
                        return RedirectToAction("Index", "members");
                    }
                    // Success
                }


            }
            return View(model);
            // If we got this far, something failed, redisplay form
            //return 
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }


        public string addmem()
        {
            //string fname,email;
            string email;
            var aa = HttpContext.Request;
            aa.InputStream.Seek(0, SeekOrigin.Begin);

            jmem = new StreamReader(aa.InputStream).ReadToEnd();

            obj = JObject.Parse(jmem);
            if (jmem != null)
            {


                string gender = "M";



                mm.fname = obj["UD"].name.givenName;
                mm.lname = obj["UD"].name.familyName;

                // for session
                fname1 = mm.fname;
                lname1 = mm.lname;

                mm.passw = "1234";
                try
                {
                    gender = obj["UD"].gender;
                }
                catch (Exception e)
                {

                }
                if (gender == "male")
                {
                    gender = "M";

                }
                else
                {
                    gender = "F";
                }
                mm.gender = gender;
                mm.email = obj["UD"].emails[0].value;
                email = mm.email;

                try
                {
                    mm.gimg = obj["UD"].image.url;
                }
                catch (Exception e)
                {
                    mm.gimg = "";
                }

                try
                {
                    mm.gurl = obj["UD"].url;
                }
                catch (Exception e)
                {
                    mm.gurl = "";
                }
                mm.photoid = 0;
                mm.countryid = 1;
                mm.stateid = 117;
                mm.cityid = 846;
                mm.aboutme = "hi there";
                mm.susp = "N";
                mm.isJobseeker = "N";
               
                mm.sponsoremail = "Y";
                mm.regDate = System.DateTime.Now;



                try
                {



                    db.Mems.Add(mm);

                    db.SaveChanges();
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

                //Session["memsid"] = mm.memsid;
                //Session["fname"] = fname1;
                //Session["lname"] = lname1;



                HttpCookie memsid = new HttpCookie("memsid", mm.memsid.ToString());
                Response.Cookies.Add(memsid);


                HttpCookie fname = new HttpCookie("fname", fname1);
                Response.Cookies.Add(fname);

                HttpCookie lname = new HttpCookie("lname", lname1);
                Response.Cookies.Add(lname);




                //return mm.memsid;




                FormsAuthentication.SetAuthCookie(mm.email, false);

                //Response.Redirect("members/");












            }

            return jmem;
            //return "sdfs";

            // return Redirect("/index/members");


            //return RedirectToAction("Index", "Members");






        }

        public string readcont()
        {
            var aa = HttpContext.Request;
            //string contemail = "";
            aa.InputStream.Seek(0, SeekOrigin.Begin);

            jsonString = new StreamReader(aa.InputStream).ReadToEnd();

            objcont = JObject.Parse(jsonString);



            //foreach(JsonTextReader jj in objcont)
            //{
            //    contemail = jj.Value.ToString();




            //}



            if (jsonString != null)
            {

                //contemail=objcont["UD"].[gd$email].address;

                // dd.getemails(jsonString, "kaa");

                string path = HttpContext.Server.MapPath("/contacts/");
                //HttpContext.Current.Server.MapPath("/contacts/");


                if (Directory.Exists(path))
                {

                }
                else
                {
                    Directory.CreateDirectory(path);
                }

                path = path + Guid.NewGuid() + ".json";
                StreamWriter sw = new StreamWriter(path, true);


                sw.WriteLine(objcont);

                sw.Close();






            }

            return jsonString;
            //return RedirectToAction("Index", "Members");
            //Response.Redirect("members/index");

        }


        public ActionResult Privacy()
        {
            return View();

        }
        public ActionResult OurMems()
        {
            var mod = from r in db.Mems
                      orderby r.memsid descending
                      select new MemListViewModel
                      {
                          fname = r.fname,
                          lname = r.lname,
                          gimg = r.gimg

                      };

            return View(mod);
        }


        public ActionResult TVchat()
        {
            return View();
        }
        public ActionResult Postads()
        {
            return View();
        }


        #region[Complaints]
        public ActionResult Complaints(int? i)
        {

            var complist = db.User_Complaints.OrderByDescending(c => c.ComplaintDate).ToList();

            if (i > 0)
            {
                ViewBag.Success = true;
                ViewBag.Message = "Complaint Deleted Successfully";
            }
            else if (i == -1)
            {
                ViewBag.Success = false;
                ViewBag.Message = "Unable to Delete";
            }

            return View(complist);


        }
        [HttpGet]
        public ActionResult ReplyComplaint(long id, int? i)
        {
            replyComplaint rplyComp = new replyComplaint();

            rplyComp.user_complaints = db.User_Complaints.Find(id);

            long memid = 0;
            ViewBag.mem = false;

            if (Request.Cookies["memsid"] != null)
            {
                if (Request.Cookies["memsid"].Value == "14")
                {
                    memid = Convert.ToInt64(Request.Cookies["memsid"].Value);
                }
                else
                {
                    long mid = Convert.ToInt64(Request.Cookies["memsid"].Value);

                    long mem = (from c in db.User_Complaints
                                join m in db.Mems on c.EmailID equals m.email
                                where c.ComplaintID == id
                                select m.memsid).FirstOrDefault();

                    if (mem == mid)
                    {
                        memid = mid;
                    }
                }
                if (memid > 0)
                {
                    rplyComp.user_complaints_comments = new User_Complaints_Comments
                    {
                        CommentsBy = memid,
                        CommentsByName = Request.Cookies["fname"].Value,
                        Comments = "",
                    };
                    ViewBag.mem = true;
                }
                else
                {
                    ViewBag.mem = false;
                }

            }

            if (i > 0)
            {
                ViewBag.success = true;
                ViewBag.Message = "Reply Is Deleted";
            }
            else if (i == -1)
            {
                ViewBag.success = false;
                ViewBag.Message = "Unable to Deleted";
            }
            rplyComp.replyComments = db.User_Complaints_Comments.Where(c => c.ComplaintsID == id)
                                       .OrderByDescending(c => c.CommentsDate).ToList();
            return View(rplyComp);
        }

        [HttpPost]
        public ActionResult ReplyComplaint(long id, replyComplaint rply, FormCollection frm)
        {
            replyComplaint rplyComp = new replyComplaint();

            if (rply.user_complaints_comments != null)
            {

                string comments = rply.user_complaints_comments.Comments;
                long comid = rply.user_complaints_comments.CommentsBy;
                string name = rply.user_complaints_comments.CommentsByName;
                string email = rply.user_complaints.EmailID;

                if (email == null)
                {
                    email = ViewBag.email;
                }
                string isadmin = "N";
                string resolved = "N";

                bool isChecked = false;
                if (Boolean.TryParse(Request.Form.GetValues("resoled")[0], out isChecked) == true)
                {
                    if (isChecked == true)
                    {
                        resolved = "Y";
                    }
                }
                if (Request.Cookies["memsid"] != null && Request.Cookies["memsid"].Value == "14")
                {
                    isadmin = "Y";
                }

                int i = -1;
                i = db.User_Complaints_Comments_Add(id, comments, comid, name, isadmin, System.DateTime.Now, resolved);
                string subject = "NextDhoom Support & Complaints";
                string body = "Dear : " + email + " we got your complaint on NextDhoom.com please Visit Our Sites for Reply <a href='http://www.nextdhoom.com/Home/ReplyComplaint/" + id + "'>Click Here</a>";
                MailMessage mail = new MailMessage();
                //mail.To.Add(_objModelMail.To);
                mail.To.Add(email);
                mail.From = new MailAddress("aminnagpure@gmail.com");
                mail.Subject = subject;
                string Body = body;
                mail.Body = Body;
                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "mail.nextdhoom.com";
                smtp.Port = 25;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential
                ("regi@nextdhoom.com", "Amin1234*");// Enter seders User name and password
                //  smtp.EnableSsl = true;




                if (i > 0)
                {
                    ViewBag.Success = true;
                    ViewBag.Message = "Reply Posted Successfully";
                    smtp.Send(mail);
                }
                else
                {
                    ViewBag.Success = false;
                    ViewBag.Message = "Unable to Post";
                }
            }
            rplyComp.user_complaints = db.User_Complaints.Find(id);
            rplyComp.replyComments = db.User_Complaints_Comments.Where(c => c.ComplaintsID == id).ToList();
            return View(rplyComp);


        }
        [HttpGet]
        public ActionResult AddComplain()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddComplain(User_Complaints usercomplain)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    //db.User_Complaints.Add(usercomplain);
                    //db.SaveChanges();    
                    db.User_Complaints_Add(usercomplain.UserMobile, usercomplain.EmailID, usercomplain.UserName, usercomplain.ComplaintHead, usercomplain.ComplaintDesc);

                    return RedirectToAction("Index");
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
            }
            return View(usercomplain);
        }

        public ActionResult deleComplaint(long id)
        {
            int i = -1;
            i = db.UserComplaints_Delete(id);

            return RedirectToAction("Complaints", new { i = i });
        }

        public ActionResult deleRply(long id, long cid)
        {
            int i = -1;

            i = db.UserComplaints_Comments_Delete(id);

            return RedirectToAction("ReplyComplaint", new { i = i, id = cid });
        }
        #endregion
        public ActionResult Stopemails()
        {
            ViewBag.ermessage = "";
            return View();
        }

        [HttpPost]
        public ActionResult Stopemails(Invite i)
        {
            kvrplacementsEntities kvr = new kvrplacementsEntities();
            if (ModelState.IsValid)
            {
                int p = kvr.stopinvite(i.email);
                if (p > 0)
                {
                    ViewBag.ermessage = "Email has been blocked";
                }
                else
                {
                    ViewBag.ermessage = "Email Not Found";
                }
                kvr.Dispose();
            }

            return View();

        }

        public ActionResult Scammer()
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