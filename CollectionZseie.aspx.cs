/*
 * WLASCICIEL: amadej
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca przyjęcie ZSEiE. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy przyjęciu ZSEiE:
 * 
 * 	+3. PRZYJĘCIE ZSEiE.
	*****************************************************************************************
	* - data                                                                                *
	* - masa przyjętych odpadów                                                             *
	* - sucha masa przyjętych odpadów                                                       *
	* - nr KPO (przekazującego)                                                             *
	* - identyfikator KPO wystawionej za kontrahenta                                        *
	* - identyfikator kodu ZSEiE                                                            *
	* - pochodzenie (Z GOSPODARSTW DOMOWYCH lub OD INNYCH UŻYTKOWNIKÓW)                     *
	*****************************************************************************************
 *
 * @@@ NIEZBĘDNA OPCJA WYSTAWIENIA KPO ZA KONTRAHENTA @@@
*/

using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;
using EVident.UserControl;

namespace EVident
{
    public partial class CollectionZseie : Page
    {
        private const int KIND = 3;
        private readonly EVidentDataModel _database;

        protected CollectionZseie()
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
            /*
            if (transportKindDropDownList.SelectedValue != "2") return;
            long transfercardId = long.Parse(wasteTransferCardIdHiddenField.Value);
            var wasteTransferCard = _database.WasteTransferCards.Include("TransportContractor").FirstOrDefault(it => it.TransportContractor.Id == transfercardId);
            if (wasteTransferCard == null) return;
            long transportcontractorId = wasteTransferCard.TransportContractor.Id;
            transportContractorDropDownList.SelectedValue = transportcontractorId.ToString();
             */ 
        }
        protected void kpoListView_ItemUpdating(object sender, ListViewUpdateEventArgs e)
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
        protected void KpoListViewSelectedIndexChanged(object sender, EventArgs e)
        {
            if (kpoListView.SelectedDataKey != null)
                wasteTransferCardIdHiddenField.Value = kpoListView.SelectedDataKey.Value + "";
        }
        protected void kpoListView_ItemDeleting(object sender, ListViewDeleteEventArgs e)
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
        protected void WasteRecordCardElementListViewPreRender(object sender, EventArgs e)
        {
            ConfigureWasteRecordCardElementListViewInsertItem();
        }
        protected void WasteRecordCardElementListWithoutKPOViewPreRender(object sender, EventArgs e)
        {
            ConfigureWasteRecordCardElementWithoutKPOListViewInsertItem();
        }

        private void ConfigureWasteRecordCardElementListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox)
                                  wasteRecordCardElementListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
        }
        private void ConfigureWasteRecordCardElementWithoutKPOListViewInsertItem()
        {
            TextBox dateTextBox = (TextBox) collectionWithoutKPOListView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
        }
        protected void WasteRecordCardElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownListExtended zseieCodeDDL = (DropDownListExtended)e.Item.FindControl("ZseieCode3DDL");
            if (zseieCodeDDL.SelectedValue != "")
            {
                long zseieCodeId = long.Parse(zseieCodeDDL.SelectedValue);
                e.Values["ZseieCode.Id"] = zseieCodeId;
                string zseieKindString = _database.ZseieCodes.First(it => it.Id == zseieCodeId).Name.Split('.')[0] + ".";
                e.Values["ZseieCode1.Id"] = _database.ZseieCodes.First(it => it.Name == zseieKindString).Id;
            }
            e.Values["ReceivedDryMass"] = 0;
            e.Values["TransferMass"] = 0;
            e.Values["TransferDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
        }
        protected void wasteRecordCardElementListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownListExtended zseieCodeDDL = (DropDownListExtended) wasteRecordCardElementListView.EditItem.FindControl("ZseieCodeDDL");
            if (zseieCodeDDL.SelectedValue != "")
            {
                long zseieCodeId = long.Parse(zseieCodeDDL.SelectedValue);
                string zseieKindString = _database.ZseieCodes.First(it => it.Id == zseieCodeId).Name.Split('.')[0] + ".";
                e.NewValues["ZseieCode1.Id"] = _database.ZseieCodes.First(it => it.Name == zseieKindString).Id;
            }
            else
            {
                //powyższym sposobem nie można przypisać wartości null, więc odwołuję się do bazy danych
                long wasteRecordCardElementId = long.Parse(e.Keys["Id"].ToString());
                WasteRecordCardElement element =
                    _database.WasteRecordCardElements.Include("ZseieCode1").First(it => it.Id == wasteRecordCardElementId);
                element.ZseieCode1 = null;
                _database.SaveChanges();
            }
        }
        protected void WasteRecordCardElementWithoutKPOListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownListExtended zseieCodeDDL = (DropDownListExtended)e.Item.FindControl("ZseieCode2DDL");
            if (zseieCodeDDL.SelectedValue != "")
            {
                long zseieCodeId = long.Parse(zseieCodeDDL.SelectedValue);
                e.Values["ZseieCode.Id"] = zseieCodeId;
                string zseieKindString = _database.ZseieCodes.First(it => it.Id == zseieCodeId).Name.Split('.')[0] + ".";
                e.Values["ZseieCode1.Id"] = _database.ZseieCodes.First(it => it.Name == zseieKindString).Id;
            }
            e.Values["ReceivedDryMass"] = 0.0;
            e.Values["TransferMass"] = 0.0;
            e.Values["TransferDryMass"] = 0.0;
            e.Values["ManageMass"] = 0.0;
            e.Values["ManageDryMass"] = 0.0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
        }
        protected void collectionWithoutKPOListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownListExtended zseieCodeDDL = (DropDownListExtended) collectionWithoutKPOListView.EditItem.FindControl("ZseieCode2DDL");
            if (zseieCodeDDL.SelectedValue != "")
            {
                long zseieCodeId = long.Parse(zseieCodeDDL.SelectedValue);
                string zseieKindString = _database.ZseieCodes.First(it => it.Id == zseieCodeId).Name.Split('.')[0] + ".";
                e.NewValues["ZseieCode1.Id"] = _database.ZseieCodes.First(it => it.Name == zseieKindString).Id;
            }
            else
            {
                long wasteRecordCardElementId = long.Parse(e.Keys["Id"].ToString());
                WasteRecordCardElement element =
                    _database.WasteRecordCardElements.Include("ZseieCode1").First(it => it.Id == wasteRecordCardElementId);
                element.ZseieCode1 = null;
                _database.SaveChanges();
            }
        }
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