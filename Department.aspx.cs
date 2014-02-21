/*
 * WLASCICIEL: amadej
 * TABELE: Department, DepartmentVehicleNumber
 * 
 * Pozwala zarządzać wstawiać, edytować i usuwać dane oddziałów firm. 
 * 
 * Kwestie do wyjaśnienia/sprawdzenia:
 * 
*/

using System;
using System.Linq;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Department1 : System.Web.UI.Page
    {

        private EVidentDataModel _database;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            if (!IsPostBack)
            {
                Panel3.Visible = false;
                InitializeDepartmentsListBox();
                if (ApplicationUser.CurrentDepartmentId != null)
                    oddzialyListBox.SelectedValue = ApplicationUser.CurrentDepartmentId.Value.ToString();
                InitializeDataPanel();

            }
        }

        private void InitializeProvinceDropDownList()
        {
            provinceDropDownList.DataSource = _database.Provinces.OrderBy(p => p.Name);
            provinceDropDownList.DataTextField = "Name";
            provinceDropDownList.DataValueField = "Id";
            provinceDropDownList.DataBind();
            
        }

        private void InitializeVehicleNumbersListBox()
        {
            long id = long.Parse(oddzialyListBox.SelectedValue);
            
            pojazdyListBox.DataSource = from p in _database.DepartmentVehicleNumbers
                                              where p.Department.Id.Equals(id)
                                              orderby p.Id
                                              select p;
            pojazdyListBox.DataTextField = "Value";
            pojazdyListBox.DataValueField = "Id";
            pojazdyListBox.DataBind();
        }

        private void InitializeDepartmentsListBox()
        {
            if (ApplicationUser.CurrentCompanyId != null)
            {
                long id = ApplicationUser.CurrentCompanyId.Value;
                oddzialyListBox.DataSource = _database.Departments.
                    Include("Company").Where(p => p.Company.Id.Equals(id)).OrderBy(p => p.Id);
            }
            oddzialyListBox.DataTextField = "FullName";
            oddzialyListBox.DataValueField = "Id";
            oddzialyListBox.DataBind();
            ListItem currentDepartmentListItem =
                oddzialyListBox.Items.FindByValue(ApplicationUser.CurrentDepartmentId.ToString());
            if (currentDepartmentListItem != null) currentDepartmentListItem.Selected = true;
            else if (oddzialyListBox.Items.Count > 0) oddzialyListBox.Items[0].Selected = true;
            //oddzialGownyCheckBox_Selected(true);
        }

        private void InitializeDepartmentData()
        {
            Department department = GetSelectedDepartment();
            nazwaTextBox.Text = department.FullName;
            kodPocztowyTextBox.Text = department.PostCode;
            miastoTextBox.Text = department.Place;
            provinceDropDownList.SelectedValue = department.Company.Commune.District.Province.Id.ToString();
            ProvinceDropDownListSelectedIndexChanged(this, EventArgs.Empty);
            ulicaTextBox.Text = department.Street;
            nrDomuTextBox.Text = department.BuildingNumber;
            nrLokaluTextBox.Text = department.FlatNumber;
            districtDropDownList.SelectedValue = department.Company.Commune.District.Id.ToString();
            DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
            communeDropDownList.SelectedValue = department.Company.Commune.Id.ToString();          
            telefonTextBox.Text = department.Phone;
            faksTextBox.Text = department.Fax;
            startDateCalendarExtender.SelectedDate = department.StartDate;
            if ( department.EndDate != null) endDateTextBox_CalendarExtender.SelectedDate = department.EndDate;
            oddzialGlownyCheckBox.Checked = department.IsMain;
            oddzialGlownyCheckBox_Selected(!department.IsMain);
            IsZSEiECheckBox.Enabled = department.Company.IsCollectingElectronics;
            if (IsZSEiECheckBox.Enabled) IsZSEiECheckBox.Checked = department.IsZSEiE;

        }

        private Department GetSelectedDepartment()
        {
            long id = long.Parse(oddzialyListBox.SelectedValue);
            return _database.Departments.Include("Company.Commune.District.Province").First(d => d.Id == id);
        }

        protected void ProvinceDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id = long.Parse(provinceDropDownList.SelectedValue);
            districtDropDownList.DataSource =
                _database.Districts.Where(d => d.Province.Id.Equals(id)).OrderBy(d => d.Name);
            districtDropDownList.DataTextField = "Name";
            districtDropDownList.DataValueField = "Id";
            districtDropDownList.DataBind();
            DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
        }

        protected void DistrictDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            long id = long.Parse(districtDropDownList.SelectedValue);
            communeDropDownList.DataSource = _database.Communes.Include("District").
                Where(c => c.District.Id == id).OrderBy(c => c.Name);
            communeDropDownList.DataTextField = "Name";
            communeDropDownList.DataValueField = "Id";
            communeDropDownList.DataBind();
        }

        protected void AddPkdButtonClick(object sender, EventArgs e)
        {
            long departmentId = long.Parse(oddzialyListBox.SelectedValue);
            _database.AddToDepartmentVehicleNumbers(new DepartmentVehicleNumber
                                                        {
                Department = _database.Departments.First(d => d.Id == departmentId),
                Value = pojazdyTextBox.Text
            });
            _database.SaveChanges();
            InitializeVehicleNumbersListBox();
        }

        protected void deletePojazdyButton_Click(object sender, EventArgs e)
        {
            if (pojazdyListBox.SelectedValue != "")
            {
                long value = long.Parse(pojazdyListBox.SelectedValue.Trim());
                _database.DeleteObject(_database.DepartmentVehicleNumbers.First(
                    pojazd => pojazd.Id == value));
                _database.SaveChanges();
                InitializeVehicleNumbersListBox();
            }
        }

        private void oddzialGlownyCheckBox_Selected(bool isNotSelected)
        {
            miastoTextBox.Enabled = isNotSelected;
            provinceDropDownList.Enabled = isNotSelected;
            ulicaTextBox.Enabled = isNotSelected;
            nrDomuTextBox.Enabled = isNotSelected;
            nrLokaluTextBox.Enabled = isNotSelected;
            kodPocztowyTextBox.Enabled = isNotSelected;
            districtDropDownList.Enabled = isNotSelected;
            DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
            telefonTextBox.Enabled = isNotSelected;
            faksTextBox.Enabled = isNotSelected;
            communeDropDownList.Enabled = isNotSelected;
        }

        protected void oddzialGlownyCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (oddzialGlownyCheckBox.Checked)
            {
                Company company = _database.GetCurrentCompany();                
                kodPocztowyTextBox.Text = company.PostCode;
                miastoTextBox.Text = company.Place;
                provinceDropDownList.SelectedValue = company.Commune.District.Province.Id.ToString();
                ProvinceDropDownListSelectedIndexChanged(this, EventArgs.Empty);
                ulicaTextBox.Text = company.Street;
                nrDomuTextBox.Text = company.BuildingNumber;
                nrLokaluTextBox.Text = company.FlatNumber;
                districtDropDownList.SelectedValue = company.Commune.District.Id.ToString();
                DistrictDropDownListSelectedIndexChanged(this, EventArgs.Empty);
                communeDropDownList.SelectedValue = company.Commune.Id.ToString();
                telefonTextBox.Text = company.Phone;
                faksTextBox.Text = company.Fax;

                oddzialGlownyCheckBox_Selected(false);                        
            }
            else if (!oddzialGlownyCheckBox.Checked)
            {
                oddzialGlownyCheckBox_Selected(true);  
                ClearDepartmentData(false);
            }            
        }

        private void ClearDepartmentData(bool all)
        {
            miastoTextBox.Text = "";
            ulicaTextBox.Text = "";
            nrDomuTextBox.Text = "";
            nrLokaluTextBox.Text = "";
            telefonTextBox.Text = "";
            faksTextBox.Text = "";

            if (all)
            {
                nazwaTextBox.Text = "";
                kodPocztowyTextBox.Text = "";
                startDateCalendarExtender.SelectedDate = null;
                startDateTextBox.Text = null;
                endDateTextBox_CalendarExtender.SelectedDate = null;                
                oddzialGlownyCheckBox.Checked = false;
                IsZSEiECheckBox.Checked = false;
                pojazdyListBox.Items.Clear();

                //communeDropDownList.Items.Clear();
                //provinceDropDownList.Items.Clear();
                //districtDropDownList.Items.Clear();
            }
        }

        private void InitializeDataPanel()
        {
            Panel3.Visible = true;            
            InitializeProvinceDropDownList();
            InitializeVehicleNumbersListBox();
            InitializeDepartmentData();
            zapiszButton.Text = "Aktualizuj";
        }

        protected void oddzialyListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            InitializeDataPanel();
        }

        protected void zapiszButton_Click(object sender, EventArgs e)
        {
            Department department = null;
            long id;

            id = Common.GetCurrentCompany().Id;
           Department oldMainDepartment =
                _database.Departments.FirstOrDefault(d => d.IsMain && d.Company.Id == id);
            switch (zapiszButton.Text)
            {
                case "Aktualizuj":
                    {
                        department = GetSelectedDepartment();
                        break;
                    }
                case "Zapisz":
                    department = new Department {Company = Common.GetCurrentCompany()};
                    break;
            }

            if (department != null) department.FullName = nazwaTextBox.Text.Trim();
            long communeId = long.Parse(communeDropDownList.SelectedValue);
            long provinceId = long.Parse(provinceDropDownList.SelectedValue);
            long districtId = long.Parse(districtDropDownList.SelectedValue);
            if (department != null)
            {
                department.Commune = _database.Communes.First(c => c.Id == communeId);
                department.Commune.District = _database.Districts.First(c => c.Id == districtId);
                department.Commune.District.Province = _database.Provinces.First(c => c.Id == provinceId);
                if (endDateTextBox.Text.Trim() != "") department.EndDate = DateTime.Parse(endDateTextBox.Text);
                else department.EndDate = null;
                department.IsMain = oddzialGlownyCheckBox.Checked;
                if (oldMainDepartment != null && oldMainDepartment.Id != department.Id) oldMainDepartment.IsMain = false;
                department.IsZSEiE = IsZSEiECheckBox.Checked;
                department.PostCode = kodPocztowyTextBox.Text.Trim();
                department.Place = miastoTextBox.Text.Trim();
                department.Street = ulicaTextBox.Text.Trim();
                department.BuildingNumber = nrDomuTextBox.Text.Trim();
                department.FlatNumber = nrLokaluTextBox.Text.Trim();
                department.Phone = telefonTextBox.Text.Trim();
                department.Fax = faksTextBox.Text.Trim();
                department.StartDate = DateTime.Parse(startDateTextBox.Text);
            }
            _database.SaveChanges();
            InitializeDepartmentsListBox();
            ClearDepartmentData(true);

        }

        protected void anulujButton_Click(object sender, EventArgs e)
        {
            ClearDepartmentData(true);
            Panel3.Visible = false;
            InitializeDepartmentsListBox();
        }

        protected void Dodaj_Click(object sender, EventArgs e)
        {
            ClearDepartmentData(true);
            Panel3.Visible = true;
            oddzialGlownyCheckBox_Selected(true);
            InitializeProvinceDropDownList();
            InitializeDepartmentsListBox();
            zapiszButton.Text = "Zapisz";
            
        }

        protected void usunButton_Click(object sender, EventArgs e)
        {
            if (oddzialyListBox.SelectedValue != null)
            {
                foreach (long i in pojazdyListBox.DataValueField)
                {
                    _database.DeleteObject(_database.DepartmentVehicleNumbers.First(
                        pojazd => pojazd.Id == i));
                    _database.SaveChanges();
                }                                  

                _database.DeleteObject(_database.Departments.First(
                    departments => departments.Id == long.Parse(oddzialyListBox.SelectedValue)));
                _database.SaveChanges();
                ClearDepartmentData(true);
                Panel3.Visible = false;
                InitializeDepartmentsListBox();
            }

            else if (oddzialyListBox.SelectedValue == null)
            {
                ClearDepartmentData(true);
                Panel3.Visible = false;
                InitializeDepartmentsListBox();
            }
        }

    }  
}
     
