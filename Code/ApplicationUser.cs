using System;
using System.Web;
using System.Linq;

namespace EVident.Code
{
    public static class ApplicationUser
    {
        private static readonly string CURRENT_COMPANY_ID_KEY = "CompanyId";
        private static readonly string CURRENT_DEPARTMENT_ID_KEY = "DepartmentId";
        private static readonly string CURRENT_PERIOD_ID_KEY = "PeriodId";

        public static void LogIn(Company company)
        {
            EVidentDataModel database;
            Department currentDepartment;

            database = Common.GetDataModel();
            HttpContext.Current.Session[CURRENT_COMPANY_ID_KEY] = company.Id;
            
            currentDepartment = database.Departments.FirstOrDefault(
                d => d.Company.Id == company.Id && d.IsMain);
            if (currentDepartment == null) currentDepartment = 
                database.Departments.First(d => d.Company.Id == company.Id);
            
            HttpContext.Current.Session[CURRENT_DEPARTMENT_ID_KEY] = currentDepartment.Id;
            HttpContext.Current.Session[CURRENT_PERIOD_ID_KEY] = database.GetMainPeriodOrFirst().Id;
        }

        public static void LogOut()
        {
            HttpContext.Current.Session.Abandon();
        }

        public static void ChangeCurrentDepartmentId(long id)
        {
            HttpContext.Current.Session[CURRENT_DEPARTMENT_ID_KEY] = id;
        }

        public static void ChangeCurrentPeriodId(long id)
        {
            HttpContext.Current.Session[CURRENT_PERIOD_ID_KEY] = id;
        }

        public static long? CurrentCompanyId { get { return (long?) HttpContext.Current.Session[CURRENT_COMPANY_ID_KEY]; } }
        public static long? CurrentDepartmentId { get { return (long?)HttpContext.Current.Session[CURRENT_DEPARTMENT_ID_KEY]; } }
        public static long? CurrentPeriodId { get { return (long?)HttpContext.Current.Session[CURRENT_PERIOD_ID_KEY]; } }
        
        public static bool IsLoggedIn 
        { 
            get
            { 
                return HttpContext.Current.Session != null && CurrentCompanyId != null; 
            }
        }
    }
}