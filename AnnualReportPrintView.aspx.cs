using System;
using System.Linq;
using EVident.Code;
using System.Web.UI;
using EVident.UserControl;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class AnnualReportPrintView : System.Web.UI.Page
    {
        private EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            Company company;
            long periodId;
            AnnualReportSection1TableB section1TableB;
            bool section2TableFilled, section4TableFilled, section5TableAFilled, 
                section5TableBFilled, section5TableCFilled, section6TableAFilled, 
                section6TableBFilled, section7TableFilled;

            if (long.TryParse(Request["Id"], out periodId))
            {
                database = Common.GetNotCachedDataModel();
                annualReportSection1TableA.FillUi(database,
                    (long)ApplicationUser.CurrentCompanyId, periodId);
                company = database.Companies.First(c => c.Id == (long)ApplicationUser.CurrentCompanyId);
                company.Departments.Load();

                foreach (Department department in company.Departments)
                {
                    section1TableB = (AnnualReportSection1TableB) 
                        LoadControl("~/UserControl/AnnualReportSection1TableB.ascx");
                    section1TableB.FillUi(database, department.Id, periodId);
                    section1TableBPlaceHolder.Controls.Add(section1TableB);
                    section1TableBPlaceHolder.Controls.Add(GetBr());
                }

                section2TableFilled = (annualReportSection2Table.FillUi(database, company.Id, periodId) > 0);
                section4TableFilled = (annualReportSection4Table.FillUi(database, company.Id, periodId) > 0);
                section5TableAFilled = (annualReportSection5TableA.FillUi(database, company.Id, periodId) > 0);
                section5TableBFilled = (annualReportSection5TableB.FillUi(database, company.Id, periodId) > 0);
                section5TableCFilled = (annualReportSection5TableC.FillUi(database, company.Id, periodId) > 0);
                section6TableAFilled = (annualReportSection6TableA.FillUi(database, company.Id, periodId) > 0);
                section6TableBFilled = (annualReportSection6TableB.FillUi(database, company.Id, periodId) > 0);
                section7TableFilled = (annualReportSection7Table.FillUi(database, company.Id, periodId) > 0);
                annualReportSection1TableA.UpdateCheckBoxes(section2TableFilled, section4TableFilled, 
                    section5TableAFilled, section5TableBFilled, section5TableCFilled, section6TableAFilled,
                    section6TableBFilled, section7TableFilled);
                section2Div.Visible = section2TableFilled;
                section4Div.Visible = section4TableFilled;
                section5TableADiv.Visible = section5TableAFilled;
                section5TableBDiv.Visible = section5TableBFilled;
                section5TableCDiv.Visible = section5TableCFilled;
                section5Div.Visible = section5TableAFilled && section5TableBFilled && section5TableCFilled;
                section6TableADiv.Visible = section6TableAFilled;
                section6TableBDiv.Visible = section6TableAFilled;
                section7Div.Visible = section7TableFilled;
            }
            else Response.Redirect("./Default.aspx", true);
        }

        private Control GetBr()
        {
            Literal literal;

            literal = new Literal();
            literal.Text = "<br />";
            return literal;
        }

        protected void ExportToPdfButtonClick(object sender, EventArgs e)
        {
            Common.ExportToPdf(page, Response, "Eksport.pdf");
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}