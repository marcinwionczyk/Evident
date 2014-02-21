/*
 * WLASCICIEL: mwionczyk
 * TABELE: Contractor, ContractorWasteCode, ContractorVehicleNumber
 * 
 * Strona pozwalająca wstawiać, edytować i usuwać dane kontrahentów.
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Contractor1 : Page
    {
        private long _contractorId;
        private EVidentDataModel _database;

        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            if (Page.IsPostBack) return;
            var wasteCodes =
                _database.WasteCodes.Where(w => w.Level > 1).Select(
                    w => new {w.Id, Opis = w.Name + " " + w.Description});
            ListBoxWasteCodes.DataSource = wasteCodes;
            ListBoxWasteCodes.DataTextField = "Opis";
            ListBoxWasteCodes.DataValueField = "Id";
            ListBoxWasteCodes.DataBind();
            GridViewContractorsDataBind();
            IQueryable<Province> provinces = _database.Provinces;
            ProvinceList.DataSource = provinces;
            ProvinceList.DataBind();
            long provinceId = provinces.First().Id;
            IQueryable<District> districts = _database.Districts.Where(d => d.Province.Id == provinceId);
            DistrictList.DataSource = districts;
            DistrictList.DataBind();
            long districtId = districts.First().Id;
            IQueryable<Commune> communes = _database.Communes.Where(c => c.District.Id == districtId);
            CommuneList.DataSource = communes;
            CommuneList.DataBind();
        }

        private void GridViewContractorsDataBind()
        {
            IQueryable<Contractor> contractors = _database.Contractors.
                Include("WasteRecordCardElements").
                Include("WasteTransferCards1").
                Include("WasteTransferCards").
                Where(c => c.Company.Id == ApplicationUser.CurrentCompanyId);
            GridViewContractors.DataSource = contractors;
            GridViewContractors.DataBind();
        }

        protected void ButtonNewContractorClick(object sender, EventArgs e)
        {
            ContractorEdit(null);
        }

        protected void ListBoxVehicleNumbersSelectedIndexChanged(object sender, EventArgs e)
        {
            VehicleNumberErrors.Text = "";
            TBSelectedVehicleNumber.Text = ListBoxVehicleNumbers.SelectedItem.Text;
        }

        protected void BtnAddVehicleNumberClick(object sender, EventArgs e)
        {
            if (TBSelectedVehicleNumber.Text == String.Empty) return;
            VehicleNumberErrors.Text = "";
            IQueryable<ContractorVehicleNumber> vehicleNumbersFromDataBase;
            if (long.TryParse(ContractorIdHiddenField.Value, out _contractorId))
            {
                vehicleNumbersFromDataBase = _database.ContractorVehicleNumbers.Where(
                    c => c.Value == TBSelectedVehicleNumber.Text && c.Contractor.Id == _contractorId);
            }
            else
            {
                vehicleNumbersFromDataBase = _database.ContractorVehicleNumbers.Where(
                    c => c.Value == TBSelectedVehicleNumber.Text);
            }
            //Jeżeli nowy ListItem jest w bazie i jest na listboksie, w nowym ListItem nadaj value wartość z bazy danych
            if (vehicleNumbersFromDataBase.Any() &&
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text) != null)
            {
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text).Value =
                    vehicleNumbersFromDataBase.First().Id.ToString();
                VehicleNumberErrors.Text = Common.CANT_INSERT_ROW;
            }
            //Jeżeli nowy ListItem jest w bazie i nie ma na listboksie, w nowym ListItem nadaj wartościon value i tekst wartości pobrane z bazy danych
            if (vehicleNumbersFromDataBase.Any() &&
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text) == null)
            {
                ListBoxVehicleNumbers.Items.Add(new ListItem(TBSelectedVehicleNumber.Text.ToUpper(),
                                                             vehicleNumbersFromDataBase.First().Id.ToString()));
            }
            //Jeżeli nowego ListItem nie ma w bazie i jest na listboksie. Zmień w ListItem wartość value na -1
            if (!vehicleNumbersFromDataBase.Any() &&
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text) != null)
            {
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text).Value = "-1";
            }
            //Jeżeli nowego ListItem nie ma w bazie i nie ma na listboksie. Wstaw do ListBoxa ListItem z wartością value = -1
            // i teksem z TBSelectedVehicleNumber.Text
            if (!vehicleNumbersFromDataBase.Any() &&
                ListBoxVehicleNumbers.Items.FindByText(TBSelectedVehicleNumber.Text) == null)
            {
                ListBoxVehicleNumbers.Items.Add(new ListItem(TBSelectedVehicleNumber.Text.ToUpper(), "-1"));
            }
            if (vehicleNumbersFromDataBase.Count(c => !c.WasteRecordCardElements.Any()) > 2)
                for (int i = 0; i < vehicleNumbersFromDataBase.Count(c => !c.WasteRecordCardElements.Any()) - 1; i++)
                {
                    try
                    {
                        _database.DeleteObject(vehicleNumbersFromDataBase.ToList()[i]);
                        _database.SaveChanges();
                    }
                    catch
                    {
                        VehicleNumberErrors.Text = Common.CANT_INSERT_ROW;
                    }
                }
        }

        protected void BtnRemoveVehicleNumberClick(object sender, EventArgs e)
        {
            if (ListBoxVehicleNumbers.SelectedIndex == -1) return;
            if (ListBoxVehicleNumbers.SelectedItem.Value == "-1") return;
            _contractorId = long.Parse(ContractorIdHiddenField.Value);
            VehicleNumberErrors.Text = "";
            List<ContractorVehicleNumber> vehicleNumbersFromDataBase =
                _database.ContractorVehicleNumbers.Where(
                    c => c.Value == ListBoxVehicleNumbers.SelectedItem.Text && c.Contractor.Id == _contractorId).ToList();
            foreach (ContractorVehicleNumber contractorVehicleNumber in vehicleNumbersFromDataBase)
            {
                try
                {
                    _database.DeleteObject(contractorVehicleNumber);
                    _database.SaveChanges();
                    ListItem item = ListBoxVehicleNumbers.SelectedItem;
                    ListBoxVehicleNumbers.Items.Remove(item);
                }
                catch
                {
                    VehicleNumberErrors.Text = Common.CANT_DELETE_ROW;
                }
            }
        }

        protected void ListBoxWasteCodesSelectedIndexChanged(object sender, EventArgs e)
        {
            if (!ListBoxSelectedWasteCodes.Items.Contains(ListBoxWasteCodes.SelectedItem))
            {
                ListItem item = ListBoxWasteCodes.SelectedItem;
                long wasteCodeId = long.Parse(item.Value);
                if (long.TryParse(ContractorIdHiddenField.Value, out _contractorId))
                {
                    ContractorWasteCode wasteCode = new ContractorWasteCode
                                                        {
                                                            Contractor =
                                                                _database.Contractors.First(c => c.Id == _contractorId),
                                                            WasteCode =
                                                                _database.WasteCodes.First(w => w.Id == wasteCodeId)
                                                        };
                    _database.AddToContractorWasteCodes(wasteCode);
                    _database.SaveChanges();
                }
                ListBoxSelectedWasteCodes.Items.Add(item);
            }
        }

        protected void BtnRemoveWasteCodeClick(object sender, EventArgs e)
        {
            while (ListBoxSelectedWasteCodes.Items.Contains(ListBoxSelectedWasteCodes.SelectedItem))
            {
                long wasteCodeId = long.Parse(ListBoxSelectedWasteCodes.SelectedItem.Value);
                ListBoxSelectedWasteCodes.Items.Remove(ListBoxSelectedWasteCodes.SelectedItem);
                if (!long.TryParse(ContractorIdHiddenField.Value, out _contractorId)) continue;
                ContractorWasteCode contractorWaste =
                    _database.ContractorWasteCodes.FirstOrDefault(
                        c => c.Contractor.Id == _contractorId && c.WasteCode.Id == wasteCodeId);
                if (contractorWaste != null) _database.DeleteObject(contractorWaste);
                _database.SaveChanges();
            }
        }

        //sprawdź czy nowa nazwa istnieje w bazie lub na ListBoksie. Jeżeli tak to nie zmieniaj nazwy
        protected void BtnChangeVehicleNumberClick(object sender, EventArgs e)
        {
            if (ListBoxVehicleNumbers.SelectedItem == null) return;
            if (ListBoxVehicleNumbers.SelectedItem.Text == TBSelectedVehicleNumber.Text)
            {
                VehicleNumberErrors.Text = Common.CANT_UPDATE_ROW;
                return;
            }
            VehicleNumberErrors.Text = "";
            IQueryable<ContractorVehicleNumber> existingVehicleNumbersInDb =
                _database.ContractorVehicleNumbers.Where(c => c.Value == TBSelectedVehicleNumber.Text);
            ContractorVehicleNumber contractorVehicleNumber = existingVehicleNumbersInDb.FirstOrDefault();
            long contractorVehicleNumberId = contractorVehicleNumber == null ? -1 : contractorVehicleNumber.Id;
            var item = new ListItem(TBSelectedVehicleNumber.Text, contractorVehicleNumberId.ToString());
            if (!existingVehicleNumbersInDb.Any() || !ListBoxVehicleNumbers.Items.Contains(item))
                ListBoxVehicleNumbers.SelectedItem.Text = TBSelectedVehicleNumber.Text;
            else
            {
                VehicleNumberErrors.Text = Common.CANT_UPDATE_ROW;
            }
        }

        protected void SaveContractorButtonClick(object sender, EventArgs e)
        {
            long contractorid;
            if (long.TryParse(ContractorIdHiddenField.Value, out contractorid))
            {
                ContractorUpdate(contractorid);
            }
            else
            {
                ContractorUpdate(null);
            }
        }

        /// <summary>
        /// Przygotowanie formatek do edycji / tworzenia nowego kontrahenta
        /// </summary>
        /// <param name="selectedId">Id kontrahenta z bazy danych, jeżeli null tworzy nowego kontrahenta</param>
        private void ContractorEdit(long? selectedId)
        {
            if (selectedId == null)
            {
                TBBuildingNumber.Text = TBFax.Text = TBFlatNumber.Text =
                                                     TBFullName.Text =
                                                     TBNIP.Text =
                                                     TBPhone.Text =
                                                     TBPlace.Text =
                                                     TBStreet.Text =
                                                     TBRegisterNumber.Text =
                                                     TBPostCode.Text = TBREGON.Text = TBShortName.Text = "";
                foreach(ListItem item in EconomicActivityCheckBoxList.Items)
                {
                    item.Selected = false;
                }
                ListBoxVehicleNumbers.Items.Clear();
                ListBoxSelectedWasteCodes.Items.Clear();
                ContractorIdHiddenField.Value = "";
            }
            else
            {
                ContractorIdHiddenField.Value = selectedId.ToString();
                Contractor contractorToEdit = _database.Contractors.
                    Include("ContractorVehicleNumbers").
                    Include("ContractorWasteCodes.WasteCode").
                    Include("Commune.District.Province").First(c => c.Id == selectedId);
                TBBuildingNumber.Text = contractorToEdit.BuildingNumber.ToUpper();
                TBFax.Text = contractorToEdit.Fax;
                TBFlatNumber.Text = contractorToEdit.FlatNumber;
                TBFullName.Text = contractorToEdit.FullName;
                TBShortName.Text = contractorToEdit.ShortName;
                TBNIP.Text = contractorToEdit.Nip;
                TBPhone.Text = contractorToEdit.Phone;
                TBPlace.Text = contractorToEdit.Place;
                TBPostCode.Text = contractorToEdit.PostCode;
                TBStreet.Text = contractorToEdit.Street;
                TBREGON.Text = contractorToEdit.Regon;
                TBRegisterNumber.Text = contractorToEdit.RegisterNumber;
                ListItem provinceListItem =
                    ProvinceList.Items.FindByValue(contractorToEdit.Commune.District.Province.Id.ToString());
                ProvinceList.ClearSelection();
                provinceListItem.Selected = true;
                ProvinceList_SelectedIndexChanged(ProvinceList, EventArgs.Empty);
                ListItem districtListItem =
                    DistrictList.Items.FindByValue(contractorToEdit.Commune.District.Id.ToString());
                if (districtListItem != null)
                {
                    DistrictList.ClearSelection();
                    districtListItem.Selected = true;
                }
                DistrictList_SelectedIndexChanged(DistrictList, EventArgs.Empty);
                ListItem communeListItem = CommuneList.Items.FindByValue(contractorToEdit.Commune.Id.ToString());
                if (communeListItem != null)
                {
                    CommuneList.ClearSelection();
                    communeListItem.Selected = true;
                }
                EconomicActivityCheckBoxList.Items[0].Selected = contractorToEdit.IsSellingElectronics;
                EconomicActivityCheckBoxList.Items[1].Selected = contractorToEdit.IsRecoveringElectronics;
                EconomicActivityCheckBoxList.Items[2].Selected = contractorToEdit.IsCollectingElectronics;
                EconomicActivityCheckBoxList.Items[3].Selected = contractorToEdit.IsProcessingElectronics;
                EconomicActivityCheckBoxList.Items[4].Selected = contractorToEdit.IsRecyclingElectronics;
                EconomicActivityCheckBoxList.Items[5].Selected = contractorToEdit.IsSomeElseElectronics;
                EconomicActivityCheckBoxList.Items[6].Selected = contractorToEdit.IsSellingBattery;
                EconomicActivityCheckBoxList.Items[7].Selected = contractorToEdit.IsProcessingBattery;
                foreach (
                    ContractorVehicleNumber vehicleNumber in
                        contractorToEdit.ContractorVehicleNumbers.OrderBy(c => c.Value))
                {
                    var item = new ListItem(vehicleNumber.Value, vehicleNumber.Id.ToString());
                    ListBoxVehicleNumbers.Items.Add(item);
                }
                foreach (
                    ContractorWasteCode wasteCode in
                        contractorToEdit.ContractorWasteCodes.OrderBy(c => c.WasteCode.Id).ToArray())
                {
                    // ::: TEN FRAGMENT CZĘSTO POWODUJE NullReferenceException (phalladin)
                    // ### Już nie powoduje (marcin)
                    var item = new ListItem(wasteCode.WasteCode.Name + " " + wasteCode.WasteCode.Description,
                                            wasteCode.WasteCode.Id.ToString());
                    ListBoxSelectedWasteCodes.Items.Add(item);
                }
            }
            ContractorEditPanel.Visible = true;
            ContractorDetailsPanel.Visible = false;
        }

        /// <summary>
        /// Zapisywanie do bazy danych zaktualizowanych danych istniejącego lub nowego kontrahenta. 
        /// </summary>
        /// <param name="contractorId">Id kontrahenta, jeżeli null tworzy nowego kontrahenta, </param>
        private void ContractorUpdate(long? contractorId)
        {
            if (!IsValid) return;
            Contractor contractor = contractorId == null
                                        ? new Contractor()
                                        : _database.Contractors.First(c => c.Id == contractorId);
            contractor.ShortName = TBShortName.Text;
            contractor.FullName = TBFullName.Text;
            long id = long.Parse(CommuneList.SelectedValue);
            contractor.Commune = _database.Communes.First(c => c.Id == id);
            contractor.Company = _database.GetCurrentCompany();
            contractor.Nip = TBNIP.Text;
            contractor.Phone = TBPhone.Text;
            contractor.Place = TBPlace.Text;
            contractor.PostCode = TBPostCode.Text;
            contractor.Regon = TBREGON.Text;
            contractor.Street = TBStreet.Text;
            contractor.BuildingNumber = TBBuildingNumber.Text;
            contractor.FlatNumber = TBFlatNumber.Text;
            contractor.Fax = TBFax.Text;
            contractor.RegisterNumber = TBRegisterNumber.Text;
            contractor.IsSellingElectronics = EconomicActivityCheckBoxList.Items[0].Selected;
            contractor.IsRecoveringElectronics = EconomicActivityCheckBoxList.Items[1].Selected;
            contractor.IsCollectingElectronics = EconomicActivityCheckBoxList.Items[2].Selected;
            contractor.IsProcessingElectronics = EconomicActivityCheckBoxList.Items[3].Selected;
            contractor.IsRecyclingElectronics = EconomicActivityCheckBoxList.Items[4].Selected;
            contractor.IsSomeElseElectronics = EconomicActivityCheckBoxList.Items[5].Selected;
            contractor.IsSellingBattery = EconomicActivityCheckBoxList.Items[6].Selected;
            contractor.IsProcessingBattery = EconomicActivityCheckBoxList.Items[7].Selected;

            if (contractorId == null)
            {
                _database.AddToContractors(contractor);
            }
            _database.SaveChanges();
            // dodaj do bazy danych wszystkie nowe numery rejestracyjne
            foreach (ListItem item in ListBoxVehicleNumbers.Items)
            {
                if (item.Value != "-1") continue;
                var cVehicleNumber =
                    new ContractorVehicleNumber {Value = item.Text, Contractor = contractor};
                _database.AddToContractorVehicleNumbers(cVehicleNumber);
            }
            _database.SaveChanges();
            if (contractorId == null)
            {
                foreach (ListItem item in ListBoxSelectedWasteCodes.Items)
                {
                    long wasteCodeId = long.Parse(item.Value);
                    ContractorWasteCode newWasteCode = new ContractorWasteCode
                                                           {
                                                               Contractor = contractor,
                                                               WasteCode =
                                                                   _database.WasteCodes.First(w => w.Id == wasteCodeId)
                                                           };
                    _database.AddToContractorWasteCodes(newWasteCode);
                }
                _database.SaveChanges();
            }
            ContractorEditPanel.Visible = false;
            ContractorDetailsPanel.Visible = false;
            Response.Redirect("~/Contractor.aspx");
        }

        protected void CancelButtonClick(object sender, EventArgs e)
        {
            TBBuildingNumber.Text = TBFax.Text = TBFlatNumber.Text =
                                                 TBFullName.Text =
                                                 TBNIP.Text =
                                                 TBPhone.Text =
                                                 TBPlace.Text = TBPostCode.Text = TBREGON.Text = TBShortName.Text = "";
            ListBoxVehicleNumbers.Items.Clear();
            ListBoxSelectedWasteCodes.Items.Clear();
            ContractorIdHiddenField.Value = "";
            ContractorEditPanel.Visible = false;
            ContractorDetailsPanel.Visible = false;
            Response.Redirect("~/Contractor.aspx");
        }

        protected void ProvinceList_SelectedIndexChanged(object sender, EventArgs e)
        {
            long provinceId = long.Parse(ProvinceList.SelectedValue);
            IQueryable<District> districts = _database.Districts.Where(d => d.Province.Id == provinceId);
            DistrictList.DataSource = districts;
            DistrictList.DataBind();
            long districtId = long.Parse(DistrictList.SelectedValue);
            IQueryable<Commune> communes = _database.Communes.Where(c => c.District.Id == districtId);
            CommuneList.DataSource = communes;
            CommuneList.DataBind();
        }

        protected void DistrictList_SelectedIndexChanged(object sender, EventArgs e)
        {
            long districtId = long.Parse(DistrictList.SelectedValue);
            IQueryable<Commune> communes = _database.Communes.Where(c => c.District.Id == districtId);
            CommuneList.DataSource = communes;
            CommuneList.DataBind();
        }

        /// <summary>
        /// 
        /// </summary>

        #region Walidatory

        // ReSharper disable ReturnValueOfPureMethodIsNotUsed
        // ReSharper disable LoopCanBeConvertedToQuery
        /// <summary>
        /// Walidacja numeru NIP poprzez CustomValidator
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ValidateNip(object sender, ServerValidateEventArgs e)
        {

            string strippedNip = Regex.Replace(e.Value, "[-]", "");
            if (strippedNip.Length != 10)
            {
                e.IsValid = false;
                return;
            }

            try
            {
                ulong.Parse(strippedNip);
            }

            catch
            {
                e.IsValid = false;
                return;
            }
            int checkDigit = int.Parse(strippedNip.Substring(9, 1));
            int[] weights = {6, 5, 7, 2, 3, 4, 5, 6, 7};
            int sum = 0;
            for (int i = 0; i < weights.Length; i++)
                sum += int.Parse(strippedNip.Substring(i, 1))*weights[i];
            e.IsValid = ((sum%11) == checkDigit);
        }

        /// <summary>
        /// Walidacja numeru REGON poprzez CustomValidator
        /// </summary>
        /// <see cref="http://pl.wikipedia.org/wiki/REGON"/>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ValidateREGON(object sender, ServerValidateEventArgs e)
        {
            string strippedRegon = Regex.Replace(e.Value, "[-]", "");

            try
            {
                ulong.Parse(strippedRegon);
            }
            catch
            {
                e.IsValid = false;
                return;
            }
            switch (strippedRegon.Length)
            {
                case 9:
                    {
                        int[] weights = {8, 9, 2, 3, 4, 5, 6, 7};
                        int checkDigit = int.Parse(strippedRegon.Substring(8, 1));
                        int sum = 0;

                        for (int i = 0; i < weights.Length; i++)

                            sum += int.Parse(strippedRegon.Substring(i, 1))*weights[i];
                        e.IsValid = ((sum%11 == checkDigit) ^ ((sum%11 == 10) && checkDigit == 0));
                        break;
                    }
                case 14:
                    {
                        int[] weights = {2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8};
                        int checkDigit = int.Parse(strippedRegon.Substring(13, 1));
                        int sum = 0;
                        for (int i = 0; i < weights.Length; i++)
                            sum += int.Parse(strippedRegon.Substring(i, 1))*weights[i];
                        e.IsValid = (sum%11 == checkDigit);
                        break;
                    }
                default:
                    {
                        e.IsValid = false;
                        break;
                    }
            }
        }

        protected void ValidateZSEiE(object sender, ServerValidateEventArgs e)
        {
            e.IsValid = (EconomicActivityCheckBoxList.SelectedItem != null && e.Value.Length > 0);
        }

        protected void GridViewContractors_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Contractor currentContractor = e.Row.DataItem as Contractor;
            LinkButton deleteButton = e.Row.FindControl("DeleteButton") as LinkButton;
            if (currentContractor != null && deleteButton != null)
            {
                bool a = !currentContractor.WasteRecordCardElements.Any();
                bool b = !currentContractor.WasteTransferCards.Any();
                bool c = !currentContractor.WasteTransferCards1.Any();
                deleteButton.Enabled = a && b && c;
                if (deleteButton.Enabled)
                    deleteButton.OnClientClick = "DeleteSurety()";
            }
        }

        protected void GridViewContractors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            DataKey key = GridViewContractors.DataKeys[e.NewEditIndex];
            if (key == null) return;
            GridViewContractors.EditIndex = e.NewEditIndex;
            GridViewContractorsDataBind();
            _contractorId = long.Parse(key.Value.ToString());
            ContractorIdHiddenField.Value = _contractorId.ToString();
            ListBoxVehicleNumbers.Items.Clear();
            ListBoxSelectedWasteCodes.Items.Clear();
            TBSelectedVehicleNumber.Text = "";
            VehicleNumberErrors.Text = "";
            GridViewContractors.SelectedIndex = -1;
            ContractorEdit(_contractorId);
        }

        protected void GridViewContractors_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DataKey key = GridViewContractors.DataKeys[e.RowIndex];
            if (key == null) return;
            _contractorId = long.Parse(key.Value.ToString());
            ContractorUpdate(_contractorId);
        }

        protected void GridViewContractors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataKey key = GridViewContractors.DataKeys[e.RowIndex];
            if (key == null) return;
            _contractorId = long.Parse(key.Value.ToString());
            ContractorDetailsPanel.Visible = false;
            ContractorEditPanel.Visible = false;
            GridViewContractors.EditIndex = -1;
            GridViewContractors.SelectedIndex = -1;
            Contractor contractorToRemove = _database.Contractors.First(c => c.Id == _contractorId);
            List<ContractorVehicleNumber> contractorVehicleNumbers =
                _database.ContractorVehicleNumbers.Where(
                    vehicles => vehicles.Contractor.Id == contractorToRemove.Id).ToList();
            List<ContractorWasteCode> contractorWasteCodes =
                _database.ContractorWasteCodes.Where(cw => cw.Contractor.Id == contractorToRemove.Id).ToList
                    ();
            using (var scope = new TransactionScope())
            {
                try
                {
                    foreach (ContractorVehicleNumber number in contractorVehicleNumbers)
                    {
                        _database.DeleteObject(number);
                        _database.SaveChanges();
                    }
                    foreach (ContractorWasteCode code in contractorWasteCodes)
                    {
                        _database.DeleteObject(code);
                        _database.SaveChanges();
                    }
                    _database.DeleteObject(contractorToRemove);
                    _database.SaveChanges();
                    scope.Complete();
                    _database.AcceptAllChanges();
                }
                catch
                {
                    ContractorsListViewErrorLabel.Text = Common.CANT_DELETE_ROW;
                    scope.Dispose();
                    return;
                }
            }
            Response.Redirect("~/Contractor.aspx");
        }

        protected void GridViewContractors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ContractorEdit(null);
            Response.Redirect("~/Contractor.aspx");
        }

        protected void GridViewContractors_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            DataKey key = GridViewContractors.DataKeys[e.NewSelectedIndex];
            if (key == null) return;
            _contractorId = long.Parse(key.Value.ToString());
            GridViewContractors.SelectedIndex = e.NewSelectedIndex;
            GridViewContractors.EditIndex = -1;
            GridViewContractorsDataBind();
            Contractor currentContractor =
                _database.Contractors.Include("Commune.District.Province").First(c => c.Id == _contractorId);
            var wasteCodes =
                _database.ContractorWasteCodes.Where(w => w.Contractor.Id == _contractorId).Select(
                    w => new {w.WasteCode.Name, w.WasteCode.Description});

            ContractorDetailsView.DataSource = new[]
                                                   {
                                                       new
                                                           {
                                                               fullname = currentContractor.FullName,
                                                               shortname = currentContractor.ShortName,
                                                               province =
                                                           currentContractor.Commune.District.Province.Name,
                                                               district =
                                                           currentContractor.Commune.District.Name,
                                                               commune = currentContractor.Commune.Name,
                                                               vehiclenumbers =
                                                           String.Join(", ",
                                                                       (_database.ContractorVehicleNumbers.
                                                                           Where(
                                                                               v => v.Contractor.Id ==
                                                                                    _contractorId).
                                                                           Select(v => v.Value)).ToArray()),
                                                               adres = Common.GetAddress(currentContractor),
                                                               nip = currentContractor.Nip,
                                                               regon = currentContractor.Regon,
                                                               phone = currentContractor.Phone,
                                                               fax = currentContractor.Fax,
                                                               registernumber =
                                                           Common.GetRegisterNumber(currentContractor),
                                                               wastecodes =
                                                           String.Join(", ",
                                                                       (wasteCodes.Select(
                                                                           w =>
                                                                           ("<span title=\"" + w.Description +
                                                                            "\">" + w.Name + "</span>"))).
                                                                           ToArray())
                                                           }
                                                   };
            ContractorDetailsPanel.Visible = true;
            ContractorEditPanel.Visible = false;
            ContractorDetailsView.DataBind();
        }

        // ReSharper restore ReturnValueOfPureMethodIsNotUsed
        // ReSharper restore LoopCanBeConvertedToQuery

        #endregion
    }
}