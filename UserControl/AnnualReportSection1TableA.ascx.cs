using System;
using System.Linq;

namespace EVident.UserControl
{
    public partial class AnnualReportSection1TableA : System.Web.UI.UserControl
    {
        public void FillUi(EVidentDataModel database, long companyId, long periodId)
        {
            Company company;
            Period period;

            company = database.Companies.
                Include("Commune.District.Province").First(c => c.Id == companyId);
            period = database.Periods.First(p => p.Id == periodId);
            yearLiteral.Text = period.DateFrom.Year + "";
            ownerNameLiteral.Text = company.FullName;
            ownerRegisterNumberLiteral.Text = company.RegisterNumber;
            ownerProvinceLiteral.Text = company.Commune.District.Province.Name;
            ownerPlaceLiteral.Text = company.Place;
            ownerPhoneLiteral.Text = company.Phone;
            ownerFaxLiteral.Text = company.Fax;
            ownerPostCodeLiteral.Text = company.PostCode;
            ownerStreetLiteral.Text = company.Street;
            ownerHomeNumberLiteral.Text = company.BuildingNumber;
            ownerFlatLiteral.Text = company.FlatNumber;
            ownerNipLiteral.Text = company.Nip;
            ownerRegonLiteral.Text = company.Regon;
            ownerPkdLiteral.Text = GetPkdList(company);
            section1TableACheckBox.Checked = true;
            section1TableBCheckBox.Checked = true;
            authorFirstNameLiteral.Text = company.BusinessFirstName;
            authorLastNameLiteral.Text = company.BusinessLastName;
            authorPhoneLiteral.Text = company.BusinessPhone;
            authorFaxLiteral.Text = company.BusinessFax;
            authorEmailLiteral.Text = company.BusinessEmail;
            dateLiteral.Text = DateTime.Now.Date.ToShortDateString();
        }

        public void UpdateCheckBoxes(bool section2TableFilled, bool section4TableFilled,
            bool section5TableAFilled, bool section5TableBFilled, bool section5TableCFilled,
            bool section6TableAFilled, bool section6TableBFilled, bool section7TableFilled)
        {
            section2CheckBox.Checked = section2TableFilled;
            section4CheckBox.Checked = section4TableFilled;
            section5TableACheckBox.Checked = section5TableAFilled;
            section5TableBCheckBox.Checked = section5TableBFilled;
            section5TableCCheckBox.Checked = section5TableCFilled;
            section6TableACheckBox.Checked = section6TableAFilled;
            section6TableBCheckBox.Checked = section6TableBFilled;
            section7CheckBox.Checked = section7TableFilled;
        }

        private string GetPkdList(Company company)
        {
            string result;

            company.CompanyPkds.Load();
            result = "";
            foreach (CompanyPkd pkd in company.CompanyPkds) result += pkd.Value + ", ";
            return result.TrimEnd(',', ' ');
        }
    }
}