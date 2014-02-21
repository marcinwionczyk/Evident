using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace EVident
{
    public partial class _CompanyRight : System.Web.UI.Page
    {
        private static readonly string[] DEFAULT_PAGES = new string[]
        {
            "~/ADDRESSBOOK.ASPX", "~/COMPANY.ASPX", "~/CONTRACTOR.ASPX", "~/DECISION.ASPX",
            "~/DEPARTMENT.ASPX", "~/INSTALLATION.ASPX", "~/PROCESSINGMETHOD.ASPX",
            "~/WASTECODE.ASPX", "~/ZSEIECODE.ASPX", "~/WASTERECORDCARD.ASPX",
            "~/WASTERECORDCARDELEMENT.ASPX", "~/WARNING.ASPX", "~/WASTERECORDCARDPRINTVIEW.ASPX"
        };
        private EVidentDataModel database;
        private Company company;

        protected void Page_Load(object sender, EventArgs e)
        {
            long id;
            if (long.TryParse(Request["Id"], out id))
            {
                database = Common.GetNotCachedDataModel();
                company = database.Companies.Include("CompanyRights").First(c => c.Id == id);

                if (!IsPostBack)
                {
                    companyFullNameLiteral.Text = company.FullName;
                    FillUi();
                }
            }
            else Response.Redirect("./Default.aspx", true);
        }

        private void FillUi()
        {
            Dictionary<CheckBox, string[]> selectionPages;
            string[] rights;

            selectionPages = GetSelectionPages();
            foreach (CheckBox checkBox in selectionPages.Keys)
            {
                rights = selectionPages[checkBox];
                if (HasRights(rights)) checkBox.Checked = true;
            }
        }

        private bool HasRights(string[] rights)
        {
            foreach (string right in rights)
            {
                if (!company.CompanyRights.Any(
                    cr => cr.VirtualPath == right)) return false;
            }
            return true;
        }

        protected void SaveButtonClick(object sender, EventArgs e)
        {
            DeleteAllFromCompanyRight();
            InsertDefaultIntoCompanyRight();
            InsertSelectedIntoCompanyRight();
        }

        private void DeleteAllFromCompanyRight()
        {
            IEnumerable<CompanyRight> companies;

            companies = from cr in database.CompanyRights.Include("Company")
                  where cr.Company.Id == company.Id
                  select cr;
            foreach (CompanyRight cr in companies) database.DeleteObject(cr);
            database.SaveChanges();
        }

        private void InsertDefaultIntoCompanyRight()
        {
            foreach (string virtualPath in DEFAULT_PAGES)
            {
                company.CompanyRights.Add(new CompanyRight()
                {
                    VirtualPath = virtualPath
                });
            }
            database.SaveChanges();
        }

        private void InsertSelectedIntoCompanyRight()
        {
            Dictionary<CheckBox, string[]> selectionPages;
            string[] rights;

            selectionPages = GetSelectionPages();
            foreach (CheckBox checkBox in selectionPages.Keys)
            {
                if (checkBox.Checked)
                {
                    rights = selectionPages[checkBox];
                    foreach (string right in rights)
                        company.CompanyRights.Add(new CompanyRight()
                        {
                            VirtualPath = right
                        });
                    database.SaveChanges();
                }
            }
        }

        private Dictionary<CheckBox, string[]> GetSelectionPages()
        {
            return new Dictionary<CheckBox, string[]>()
            {
                { creationCheckBox, new string[] { "~/CREATION.ASPX" } },
                { collectionCheckBox, new string[] { "~/COLLECTION.ASPX" } },
                { collectionZseieCheckBox, new string[] { "~/COLLECTIONZSEIE.ASPX" } },
                { collectionBatteryCheckBox, new string[] { "~/COLLECTIONBATTERY.ASPX" } },
                { collectionMetalCheckBox, new string[] { "~/COLLECTIONMETAL.ASPX" } },
                { recyclingCheckBox, new string[] { "~/RECYCLING.ASPX" } },
                { destructionCheckBox, new string[] { "~/DESTRUCTION.ASPX" } },
                { transferCheckBox, new string[] { "~/TRANSFER.ASPX" } },
                { transferZseieCheckBox, new string[] { "~/TRANSFERZSEIE.ASPX" } },
                { transferBatteryCheckBox, new string[] { "~/TRANSFERBATTERY.ASPX" } },
                { transferIndividualCheckBox, new string[] { "~/TRANSFERINDIVIDUAL.ASPX" } },
                { kpoCheckBox, new string[] { "~/TRANSFERCARD.ASPX", "~/TRANSFERCARDVIEW.ASPX" } },
                { dprDpoCheckBox, new string[] { "~/DPRDPO.ASPX", "~/DPRDPOELEMENT.ASPX", "~/DPRPRINTVIEW.ASPX", "~/DPOPRINTVIEW.ASPX" } },
                { annualReportCheckBox, new string[] { "~/ANNUALREPORT.ASPX", "~/ANNUALREPORTPRINTVIEW.ASPX" } },
                { movementZseieReportCheckBox, new string[] { "~/MOVEMENTZSEIEREPORT.ASPX", "~/MOVEMENTZSEIEREPORTVIEW.ASPX" } },
                { movementBatteryReportCheckBox, new string[] { "~/MOVEMENTBATTERYREPORT.ASPX", "~/MOVEMENTBATTERYREPORTVIEW.ASPX" } }
            };
        }
    }
}