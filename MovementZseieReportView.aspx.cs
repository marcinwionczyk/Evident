using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using EVident.Code;

namespace EVident
{
    public partial class MovementZSEiEReportView : Page
    {
        private EVidentDataModel _database;
        private long _companyId;
        private int _year;
        private int _half;

        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            if (!long.TryParse(Request.QueryString["Id"], out _companyId)) return;
            if (!int.TryParse(Request.QueryString["Year"], out _year)) return;
            if (!int.TryParse(Request.QueryString["Half"], out _half)) return;
            if (_half < 0 || _half > 3) return;
            double halfOfYear = Math.Ceiling((double) (2*(DateTime.Now.Month/12))) + 1;
            // sprawdzam czy otrzymane zmienne nie są jakieś wyjęte z kosmosu, n.p. wpisane ręcznie w adresie URL
            // nie generuje raportu z przyszłości
            if (_year > DateTime.Now.Year) return;
            if (_half > halfOfYear && _year == DateTime.Now.Year) return;
            Company company =
                _database.Companies.Include("Commune.District.Province").FirstOrDefault(c => c.Id == _companyId);
            if (company == null) return;
            HalfOfYear.Text = _half + " półrocze " + _year;

            GIOSRegisterNumber.Text = Common.GetRegisterNumber(company);
            CompanyFullName.Text = company.FullName;
            Province.Text = company.Commune.District.Province.Name;
            Place.Text = company.Place;
            PostCode.Text = company.PostCode;
            Street.Text = company.Street;
            BuildingNumber.Text = company.BuildingNumber;
            FlatNumber.Text = company.FlatNumber;
            NIP.Text = company.Nip;
            REGON.Text = company.Regon;
            BussinessFirstNameL.Text = company.BusinessFirstName;
            BussinessLastNameL.Text = company.BusinessLastName;
            BussinessEmailL.Text = company.BusinessEmail;
            BussinessFaxL.Text = company.BusinessFax;
            BussinessPhoneL.Text = company.Phone;
            IQueryable<Department> departments =
                _database.Departments.Where(d => d.Company.Id == _companyId && d.IsZSEiE);
            if (departments.Any())
            {
                WhereUsedEquipmentISCollected.DataSource = departments;
                WhereUsedEquipmentISCollected.DataBind();
            }
            DataColumn zseieGroup = new DataColumn("zseieGroup", typeof (string));
            DataColumn zseieCode = new DataColumn("zseieCode", typeof (string));
            DataColumn colectedZseie = new DataColumn("colectedZseie", typeof (double));
            DataColumn transferedZseie = new DataColumn("transferedZseie", typeof (double));
            DataTable table = new DataTable();
            table.Columns.Add(zseieGroup);
            table.Columns.Add(zseieCode);
            table.Columns.Add(colectedZseie);
            table.Columns.Add(transferedZseie);

            var wasteEquipment = (_database.WasteRecordCardElements.Where(b =>
                                                                          (b.Kind == 3 ^ b.Kind == -9) &&
                                                                          b.WasteRecordCard.Department.Company.Id ==
                                                                          _companyId &&
                                                                          b.ZseieCode != null && b.ZseieCode1 != null).
                Select(b => new
                                {
                                    ZseieKind = b.ZseieCode1.Name + " " + b.ZseieCode1.Description,
                                    ZseieCod = b.ZseieCode.Name + " " + b.ZseieCode.Description,
                                    b.Kind,
                                    b.ReceivedMass,
                                    b.IsFromHome,
                                    b.TransferMass
                                }))
                .GroupBy(a => new {a.ZseieKind, a.ZseieCod}).Select(g => new
                                                                             {
                                                                                 g.Key.ZseieKind,
                                                                                 g.Key.ZseieCod,
                                                                                 ReceivedMassFromHomeSum =
                                                                             g.Where(b => b.IsFromHome).Sum(
                                                                                 b => (double?) b.ReceivedMass),
                                                                                 ReceivedFromOthersSum =
                                                                             g.Where(b => b.IsFromHome == false).Sum(
                                                                                 b => (double?) b.ReceivedMass),
                                                                                 TransferedSum =
                                                                             g.Sum(b => (double?) b.TransferMass)
                                                                             });
            var firstOrDefault = wasteEquipment.FirstOrDefault();
            if (firstOrDefault == null) return;
            DataCollectedAboutWasteEquipment.DataSource = wasteEquipment;
            DataCollectedAboutWasteEquipment.DataBind();
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