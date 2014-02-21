/*
 * WLASCICIEL: phalladin
 * TABELE: Period, Department i Company w związku ze sprawdzaniem autoryzacji.
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace EVident
{
    public partial class Default : MasterPage
    {
        private static readonly string COMPANY_FULL_NAME_PATTERN = "({0})";
        private EVidentDataModel database;

        public WasteRecordCard GetCurrentWasteRecordCard()
        {
            EVidentDataModel database;
            WasteRecordCard wasteRecordCard;
            long wasteRecordCardId;

            if (long.TryParse(Request["WasteRecordCardId"], out wasteRecordCardId))
            {
                database = Common.GetNotCachedDataModel();
                wasteRecordCard = database.WasteRecordCards.
                    Include("WasteCode").First(wrc => wrc.Id == wasteRecordCardId);
                return wasteRecordCard;
            }
            return null;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Company company;
            string applicationName, applicationVersion, virtualPath;
            WarningChecker warningChecker;
            int warningCount;

            database = Common.GetNotCachedDataModel();
            virtualPath = Page.AppRelativeVirtualPath.ToUpper();
            applicationName = database.GetConfigurationValue("APPLICATION_NAME");
            applicationVersion = database.GetConfigurationValue("APPLICATION_VERSION");
            logoLiteral.Text = applicationName + " " + applicationVersion;

            if (ApplicationUser.IsLoggedIn)
            {
                company = database.GetCurrentCompany();
                companyFullNameLiteral.Text = string.Format(
                    COMPANY_FULL_NAME_PATTERN, company.FullName);
                logInOutMultiView.ActiveViewIndex = 0;
                ApplyCompanyRightToMainMenu();
                warningChecker = new WarningChecker(database,
                    (long)ApplicationUser.CurrentCompanyId,
                    (long)ApplicationUser.CurrentPeriodId);
                warningCount = warningChecker.GetWarningCount();
                warningCountLiteral.Text = warningCount + "";
                warningDiv.Visible = (warningCount > 0);
            }
            else
            {
                periodContainer.Visible = false;
                companyItem.Visible = false;
                recordItem.Visible = false;
                reportItem.Visible = false;
                dictionaryItem.Visible = false;
                configurationItem.Visible = false;
                companyRightItem.Visible = false;
                periodItem.Visible = false;
                logInOutMultiView.ActiveViewIndex = 1;
            }
            yearLiteral.Text = DateTime.Now.Year + "";
        }

        private void ApplyCompanyRightToMainMenu()
        {
            ProcessAnchorThroughCompanyRight(companyAnchor);
            ProcessAnchorThroughCompanyRight(departmentAnchor);
            ProcessAnchorThroughCompanyRight(decisionAnchor);
            ProcessAnchorThroughCompanyRight(installationAnchor);
            ProcessAnchorThroughCompanyRight(contractorAnchor);
            ProcessAnchorThroughCompanyRight(creationAnchor);
            ProcessAnchorThroughCompanyRight(collectionAnchor);
            ProcessAnchorThroughCompanyRight(collectionZseieAnchor);
            ProcessAnchorThroughCompanyRight(collectionBatteryAnchor);
            ProcessAnchorThroughCompanyRight(collectionMetalAnchor);
            ProcessAnchorThroughCompanyRight(recyclingAnchor);
            ProcessAnchorThroughCompanyRight(destructionAnchor);
            ProcessAnchorThroughCompanyRight(transferAnchor);
            ProcessAnchorThroughCompanyRight(transferZseieAnchor);
            ProcessAnchorThroughCompanyRight(transferBatteryAnchor);
            ProcessAnchorThroughCompanyRight(transferIndividualAnchor);
            ProcessAnchorThroughCompanyRight(kpoAnchor);
            ProcessAnchorThroughCompanyRight(dprDpoAnchor);
            ProcessAnchorThroughCompanyRight(annualReportAnchor);
            ProcessAnchorThroughCompanyRight(movementBatteryReportAnchor);
            ProcessAnchorThroughCompanyRight(movementZseieReportAnchor);
            ProcessAnchorThroughCompanyRight(zseieCodeAnchor);
            ProcessAnchorThroughCompanyRight(wasteCodeAnchor);
            ProcessAnchorThroughCompanyRight(addressBookAnchor);
            ProcessAnchorThroughCompanyRight(processingMethodAnchor);
            ProcessAnchorThroughCompanyRight(companyRightAnchor);
            ProcessAnchorThroughCompanyRight(periodAnchor);
            ProcessAnchorThroughCompanyRight(configurationAnchor);
            ProcessAnchorThroughCompanyRight(helpAnchor);
        }

        private void ProcessAnchorThroughCompanyRight(HtmlAnchor anchor)
        {
            string rel, virtualPath;

            rel = anchor.Attributes["rel"];
            virtualPath = anchor.HRef.ToUpper();
            virtualPath = "~" + virtualPath.Substring(1); // zamiana pierwszej kropki na tyldę
            anchor.Parent.Visible = HasCurrentCompanyRight(rel, virtualPath);
        }

        private bool HasCurrentCompanyRight(string rel, string virtualPath)
        {
            return (from cr in database.CompanyRights
                    where cr.Company.Id == ApplicationUser.CurrentCompanyId &&
                    (
                        cr.VirtualPath == rel ||
                        cr.VirtualPath == virtualPath
                    )
                    select cr).Count() > 0;
        }

        protected void DepartmentDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id;

            id = long.Parse(departmentDropDownList.SelectedValue);
            ApplicationUser.ChangeCurrentDepartmentId(id);
        }

        protected void PeriodDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id;

            id = long.Parse(periodDropDownList.SelectedValue);
            ApplicationUser.ChangeCurrentPeriodId(id);
        }

        protected void DepartmentDropDownListDataBound(object sender, EventArgs e)
        {
            if (ApplicationUser.IsLoggedIn)
                departmentDropDownList.SelectedValue = ApplicationUser.CurrentDepartmentId + "";
        }

        protected void PeriodDropDownListDataBound(object sender, EventArgs e)
        {
            if (ApplicationUser.IsLoggedIn)
                periodDropDownList.SelectedValue = ApplicationUser.CurrentPeriodId + "";
        }
    }
}