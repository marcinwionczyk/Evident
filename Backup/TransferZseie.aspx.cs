/* 
 * WLASCICIEL: amadej
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca przekazanie ZSEiE. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy przekazaniu ZSEiE:
 * 
	-9. Przekazanie ZSEiE.
	*****************************************************************************************
	* - masa przekazanych odpadów                                                           *
	* - sucha masa przekazanych odpadów                                                     *
	* - nr KPO (nadawany automatycznie)                                                     *
	* - identyfikator KPO                                                                   *
	* - identyfikator kodu ZSEiE                                                            *
	*****************************************************************************************
 *
 * @@@ PRZY KAŻDYM PRZEKAZANIU WYSTAWIAMY OD RAZU KPO @@@
*/

using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class TransferZseie : Page
    {
        private const int KIND = -9;
        private readonly EVidentDataModel _database;

        protected TransferZseie()
        {
            _database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var master = (Default) Master;
            if (master == null) return;
            WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
            if (wasteRecordCard != null) wasteCodeLiteral.Text = wasteRecordCard.WasteCode.Name;
            else Response.Redirect("./Default.aspx", true);
        }

        protected void KpoListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList contractorDropDownList = (DropDownList)
                                                  e.Item.FindControl("ContractorDropDownList");
            DropDownList transportKindDropDownList = (DropDownList)
                                                     e.Item.FindControl("TransportKindDropDownList");
            DropDownList transportContractorDropDownList = (DropDownList)
                                                           e.Item.FindControl("TransportContractorDropDownList");
            e.Values["Contractor.Id"] = contractorDropDownList.SelectedValue;
            if (transportKindDropDownList.SelectedValue == "2")
                e.Values["TransportContractor.Id"] = transportContractorDropDownList.SelectedValue;
            e.Values["WasteRecordCard.Id"] = Request["WasteRecordCardId"];
            e.Values["IsCollection"] = false;
            e.Values["TransportKind"] = transportKindDropDownList.SelectedValue;
            e.Values["Kind"] = KIND;
        }

        protected void KpoListViewPreRender(object sender, EventArgs e)
        {
            ConfigureKpoListViewInsertItem();
            ConfigureKpoListViewEditItem();
            transferPanel.Visible = (wasteTransferCardIdHiddenField.Value != "");
        }

        private void ConfigureKpoListViewInsertItem()
        {
            DropDownList transportKindDropDownList = (DropDownList)
                                                     kpoListView.InsertItem.FindControl("TransportKindDropDownList");
            DropDownList transportContractorDropDownList = (DropDownList)
                                                           kpoListView.InsertItem.FindControl(
                                                               "TransportContractorDropDownList");
            TextBox transferCardNumberTextBox = (TextBox)
                                                kpoListView.InsertItem.FindControl("TransferCardNumberTextBox");
            transportContractorDropDownList.Enabled = (transportKindDropDownList.SelectedValue == "2");
            var master = (Default) Master;
            if (master != null)
                transferCardNumberTextBox.Text = _database.GetNextTransferCardNumber(
                    master.GetCurrentWasteRecordCard().Id);
        }

        private void ConfigureKpoListViewEditItem()
        {
            if (kpoListView.EditItem == null) return;

            DropDownList transportKindDropDownList = (DropDownList)
                                                     kpoListView.EditItem.FindControl("TransportKindDropDownList");
            DropDownList transportContractorDropDownList = (DropDownList)
                                                           kpoListView.EditItem.FindControl(
                                                               "TransportContractorDropDownList");
            transportContractorDropDownList.Enabled = (transportKindDropDownList.SelectedValue == "2");
        }

        protected void KpoListViewSelectedIndexChanged(object sender, EventArgs e)
        {
            if (kpoListView.SelectedDataKey != null)
                wasteTransferCardIdHiddenField.Value = kpoListView.SelectedDataKey.Value + "";
        }

        protected void WasteRecordCardElementListViewPreRender(object sender, EventArgs e)
        {
            ConfigureWasteRecordCardElementListViewInsertItem();
            ConfigureWasteRecordCardElementListViewEditItem();
        }

        private void ConfigureWasteRecordCardElementListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox)
                                  wasteRecordCardElementListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            TextBox transferDryMassTextBox = (TextBox)
                                             wasteRecordCardElementListView.InsertItem.FindControl(
                                                 "TransferDryMassTextBox");
            BaseValidator transferDryMassRequiredFieldValidator = (BaseValidator)
                                                                  wasteRecordCardElementListView.InsertItem.FindControl(
                                                                      "TransferDryMassRequiredFieldValidator");
            BaseValidator transferDryMassRegularExpressionValidator = (BaseValidator)
                                                                      wasteRecordCardElementListView.InsertItem.
                                                                          FindControl(
                                                                              "TransferDryMassRegularExpressionValidator");
            Default master = (Default) Master;
            if (master == null) return;
            WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
            transferDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            transferDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            transferDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
        }

        private void ConfigureWasteRecordCardElementListViewEditItem()
        {
            if (wasteRecordCardElementListView.EditItem == null) return;
            TextBox transferDryMassTextBox = (TextBox)
                                             wasteRecordCardElementListView.EditItem.FindControl(
                                                 "TransferDryMassTextBox");
            BaseValidator transferDryMassRequiredFieldValidator = (BaseValidator)
                                                                  wasteRecordCardElementListView.EditItem.FindControl(
                                                                      "TransferDryMassRequiredFieldValidator");
            BaseValidator transferDryMassRegularExpressionValidator = (BaseValidator)
                                                                      wasteRecordCardElementListView.EditItem.
                                                                          FindControl(
                                                                              "TransferDryMassRegularExpressionValidator");
            var master = (Default) Master;
            if (master == null) return;
            WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
            transferDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            transferDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            transferDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            if (transferDryMassTextBox.Text == "0") transferDryMassTextBox.Text = "";
        }

        protected void WasteRecordCardElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList list = e.Item.FindControl("ZseieCodesDropDownList") as DropDownList;
            if (list != null) e.Values["ZseieCode.Id"] = long.Parse(list.SelectedValue);
            if (e.Values["TransferDryMass"] == null) e.Values["TransferDryMass"] = 0;
            e.Values["ReceivedMass"] = 0;
            e.Values["ReceivedDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            
            e.Values["IsFromHome"] = false;
        }
    }
}