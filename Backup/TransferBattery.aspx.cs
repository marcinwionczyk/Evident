using System;
using System.Linq;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class TransferBattery : System.Web.UI.Page
    {
        private const int KIND = -10;
        protected EVidentDataModel _database;

        public TransferBattery()
        {
            _database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            WasteRecordCard wasteRecordCard = ((Default) Master).GetCurrentWasteRecordCard();
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
                    WasteTransferCard transferCard = _database.WasteTransferCards.First(w => w.Id == transferCardId);
                    transferCard.TransportContractor = null;
                    _database.SaveChanges();
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
            DropDownList transportKindDropDownList = (DropDownList)
                                                     kpoListView.InsertItem.FindControl("TransportKindDropDownList");
            DropDownList transportContractorDropDownList = (DropDownList)
                                                           kpoListView.InsertItem.FindControl("TransportContractorDropDownList");
            transportContractorDropDownList.Enabled = (transportKindDropDownList.SelectedValue == "2");
        }

        private void ConfigureKpoListViewEditItem()
        {
            if (kpoListView.EditItem == null) return;

            DropDownList transportKindDropDownList = (DropDownList)
                                                     kpoListView.EditItem.FindControl("TransportKindDropDownList");
            DropDownList transportContractorDropDownList = (DropDownList)
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
        }

        private void ConfigureWasteRecordCardElementListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox)
                                  wasteRecordCardElementListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
        }


        protected void WasteRecordCardElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            e.Values["TransferDryMass"] = 0;
            e.Values["ReceivedMass"] = 0;
            e.Values["ReceivedDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
        }

        
    }
}