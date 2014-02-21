/* 
 * WLASCICIEL: phalladin
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca przekazanie. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy przekazaniu:
 * 
 * 	-8. PRZEKAZANIE.
	*****************************************************************************************
	* - masa przekazanych odpadów                                                           *
	* - sucha masa przekazanych odpadów                                                     *
	* - nr KPO (nadawany automatycznie)                                                     *
	* - identyfikator KPO                                                                   *
	*****************************************************************************************
 *
 * @@@ PRZY KAŻDYM PRZEKAZANIU WYSTAWIAMY OD RAZU KPO @@@
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class Transfer : System.Web.UI.Page
    {
        private static readonly int KIND = -8;
        private EVidentDataModel database;

        public Transfer()
        {
            database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            WasteRecordCard wasteRecordCard;

            Default master = (Default) Master;
            if (master == null) return;
            wasteRecordCard = master.GetCurrentWasteRecordCard();
            if (wasteRecordCard != null) wasteCodeLiteral.Text = wasteRecordCard.WasteCode.Name;
            else Response.Redirect("./Default.aspx", true);
        }

        protected void KpoListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList contractorDropDownList, transportKindDropDownList, 
                transportContractorDropDownList;

            contractorDropDownList = (DropDownList)
                e.Item.FindControl("ContractorDropDownList");
            transportKindDropDownList = (DropDownList)
                e.Item.FindControl("TransportKindDropDownList");
            transportContractorDropDownList = (DropDownList)
                e.Item.FindControl("TransportContractorDropDownList");
            e.Values["Contractor.Id"] = contractorDropDownList.SelectedValue;
            if (transportKindDropDownList.SelectedValue == "2") 
                e.Values["TransportContractor.Id"] = transportContractorDropDownList.SelectedValue;
            e.Values["WasteRecordCard.Id"] = Request["WasteRecordCardId"];
            e.Values["IsCollection"] = false;
            e.Values["TransportKind"] = transportKindDropDownList.SelectedValue;
            e.Values["Kind"] = KIND;
        }
        protected void KPOListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownList transportContractorDropDownList = (DropDownList)
                                                           kpoListView.EditItem.FindControl("TransportContractorDropDownList");
            DropDownList transportKindDropDownList = (DropDownList)
                                                     kpoListView.EditItem.FindControl("TransportKindDropDownList");
            if (transportKindDropDownList.SelectedValue == "2")
                e.NewValues["TransportContractor.Id"] = transportContractorDropDownList.SelectedValue;
            else
            {
                var dataKey = kpoListView.DataKeys[e.ItemIndex];
                if (dataKey != null)
                {
                    long transferCardId = long.Parse(dataKey.Value.ToString());
                    WasteTransferCard transferCard = database.WasteTransferCards.First(w => w.Id == transferCardId);
                    transferCard.TransportContractor = null;
                    database.SaveChanges();
                }
            }
        }
        protected void KpoListViewPreRender(object sender, EventArgs e)
        {
            ConfigureKpoListViewInsertItem();
            ConfigureKpoListViewEditItem();
            transferPanel.Visible = (wasteTransferCardIdHiddenField.Value != "");
        }

        private void ConfigureKpoListViewInsertItem()
        {
            DropDownList transportKindDropDownList, transportContractorDropDownList;
            TextBox transferCardNumberTextBox;

            transportKindDropDownList = (DropDownList)
                kpoListView.InsertItem.FindControl("TransportKindDropDownList");
            transportContractorDropDownList = (DropDownList)
                kpoListView.InsertItem.FindControl("TransportContractorDropDownList");
            transferCardNumberTextBox = (TextBox)
                kpoListView.InsertItem.FindControl("TransferCardNumberTextBox");
            transportContractorDropDownList.Enabled = (transportKindDropDownList.SelectedValue == "2");
            Default master = (Default) Master;
            if (master != null)
                transferCardNumberTextBox.Text = database.GetNextTransferCardNumber(
                    master.GetCurrentWasteRecordCard().Id);
        }

        private void ConfigureKpoListViewEditItem()
        {
            if (kpoListView.EditItem == null) return;
            DropDownList transportKindDropDownList, transportContractorDropDownList;

            transportKindDropDownList = (DropDownList)
                kpoListView.EditItem.FindControl("TransportKindDropDownList");
            transportContractorDropDownList = (DropDownList)
                kpoListView.EditItem.FindControl("TransportContractorDropDownList");
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
            WasteRecordCard wasteRecordCard;
            TextBox dateTextBox, transferDryMassTextBox;
            BaseValidator transferDryMassRequiredFieldValidator, transferDryMassRegularExpressionValidator;

            dateTextBox = (TextBox)
                wasteRecordCardElementListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            transferDryMassTextBox = (TextBox)
                wasteRecordCardElementListView.InsertItem.FindControl("TransferDryMassTextBox");
            transferDryMassRequiredFieldValidator = (BaseValidator)
                wasteRecordCardElementListView.InsertItem.FindControl("TransferDryMassRequiredFieldValidator");
            transferDryMassRegularExpressionValidator = (BaseValidator)
                wasteRecordCardElementListView.InsertItem.FindControl("TransferDryMassRegularExpressionValidator");
            Default master = (Default) Master;
            if (master != null)
            {
                wasteRecordCard = master.GetCurrentWasteRecordCard();
                transferDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                transferDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                transferDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            }
            
        }

        private void ConfigureWasteRecordCardElementListViewEditItem()
        {
            WasteRecordCard wasteRecordCard;
            TextBox transferDryMassTextBox;
            BaseValidator transferDryMassRequiredFieldValidator, transferDryMassRegularExpressionValidator;

            if (wasteRecordCardElementListView.EditItem == null) return;
            transferDryMassTextBox = (TextBox)
                wasteRecordCardElementListView.EditItem.FindControl("TransferDryMassTextBox");
            transferDryMassRequiredFieldValidator = (BaseValidator)
                wasteRecordCardElementListView.EditItem.FindControl("TransferDryMassRequiredFieldValidator");
            transferDryMassRegularExpressionValidator = (BaseValidator)
                wasteRecordCardElementListView.EditItem.FindControl("TransferDryMassRegularExpressionValidator");
            Default master = (Default) Master;
            if (master != null)
            {
                wasteRecordCard = master.GetCurrentWasteRecordCard();
                transferDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                transferDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                transferDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            }
            
            if (transferDryMassTextBox.Text == "0") transferDryMassTextBox.Text = "";
        }

        protected void WasteRecordCardElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
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