/* 
 * WLASCICIEL: phalladin
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca wytworzenie odpadu. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy wytworzeniu:
 * 
 * 	+1. WYTWORZENIE.
	*****************************************************************************************
	* - data                                                                                *
	* - masa wytworzonych odpadów                                                           *
	* - sucha masa wytworzonych odpadów                                                     *
	* - odpad wytworzony w instalacji do odzysku lub unieszkodliwiania (TAK lub NIE)        *
	* - nr partii odpadu wytworzonego w instalacji do odzysku lub unieszkodliwiania         *
	* - odpad wytworzony w ramach PGO (TAK lub NIE)                                         *
	* - identyfikator gminy odpadu wytworzonego w ramach PGO                                *
	* - identyfikator kontrahenta odpadu wytworzonego w ramach PGO                          *
	*****************************************************************************************
*/

using System;
using System.Linq;
using EVident.Code;
using EVident.UserControl;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class Creation : System.Web.UI.Page
    {
        private static readonly int KIND = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            WasteRecordCard wasteRecordCard;

            wasteRecordCard = ((Default) Master).GetCurrentWasteRecordCard();
            if (wasteRecordCard != null) wasteCodeLiteral.Text = wasteRecordCard.WasteCode.Name;
            else Response.Redirect("./Default.aspx");
        }

        protected void ListViewPreRender(object sender, EventArgs e)
        {
            ConfigureListViewInsertItem();
            ConfigureListViewEditItem();
        }

        private void ConfigureListViewInsertItem()
        {
            EVidentDataModel database;
            WasteRecordCard wasteRecordCard;
            TextBox dateTextBox, dryMassTextBox;
            BaseValidator partNumberRequiredFieldValidator, dryMassRequiredFieldValidator, 
                dryMassRegularExpressionValidator, pgoContractorRequiredFieldValidator;
            DropDownList partNumberDropDownList, pgoContractorDropDownList;
            CheckBox isFromRecyclingOrDestructionCheckBox, isFromPgoCheckBox;
            CommuneSelector pgoCommuneSelector;
            bool enabled;

            database = Common.GetNotCachedDataModel();
            dateTextBox = (TextBox)listView.InsertItem.FindControl("DateTextBox");
            dateTextBox.Text = DateTime.Now.ToString("d");
            dryMassTextBox = (TextBox)listView.InsertItem.FindControl("CreatedDryMassTextBox");
            partNumberRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("PartNumberRequiredFieldValidator");
            dryMassRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("CreatedDryMassRequiredFieldValidator");
            dryMassRegularExpressionValidator = (BaseValidator)
                listView.InsertItem.FindControl("CreatedDryMassRegularExpressionValidator");
            pgoContractorRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("PgoContractorRequiredFieldValidator");
            wasteRecordCard = ((Default)Master).GetCurrentWasteRecordCard();
            enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassTextBox.Enabled = enabled;
            dryMassRequiredFieldValidator.Enabled = enabled;
            dryMassRegularExpressionValidator.Enabled = enabled;
            isFromRecyclingOrDestructionCheckBox = (CheckBox)
                listView.InsertItem.FindControl("IsFromRecyclingOrDestructionCheckBox");
            isFromPgoCheckBox = (CheckBox)listView.InsertItem.FindControl("IsFromPgoCheckBox");
            pgoContractorDropDownList = (DropDownList)
                listView.InsertItem.FindControl("PgoContractorDropDownList");
            pgoCommuneSelector = (CommuneSelector)
                listView.InsertItem.FindControl("PgoCommuneSelector");
            partNumberDropDownList = (DropDownList)listView.InsertItem.FindControl("PartNumberDropDownList");
            partNumberRequiredFieldValidator.Enabled = isFromRecyclingOrDestructionCheckBox.Checked;
            partNumberDropDownList.Enabled = isFromRecyclingOrDestructionCheckBox.Checked;
            pgoContractorDropDownList.Enabled = isFromPgoCheckBox.Checked;
            pgoContractorRequiredFieldValidator.Enabled = isFromPgoCheckBox.Checked;
            pgoCommuneSelector.Enabled = isFromPgoCheckBox.Checked;
        }

        private void ConfigureListViewEditItem()
        {
            EVidentDataModel database;
            WasteRecordCard wasteRecordCard;
            TextBox dryMassTextBox;
            DropDownList partNumberDropDownList, pgoContractorDropDownList;
            BaseValidator dryMassRequiredFieldValidator, dryMassRegularExpressionValidator, 
                partNumberRequiredFieldValidator, pgoContractorRequiredFieldValidator;
            CheckBox isFromRecyclingOrDestructionCheckBox, isFromPgoCheckBox;
            CommuneSelector pgoCommuneSelector;
            bool enabled;

            if (listView.EditItem == null) return;
            database = Common.GetNotCachedDataModel();
            wasteRecordCard = ((Default)Master).GetCurrentWasteRecordCard();
            enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassTextBox = (TextBox)listView.EditItem.FindControl("CreatedDryMassTextBox");
            dryMassRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("CreatedDryMassRequiredFieldValidator");
            dryMassRegularExpressionValidator = (BaseValidator)
                listView.EditItem.FindControl("CreatedDryMassRegularExpressionValidator");
            dryMassTextBox.Enabled = enabled;
            dryMassRequiredFieldValidator.Enabled = enabled;
            dryMassRegularExpressionValidator.Enabled = enabled;
            if (dryMassTextBox.Text == "0") dryMassTextBox.Text = "";
            partNumberDropDownList = (DropDownList)listView.EditItem.FindControl("PartNumberDropDownList");
            partNumberRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("PartNumberRequiredFieldValidator");
            pgoContractorRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("PgoContractorRequiredFieldValidator");
            isFromRecyclingOrDestructionCheckBox = (CheckBox)
                listView.EditItem.FindControl("IsFromRecyclingOrDestructionCheckBox");
            isFromPgoCheckBox = (CheckBox)listView.EditItem.FindControl("IsFromPgoCheckBox");
            pgoContractorDropDownList = (DropDownList)
                listView.EditItem.FindControl("PgoContractorDropDownList");
            pgoCommuneSelector = (CommuneSelector)
                listView.EditItem.FindControl("PgoCommuneSelector");
            partNumberRequiredFieldValidator.Enabled = isFromRecyclingOrDestructionCheckBox.Checked;
            partNumberDropDownList.Enabled = isFromRecyclingOrDestructionCheckBox.Checked;
            pgoContractorDropDownList.Enabled = isFromPgoCheckBox.Checked;
            pgoContractorRequiredFieldValidator.Enabled = isFromPgoCheckBox.Checked;
            pgoCommuneSelector.Enabled = isFromPgoCheckBox.Checked;
        }

        protected void ListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList partNumberDropDownList, pgoContractorDropDownList;
            CheckBox isFromRecyclingOrDestructionCheckBox, isFromPgoCheckBox;
            CommuneSelector pgoCommuneSelector;

            partNumberDropDownList = (DropDownList)
                listView.InsertItem.FindControl("PartNumberDropDownList");
            pgoCommuneSelector = (CommuneSelector)
                listView.InsertItem.FindControl("PgoCommuneSelector");
            pgoContractorDropDownList = (DropDownList)
                listView.InsertItem.FindControl("PgoContractorDropDownList");
            isFromRecyclingOrDestructionCheckBox = (CheckBox)
                listView.InsertItem.FindControl("IsFromRecyclingOrDestructionCheckBox");
            isFromPgoCheckBox = (CheckBox)listView.InsertItem.FindControl("IsFromPgoCheckBox");
            e.Values["WasteRecordCard.Id"] = Request["WasteRecordCardId"];
            if (e.Values["CreatedDryMass"] == null) e.Values["CreatedDryMass"] = 0;
            e.Values["ReceivedMass"] = 0;
            e.Values["ReceivedDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["TransferMass"] = 0;
            e.Values["TransferDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
            if (isFromRecyclingOrDestructionCheckBox.Checked)
                e.Values["PartNumber"] = partNumberDropDownList.SelectedItem.Text;

            if (isFromPgoCheckBox.Checked)
            {
                e.Values["PgoCommune.Id"] = pgoCommuneSelector.CommuneId;
                e.Values["PgoContractor.Id"] = pgoContractorDropDownList.SelectedValue;
            }
        }

        protected void ListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            CommuneSelector pgoCommuneSelector;
            DropDownList partNumberDropDownList, pgoContractorDropDownList;
            CheckBox isFromRecyclingOrDestructionCheckBox, isFromPgoCheckBox;

            pgoCommuneSelector = (CommuneSelector)
                listView.EditItem.FindControl("PgoCommuneSelector");
            partNumberDropDownList = (DropDownList)
                listView.EditItem.FindControl("PartNumberDropDownList");
            pgoContractorDropDownList = (DropDownList)
                listView.EditItem.FindControl("PgoContractorDropDownList");
            isFromRecyclingOrDestructionCheckBox = (CheckBox)
                listView.EditItem.FindControl("IsFromRecyclingOrDestructionCheckBox");
            isFromPgoCheckBox = (CheckBox)listView.EditItem.FindControl("IsFromPgoCheckBox");
            
            if (!isFromRecyclingOrDestructionCheckBox.Checked)
                Common.SetToNull("PartNumber", e.NewValues, e.OldValues, 0);
            else e.NewValues["PartNumber"] = partNumberDropDownList.SelectedValue;

            if (!isFromPgoCheckBox.Checked)
            {
                Common.SetToNull("PgoCommune.Id", e.NewValues, e.OldValues, 0);
                Common.SetToNull("PgoContractor.Id", e.NewValues, e.OldValues, 0);
            }
            else
            {
                e.NewValues["PgoCommune.Id"] = pgoCommuneSelector.CommuneId;
                e.NewValues["PgoContractor.Id"] = pgoContractorDropDownList.SelectedValue;
            }
        }
    }
}