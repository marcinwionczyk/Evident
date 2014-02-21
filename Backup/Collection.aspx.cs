using System;
using System.Linq;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Collection : System.Web.UI.Page
    {
        private const int KIND = 2;
        private readonly EVidentDataModel _database;

        protected Collection()
        {
            _database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Default master = (Default) Master;
            if (master != null)
            {
                WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
                if (wasteRecordCard != null) wasteCodeLiteral.Text = wasteRecordCard.WasteCode.Name;
                else Response.Redirect("./Default.aspx", true);
            }
            if (Page.IsPostBack) return;
            MultiView1.SetActiveView(WithoutKPO);
            
        }
#region KpoListView
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
        protected void KPOListViewItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            long id = long.Parse(e.Keys["Id"].ToString());
            WasteTransferCard wasteTransferCard = _database.WasteTransferCards.First(w => w.Id == id);
            wasteTransferCard.WasteRecordCardElements.Load();
            foreach (WasteRecordCardElement wasteRecordCardelement in wasteTransferCard.WasteRecordCardElements.ToList())
            {
                _database.DeleteObject(wasteRecordCardelement);
            }
            _database.SaveChanges();
            if (kpoListView.SelectedIndex != e.ItemIndex) return;
            wasteTransferCardIdHiddenField.Value = "";
            transferPanel.Visible = false;
        }
        
#endregion
#region WasteRecordCardElementListView
        protected void WasteRecordCardElementListViewPreRender(object sender, EventArgs e)
        {
            ConfigureWasteRecordCardElementListViewInsertItem();
            ConfigureWasteRecordCardElementListViewEditItem();
        }
        protected void WasteRecordCardElementListWithoutKPOViewPreRender(object sender, EventArgs e)
        {
            ConfigureWasteRecordCardElementWithoutKPOListViewInsertItem();
            ConfigureWasteRecordCardElementWithoutKPOListViewEditItem();
        }

        private void ConfigureWasteRecordCardElementListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox)
                                  wasteRecordCardElementListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            TextBox receivedDryMassTextBox = (TextBox)
                                             wasteRecordCardElementListView.InsertItem.FindControl("ReceivedDryMassTextBox");
            BaseValidator receivedDryMassRequiredFieldValidator = (BaseValidator)
                                                                  wasteRecordCardElementListView.InsertItem.FindControl("ReceivedDryMassRequiredFieldValidator");
            BaseValidator receivedDryMassRegularExpressionValidator = (BaseValidator)
                                                                      wasteRecordCardElementListView.InsertItem.FindControl("ReceivedDryMassRegularExpressionValidator");
            Default master = (Default) Master;
            if (master != null)
            {
                WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
                receivedDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                receivedDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                receivedDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            }
            if (receivedDryMassTextBox.Text == "0") receivedDryMassTextBox.Text = "";
        }
        private void ConfigureWasteRecordCardElementWithoutKPOListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox) collectionWithoutKPOListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            
            TextBox receivedDryMassTextBox = (TextBox)
                                             collectionWithoutKPOListView.InsertItem.FindControl("ReceivedDryMassTextBox2");
            BaseValidator receivedDryMassRequiredFieldValidator = (BaseValidator)
                                                                  collectionWithoutKPOListView.InsertItem.FindControl("ReceivedDryMassRequiredFieldValidator2");
            BaseValidator receivedDryMassRegularExpressionValidator = (BaseValidator)
                                                                      collectionWithoutKPOListView.InsertItem.FindControl("ReceivedDryMassRegularExpressionValidator2");
            Default master = (Default)Master;
            if (master == null) return;
            WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
            receivedDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            receivedDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            receivedDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
        }
        private void ConfigureWasteRecordCardElementListViewEditItem()
        {
            if (wasteRecordCardElementListView.EditItem == null) return;
            TextBox receivedDryMassTextBox = (TextBox)
                                             wasteRecordCardElementListView.EditItem.FindControl("ReceivedDryMassTextBox");

            BaseValidator receivedDryMassRequiredFieldValidator = (BaseValidator)
                                                                  wasteRecordCardElementListView.EditItem.FindControl("ReceivedDryMassRequiredFieldValidator");
            BaseValidator receivedDryMassRegularExpressionValidator = (BaseValidator)
                                                                      wasteRecordCardElementListView.EditItem.FindControl("ReceivedDryMassRegularExpressionValidator");
            Default master = (Default) Master;
            if (master != null)
            {
                WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
                receivedDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                receivedDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
                receivedDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            }
            if (receivedDryMassTextBox.Text == "0") receivedDryMassTextBox.Text = "";
        }
        private void ConfigureWasteRecordCardElementWithoutKPOListViewEditItem()
        {
            if (collectionWithoutKPOListView.EditItem == null) return;
            TextBox receivedDryMassTextBox = (TextBox)
                                             collectionWithoutKPOListView.EditItem.FindControl("ReceivedDryMassTextBox3");
            BaseValidator receivedDryMassRequiredFieldValidator = (BaseValidator)
                                                                  collectionWithoutKPOListView.EditItem.FindControl("ReceivedDryMassRequiredFieldValidator3");
            BaseValidator receivedDryMassRegularExpressionValidator = (BaseValidator)
                                                                      collectionWithoutKPOListView.EditItem.FindControl("ReceivedDryMassRegularExpressionValidator3");
            Default master = (Default)Master;
            if (master == null) return;
            WasteRecordCard wasteRecordCard = master.GetCurrentWasteRecordCard();
            receivedDryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            receivedDryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            receivedDryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            if (receivedDryMassTextBox.Text == "0") receivedDryMassTextBox.Text = "";
        }
        protected void WasteRecordCardElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {

            if (e.Values["ReceivedDryMass"] == null) e.Values["ReceivedDryMass"] = 0;
            e.Values["TransferMass"] = 0;
            e.Values["TransferDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
        }
        protected void WasteRecordCardElementWithoutKPOListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            if (e.Values["ReceivedDryMass"] == null) e.Values["ReceivedDryMass"] = 0.0;
            e.Values["TransferMass"] = 0.0;
            e.Values["TransferDryMass"] = 0.0;
            e.Values["ManageMass"] = 0.0;
            e.Values["ManageDryMass"] = 0.0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
        }
#endregion
        protected void KpoRequiredDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            if (Request.QueryString["WasteRecordCardId"] != null)
                switch (KPORequiredDropDownList.SelectedValue)
                {
                    case "0":
                        {
                            MultiView1.SetActiveView(WithKPO);
                            // Bind Data with KPO
                            kpoListView.DataBind();
                            wasteRecordCardElementListView.DataBind();
                            break;
                        }
                    case "1":
                        {
                            MultiView1.SetActiveView(WithoutKPO);
                            collectionWithoutKPOListView.DataBind();
                            break;
                        }
                }
        }

        

        

    }
}