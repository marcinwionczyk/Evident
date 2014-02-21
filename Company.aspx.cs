/*
 * WLASCICIEL: phalladin
 * TABELE: Company, CompanyPkd
 * 
 * Strona pozwalająca edytować dane firmy. Tabela CompanyPkd zawiera kody PKD, danej firmy.
*/

using System;
using System.Linq;
using EVident.Code;

namespace EVident
{
    public partial class Company1 : System.Web.UI.Page
    {
        private EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            database = Common.GetDataModel();
            if (!IsPostBack) FillUi();
        }

        private void FillUi()
        {
            InitializeProvinceDropDownList();
            Company company = database.GetCurrentCompany();
            loginTextBox.Text = company.Login;
            fullNameTextBox.Text = company.FullName;
            shortNameTextBox.Text = company.ShortName;
            registerNumberTextBox.Text = company.RegisterNumber;
            provinceDropDownList.SelectedValue = company.Commune.District.Province.Id + "";
            ProvinceDropDownListSelectedIndexChanged(this, EventArgs.Empty);
            districtDropDownList.SelectedValue = company.Commune.District.Id + "";
            DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
            communeDropDownList.SelectedValue = company.Commune.Id + "";
            placeTextBox.Text = company.Place;
            streetTextBox.Text = company.Street;
            buildingNumberTextBox.Text = company.BuildingNumber;
            flatNumberTextBox.Text = company.FlatNumber;
            postCodeTextBox.Text = company.PostCode;
            nipTextBox.Text = company.Nip;
            regonTextBox.Text = company.Regon;
            phoneTextBox.Text = company.Phone;
            faxTextBox.Text = company.Fax;
            emailTextBox.Text = company.Email;
            startDateTextBox.Text = company.StartDate.ToString("yyyy-MM-dd");
            if (company.EndDate != null) endDateTextBox.Text = company.EndDate.Value.ToString("yyyy-MM-dd");
            businessFirstNameTextBox.Text = company.BusinessFirstName;
            businessLastNameTextBox.Text = company.BusinessLastName;
            businessPhoneTextBox.Text = company.BusinessPhone;
            businessFaxTextBox.Text = company.BusinessFax;
            businessEmailTextBox.Text = company.BusinessEmail;
            TBRegisterNumber.Text = company.GIOSRegisterNumber;
            EconomicActivityCheckBoxList1.Items[0].Selected = company.IsSellingElectronics;
            EconomicActivityCheckBoxList1.Items[1].Selected = company.IsRecoveringElectronics;
            EconomicActivityCheckBoxList1.Items[2].Selected = company.IsCollectingElectronics;
            EconomicActivityCheckBoxList1.Items[3].Selected = company.IsProcessingElectronics;
            EconomicActivityCheckBoxList2.Items[0].Selected = company.IsRecyclingElectronics;
            EconomicActivityCheckBoxList2.Items[1].Selected = company.IsSomeElseElectronics;
            EconomicActivityCheckBoxList2.Items[2].Selected = company.IsSellingBattery;
            EconomicActivityCheckBoxList2.Items[3].Selected = company.IsProcessingBattery;
            ReloadPkdList();
        }

        private void InitializeProvinceDropDownList()
        {
            provinceDropDownList.DataSource = from p in database.Provinces
                                              orderby p.Name
                                              select p;
            provinceDropDownList.DataTextField = "Name";
            provinceDropDownList.DataValueField = "Id";
            provinceDropDownList.DataBind();
        }

        protected void ProvinceDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id;

            id = long.Parse(provinceDropDownList.SelectedValue);
            districtDropDownList.DataSource = from d in database.Districts
                                              where d.Province.Id.Equals(id)
                                              orderby d.Name
                                              select d;
            districtDropDownList.DataTextField = "Name";
            districtDropDownList.DataValueField = "Id";
            districtDropDownList.DataBind();
            DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
        }

        protected void DistrictDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id;

            id = long.Parse(districtDropDownList.SelectedValue);
            communeDropDownList.DataSource = from c in database.Communes
                                             where c.District.Id.Equals(id)
                                             orderby c.Name
                                             select c;
            communeDropDownList.DataTextField = "Name";
            communeDropDownList.DataValueField = "Id";
            communeDropDownList.DataBind();
        }

        protected void UpdateButtonClick(object sender, EventArgs e)
        {
            Company company = database.GetCurrentCompany();
            company.Login = loginTextBox.Text.Trim();
            company.FullName = fullNameTextBox.Text.Trim();
            company.ShortName = shortNameTextBox.Text.Trim();
            company.RegisterNumber = registerNumberTextBox.Text.Trim();
            long communeId = long.Parse(communeDropDownList.SelectedValue);
            company.Commune = database.Communes.First(c => c.Id == communeId);
            company.Place = placeTextBox.Text.Trim();
            company.Street = streetTextBox.Text.Trim();
            company.BuildingNumber = buildingNumberTextBox.Text.Trim();
            company.FlatNumber = flatNumberTextBox.Text.Trim();
            company.Nip = nipTextBox.Text.Trim();
            company.Regon = regonTextBox.Text.Trim();
            company.Phone = phoneTextBox.Text.Trim();
            company.Fax = faxTextBox.Text.Trim();
            company.Email = emailTextBox.Text.Trim();
            company.StartDate = DateTime.Parse(startDateTextBox.Text);
            if (endDateTextBox.Text.Trim() != "") company.EndDate = DateTime.Parse(endDateTextBox.Text);
            else company.EndDate = null;
            company.BusinessFirstName = businessFirstNameTextBox.Text.Trim();
            company.BusinessLastName = businessLastNameTextBox.Text.Trim();
            company.BusinessPhone = businessPhoneTextBox.Text.Trim();
            company.BusinessFax = businessFaxTextBox.Text.Trim();
            company.BusinessEmail = businessEmailTextBox.Text.Trim();
            company.PostCode = postCodeTextBox.Text;
            company.GIOSRegisterNumber = TBRegisterNumber.Text;
            company.IsSellingElectronics = EconomicActivityCheckBoxList1.Items[0].Selected;
            company.IsRecoveringElectronics = EconomicActivityCheckBoxList1.Items[1].Selected;
            company.IsCollectingElectronics = EconomicActivityCheckBoxList1.Items[2].Selected;
            company.IsProcessingElectronics = EconomicActivityCheckBoxList1.Items[3].Selected;
            company.IsRecyclingElectronics = EconomicActivityCheckBoxList2.Items[0].Selected;
            company.IsSomeElseElectronics = EconomicActivityCheckBoxList2.Items[1].Selected;
            company.IsSellingBattery = EconomicActivityCheckBoxList2.Items[2].Selected;
            company.IsProcessingBattery = EconomicActivityCheckBoxList2.Items[3].Selected;
            database.SaveChanges();
        }

        protected void AddPkdButtonClick(object sender, EventArgs e)
        {
            database.AddToCompanyPkds(new CompanyPkd()
            {
                Company = database.GetCurrentCompany(),
                Value = pkdTextBox.Text
            });

            database.SaveChanges();
            ReloadPkdList();
        }

        protected void DeletePkdButtonClick(object sender, EventArgs e)
        {
            if (pkdListBox.SelectedValue == "") return;
            long pkdId = long.Parse(pkdListBox.SelectedValue);
            database.DeleteObject(database.CompanyPkds.First(
                pkd => pkd.Id == pkdId));
            database.SaveChanges();
            ReloadPkdList();
        }

        private void ReloadPkdList()
        {
            pkdListBox.DataSource =
                database.CompanyPkds.Include("Company").Where(pkd => pkd.Company.Id == ApplicationUser.CurrentCompanyId).OrderBy(
                    pkd => pkd.Value);
            pkdListBox.DataTextField = "Value";
            pkdListBox.DataValueField = "Id";
            pkdListBox.DataBind();
        }

  
  
    }
}
