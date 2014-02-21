using System;
using EVident.Code;
using System.Collections.Generic;

namespace EVident
{
    public partial class Warning : System.Web.UI.Page
    {
        private EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            WarningChecker warningChecker;

            database = Common.GetNotCachedDataModel();
            warningChecker = new WarningChecker(database, 
                (long)ApplicationUser.CurrentCompanyId, 
                (long)ApplicationUser.CurrentPeriodId);
            PresentWarningList(warningChecker);
        }

        private void PresentWarningList(WarningChecker warningChecker)
        {
            string html;

            html = "";
            foreach (Dictionary<string, string> row in warningChecker.GetCreationWarningList())
                html += GetWarningHtml("# brak decyzji dla wytwarzania",
                    string.Format("kod odpadu: {0}; nr karty: {1}", row["0"], row["1"]));
            foreach (Dictionary<string, string> row in warningChecker.GetRecyclingWarningList())
                html += GetWarningHtml("# brak decyzji dla odzysku",
                    string.Format("kod odpadu: {0}; nr karty: {1}", row["0"], row["1"]));
            foreach (Dictionary<string, string> row in warningChecker.GetRecyclingInInstallationWarningList())
                html += GetWarningHtml("# brak decyzji dla odzysku w instalacji",
                    string.Format("kod odpadu: {0}; nr karty: {1}; instalacja: {2}", 
                    row["0"], row["1"], row["2"]));
            foreach (Dictionary<string, string> row in warningChecker.GetDestructionWarningList())
                html += GetWarningHtml("# brak decyzji dla unieszkodliwiania",
                    string.Format("kod odpadu: {0}; nr karty: {1}", row["0"], row["1"]));
            foreach (Dictionary<string, string> row in warningChecker.GetDestructionInInstallationWarningList())
                html += GetWarningHtml("# brak decyzji dla unieszkodliwiania w instalacji",
                    string.Format("kod odpadu: {0}; nr karty: {1}; instalacja: {2}",
                    row["0"], row["1"], row["2"]));
            warningLiteral.Text = html;
        }

        private string GetWarningHtml(string title, string message)
        {
            string html;

            html = "<p class=\"warningTitle\">" + title + "</p>";
            html += "<p class=\"warningMessage\">" + message + "</p>";
            return html;
        }
    }
}