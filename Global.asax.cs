/*
 * WLASCICIEL: phalladin
 * TABELE: brak
*/

using System;
using System.IO;
using System.Web;
using System.Linq;
using EVident.Code;

namespace EVident
{
    public class Global : HttpApplication
    {
        
        protected void Session_Start(object sender, EventArgs e)
        {
            EVidentDataModel database;
            Company company;
            byte[] md5 = Common.Md5("abc");
            database = Common.GetNotCachedDataModel();

            company = new Company();
            company.Login = "ABC";
            company.PasswordHash = md5;
            /*
            company = (from c in database.Companies.Include("Departments")
                       where c.Login == "ABC" && c.PasswordHash == md5
                       select c).First();
             */
            ApplicationUser.LogIn(company);
        }
        
        protected void Application_PreRequestHandlerExecute(Object sender, EventArgs e)
        {
            string virtualPath, encodedPath;

            virtualPath = HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.ToUpper();
            if (virtualPath.EndsWith(".ASPX"))
            {
                if (ApplicationUser.IsLoggedIn)
                {
                    if (!CheckCompanyRight(virtualPath))
                    {
                        encodedPath = Server.UrlEncode(virtualPath);
                        HttpContext.Current.Response.Redirect("./NoCompanyRight.aspx?PagePath=" + encodedPath, true);
                    }
                }
                else if (!IsPublicAvailablePage(virtualPath))
                {
                    HttpContext.Current.Session["LastPage"] = 
                        HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath;
                    HttpContext.Current.Response.Redirect("./LogIn.aspx");
                }
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception;

            exception = Server.GetLastError().GetBaseException();
            LogExceptionToFile("./Error", exception);
            TryLogExceptionToDatabase(exception);
            HttpContext.Current.Response.Write("<pre style=\"font-size: 10pt;white-space: normal;\">" + exception.Message + "</pre>");
            Server.ClearError();
        }

        private void LogExceptionToFile(string directory, Exception exception)
        {
            string fileName, filePath;
            DateTime now;

            if (HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.ToUpper() == "~/FAVICON.ICO") return;
            now = DateTime.Now;
            fileName = string.Format("{0}-{1:D2}-{2:D2}-{3:D2}-{4:D2}-{5:D2}-{6:D10}.txt",
                now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second, now.Millisecond);
            filePath = Path.Combine(directory, fileName);
            if (!Directory.Exists(directory)) Directory.CreateDirectory(directory);
            File.WriteAllText(filePath, exception.ToString());
        }

        private bool TryLogExceptionToDatabase(Exception exception)
        {
            EVidentDataModel database;

            if (HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.ToUpper() == "~/FAVICON.ICO") return false;
            try
            {
                database = Common.GetNotCachedDataModel();
                database.AddToErrors(new Error()
                {
                    Text = exception.ToString()
                });
                database.SaveChanges();
                return true;
            }
            catch
            {
                // tłumienie wszystkich wyjątków ponieważ jest to funkcja logująca wyjątek 
                // aplikacji i nie można pozwolić aby z niej wyszedł jakiś dodatkowy wyjątek
            }
            return false;
        }

        private bool CheckCompanyRight(string virtualPath)
        {
            EVidentDataModel database;

            database = Common.GetNotCachedDataModel();
            return IsPublicAvailablePage(virtualPath) || 
                database.CompanyRights.Any(cr => cr.Company.Id == ApplicationUser.CurrentCompanyId &&
                                                 cr.VirtualPath == virtualPath);
        }

        private bool IsPublicAvailablePage(string virtualPath)
        {
            return virtualPath == "~/DEFAULT.ASPX" || virtualPath == "~/HELP.ASPX" ||
                virtualPath == "~/LOGIN.ASPX" || virtualPath == "~/LOGOUT.ASPX" ||
                virtualPath == "~/NOCOMPANYRIGHT.ASPX";
        }
    }
}