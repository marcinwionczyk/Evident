using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class MovementBatteryReportView : Page
    {
        private EVidentDataModel _database;
        private int _year;
        private long _companyId;
        private double _sum3;
        private double _sum4;
        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            if (!long.TryParse(Request.QueryString["Id"], out _companyId)) return;
            if (!int.TryParse(Request.QueryString["Year"], out _year)) return;
            //Tabela I. DANE ZBIERAJĄCEGO ZUŻYTE BATERIE LUB ZUŻYTE AKUMULATORY
            YearL.Text = _year.ToString();
            Company company = _database.Companies.
                Include("Commune.District.Province").FirstOrDefault(c => c.Id == _companyId);
            if (company == null) return;
            MarshalProvinceL.Text = company.Commune.District.Province.Name + "GO";
            CompanyNameL.Text = company.FullName;
            CompanyProvinceL.Text = company.Commune.District.Province.Name;
            CompanyPlaceL.Text = company.Place;
            CompanyPostCodeL.Text = company.PostCode;
            CompanyStreetL.Text = company.Street;
            CompanyBuildingNumberL.Text = company.BuildingNumber;
            CompanyFlatNumber.Text = company.FlatNumber;
            CompanyNIPL.Text = company.Nip;
            CompanyREGONL.Text = company.Regon;
            BussinessFirstNameL.Text = company.BusinessFirstName;
            BussinessLastNameL.Text = company.BusinessLastName;
            BussinessFaxL.Text = company.BusinessFax;
            BussinessPhoneL.Text = company.BusinessPhone;
            BussinessEmailL.Text = company.BusinessEmail;

            /*Tabela II. DANE DOTYCZĄCE MASY ZEBRANYCH ZUŻYTYCH BATERII PRZENOŚNYCH I 
            **            ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH OGÓŁEM
            ** Zakładam, że to ma być masa baterii wprowadzonych poprzez CollectionBattery.aspx
            */
            var batteryReceivedMasses =
                _database.WasteRecordCardElements.Where(
                    w => w.Kind == 4 && w.WasteRecordCard.Department.Company.Id == _companyId && w.Date.Year == _year).
                    GroupBy(w => w.WasteRecordCard.WasteCode.Id).Select(
                        w => new {Id = w.Key, sum = w.Sum(c => c.ReceivedMass)});
            var weight1 = batteryReceivedMasses.FirstOrDefault(w => w.Id == 783);
            Weight160601L2.Text = weight1 == null ? "0,00" : (weight1.sum*1000).ToString("N2");
            var weight2 = batteryReceivedMasses.FirstOrDefault(w => w.Id == 784);
            Weight160602L2.Text = weight2 == null ? "0,00" : (weight2.sum*1000).ToString("N2");
            Weight16060345L2.Text =
                (batteryReceivedMasses.Where(w => w.Id >= 785 && w.Id <= 787).Select(w => w.sum).Sum()*1000).ToString(
                    "N2");
            var weight3 = batteryReceivedMasses.FirstOrDefault(w => w.Id == 1032);
            Weight200133L2.Text = weight3 != null ? (weight3.sum*1000).ToString("N2") : "0,00";
            var weight4 = batteryReceivedMasses.FirstOrDefault(w => w.Id == 1033);
            Weight200134L2.Text = weight4 != null ? (weight4.sum*1000).ToString("N2") : "0,00";
            WeightSumL2.Text = (batteryReceivedMasses.Select(w => w.sum).Sum()*1000).ToString("N2");
            /*Tabela III. DANE DOTYCZĄCE MASY ZEBRANYCH ZUŻYTYCH BATERII PRZENOŚNYCH
            **            I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH ZEBRANYCH BEZPOŚREDNIO DLA
            **            WPROWADZAJĄCEGO BATERIE LUB AKUMULATORY
             *
             * komentarz: Wprowadzający na rynek baterie, akumulatory (importer, producent) ma ustatwowy obowiązek
             *            zorganizować zbiórkę zużytych baterii w swoim regionie i przekazywania ich do firmy 
             *            zajmującej się recyklingiem lub unieszkodliwianiem baterii ("nas")
             */
            var table3 =
                _database.WasteRecordCardElements.Where(
                    w =>
                    w.Kind == 4 && w.WasteRecordCard.Department.Company.Id == _companyId && w.Date.Year == _year &&
                    w.WasteTransferCard.Contractor.IsSellingBattery).
                        GroupBy(w => w.WasteTransferCard.Contractor).
                        Select(w => new {contractor = w.Key, mass = w.Sum(c => c.ReceivedMass)});
            DataTable table3Data = new DataTable();
            DataColumn numerData = new DataColumn("numer",typeof(string));
            DataColumn nameData = new DataColumn("name",typeof(string));
            DataColumn name2Data = new DataColumn("name", typeof(string));
            DataColumn massData = new DataColumn("mass", typeof(double));
            DataColumn mass2Data = new DataColumn("mass", typeof(double));
            table3Data.Columns.Add(numerData);
            table3Data.Columns.Add(nameData);
            table3Data.Columns.Add(massData);
            if (table3.Any())
            {
                _sum3 = 0;
                foreach (var dataTableRow in table3)
                {
                    DataRow newRow = table3Data.NewRow();
                    newRow["numer"] = Common.GetRegisterNumber(dataTableRow.contractor);
                    newRow["name"] = dataTableRow.contractor.FullName;
                    newRow["mass"] = dataTableRow.mass*1000;
                    _sum3 += dataTableRow.mass*1000;
                    table3Data.Rows.Add(newRow);
                }
            }
            else
            {
                DataRow newRow = table3Data.NewRow();
                newRow["numer"] = "";
                newRow["name"] = "";
                newRow["mass"] = 0;
                table3Data.Rows.Add(newRow);
            }
            Table3Repeater.DataSource = table3Data;
            Table3Repeater.DataBind();
            /*
             *Tabela IV.DANE DOTYCZĄCE MASY ZEBRANYCH BATERII PRZENOŚNYCH
             *          I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH ZEBRANYCH DLA INNYCH
             *          PODMIOTÓW 
             *          
             * komentarz: masa zebranych baterii dla podmiotów innych niż w powyższej tabeli z którymi 
             * jest podpisana umowa na zbiórkę baterii
             */
            var table4 = _database.WasteRecordCardElements.Where(
                    w =>
                    w.Kind == 4 && w.WasteRecordCard.Department.Company.Id == _companyId && w.Date.Year == _year &&
                    w.WasteTransferCard.Contractor.IsSellingBattery == false).
                        GroupBy(w => w.WasteTransferCard.Contractor).
                        Select(w => new {contractor = w.Key, mass = w.Sum(c => c.ReceivedMass)});
            DataTable table4Data = new DataTable();
            DataColumn addressData = new DataColumn("address", typeof(string));
            table4Data.Columns.Add(name2Data);
            table4Data.Columns.Add(addressData);
            table4Data.Columns.Add(mass2Data);
            if (table4.Any())
            {
                _sum4 = 0;
                foreach (var dataTableRow in table4)
                {
                    DataRow newRow = table4Data.NewRow();
                    newRow["name"] = dataTableRow.contractor.FullName;
                    newRow["address"] = Common.GetAddress(dataTableRow.contractor, true) + " <br/> Numer rejestrowy: " + Common.GetRegisterNumber(dataTableRow.contractor);
                    newRow["mass"] = dataTableRow.mass * 1000;
                    _sum4 += dataTableRow.mass * 1000;
                    table4Data.Rows.Add(newRow);
                }
            }
            else
            {
                DataRow newRow = table4Data.NewRow();
                newRow["name"] = "";
                newRow["address"] = "";
                newRow["mass"] = 0;
                table4Data.Rows.Add(newRow);
            }
            Table4Repeater.DataSource = table4Data;
            Table4Repeater.DataBind();
        }

        protected void Table4RepeaterItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                Literal sum4Literal = e.Item.FindControl("Table4Sum") as Literal;
                if (sum4Literal != null) sum4Literal.Text = _sum4.ToString("N2");
            }
        }

        protected void Table3RepeaterItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                Literal sum3Literal = e.Item.FindControl("Table3Sum") as Literal;
                if (sum3Literal != null) sum3Literal.Text = _sum3.ToString("N2");
            }
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