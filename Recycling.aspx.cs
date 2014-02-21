/* 
 * WLASCICIEL: phalladin
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca odzysk. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy odzysku:
 * 
 * 	+6. ODZYSK.
	*****************************************************************************************
	* - masa zagospodarowanych odpadów                                                      *
	* - sucha masa zagospodarowanych odpadów                                                *
	* - nr partii                                                                           *
	* - identyfikator metody odzysku                                                        *
	* - identyfikator instalacji (jeżeli odzysk w instalacji)                               *
	*****************************************************************************************
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class Recycling : System.Web.UI.Page
    {
        private static readonly int KIND = 6;
        private EVidentDataModel database;

        public Recycling()
        {
            database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            WasteRecordCard wasteRecordCard;

            wasteRecordCard = ((Default)Master).GetCurrentWasteRecordCard();
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
            TextBox dateTextBox, dryMassTextBox, lpTextBox, partNumberTextBox;
            BaseValidator dryMassRequiredFieldValidator, dryMassRegularExpressionValidator, 
                lpRequiredFieldValidator, installationRequiredFieldValidator, 
                partNumberRequiredFieldValidator;
            DropDownList installationDropDownList;
            CheckBox inInstallationCheckBox;
            WasteRecordCard wasteRecordCard;

            wasteRecordCard = ((Default)Master).GetCurrentWasteRecordCard();
            dateTextBox = (TextBox)listView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            dryMassTextBox = (TextBox)listView.InsertItem.FindControl("ManageDryMassTextBox");
            dryMassRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("ManageDryMassRequiredFieldValidator");
            dryMassRegularExpressionValidator = (BaseValidator)
                listView.InsertItem.FindControl("ManageDryMassRegularExpressionValidator");
            dryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            inInstallationCheckBox = (CheckBox)listView.InsertItem.FindControl("InInstallationCheckBox");
            lpTextBox = (TextBox)listView.InsertItem.FindControl("ManageLpTextBox");
            lpRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("ManageLpRequiredFieldValidator");
            installationDropDownList = (DropDownList)
                listView.InsertItem.FindControl("InstallationDropDownList");
            installationRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("InstallationRequiredFieldValidator");
            partNumberTextBox = (TextBox)listView.InsertItem.FindControl("PartNumberTextBox");
            partNumberRequiredFieldValidator = (BaseValidator)
                listView.InsertItem.FindControl("PartNumberRequiredFieldValidator");
            lpTextBox.Enabled = !inInstallationCheckBox.Checked;
            lpRequiredFieldValidator.Enabled = !inInstallationCheckBox.Checked;
            installationDropDownList.Enabled = inInstallationCheckBox.Checked;
            installationRequiredFieldValidator.Enabled = inInstallationCheckBox.Checked;
            partNumberTextBox.Enabled = inInstallationCheckBox.Checked;
            partNumberRequiredFieldValidator.Enabled = inInstallationCheckBox.Checked;
            
            if (inInstallationCheckBox.Checked) partNumberTextBox.Text = 
                database.GetNextPartNumber(((Default) Master).GetCurrentWasteRecordCard().Id) + "";
        }

        private void ConfigureListViewEditItem()
        {
            TextBox dryMassTextBox, manageLpTextBox, partNumberTextBox;
            DropDownList installationDropDownList;
            CheckBox inInstallationCheckBox;
            BaseValidator dryMassRequiredFieldValidator, dryMassRegularExpressionValidator,
                manageLpRequiredFieldValidator, installationRequiredFieldValidator,
                partNumberRequiredFieldValidator;
            WasteRecordCard wasteRecordCard;

            if (listView.EditItem == null) return;
            dryMassTextBox = (TextBox)listView.EditItem.FindControl("ManageDryMassTextBox");
            manageLpTextBox = (TextBox)listView.EditItem.FindControl("ManageLpTextBox");
            inInstallationCheckBox = (CheckBox)listView.EditItem.FindControl("InInstallationCheckBox");
            installationDropDownList = (DropDownList)
                listView.EditItem.FindControl("InstallationDropDownList");
            partNumberTextBox = (TextBox)listView.EditItem.FindControl("PartNumberTextBox");
            dryMassRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("ManageDryMassRequiredFieldValidator");
            dryMassRegularExpressionValidator = (BaseValidator)
                listView.EditItem.FindControl("ManageDryMassRegularExpressionValidator");
            manageLpRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("ManageLpRequiredFieldValidator");
            installationRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("InstallationRequiredFieldValidator");
            partNumberRequiredFieldValidator = (BaseValidator)
                listView.EditItem.FindControl("PartNumberRequiredFieldValidator");
            wasteRecordCard = ((Default)Master).GetCurrentWasteRecordCard();
            dryMassTextBox.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassRequiredFieldValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            dryMassRegularExpressionValidator.Enabled = wasteRecordCard.WasteCode.RequireDryMass;
            if (dryMassTextBox.Text == "0") dryMassTextBox.Text = "";
            manageLpTextBox.Enabled = !inInstallationCheckBox.Checked;
            manageLpRequiredFieldValidator.Enabled = !inInstallationCheckBox.Checked;
            installationDropDownList.Enabled = inInstallationCheckBox.Checked;
            installationRequiredFieldValidator.Enabled = inInstallationCheckBox.Checked;
            partNumberTextBox.Enabled = inInstallationCheckBox.Checked;
            partNumberRequiredFieldValidator.Enabled = inInstallationCheckBox.Checked;
        }

        protected void ListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList processingMethodDropDownList, installationDropDownList;
            TextBox manageLpTextBox, partNumberTextBox;
            CheckBox inInstallationCheckBox;

            inInstallationCheckBox = (CheckBox)listView.InsertItem.FindControl("InInstallationCheckBox");
            processingMethodDropDownList = (DropDownList)
                listView.InsertItem.FindControl("ProcessingMethodDropDownList");
            manageLpTextBox = (TextBox)listView.InsertItem.FindControl("ManageLpTextBox");
            installationDropDownList = (DropDownList)
                listView.InsertItem.FindControl("InstallationDropDownList");
            partNumberTextBox = (TextBox)listView.InsertItem.FindControl("PartNumberTextBox");
            e.Values["WasteRecordCard.Id"] = Request["WasteRecordCardId"];
            if (e.Values["ManageDryMass"] == null) e.Values["ManageDryMass"] = 0;
            e.Values["ReceivedMass"] = 0;
            e.Values["ReceivedDryMass"] = 0;
            e.Values["CreatedMass"] = 0;
            e.Values["CreatedDryMass"] = 0;
            e.Values["TransferMass"] = 0;
            e.Values["TransferDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
            e.Values["ProcessingMethod.Id"] = processingMethodDropDownList.SelectedValue;

            if (inInstallationCheckBox.Checked)
            {
                e.Values["Installation.Id"] = installationDropDownList.SelectedValue;
                e.Values["PartNumber"] = partNumberTextBox.Text;
            }
            else e.Values["ManageLp"] = manageLpTextBox.Text;
        }

        protected void ListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownList processingMethodDropDownList, installationDropDownList;
            TextBox manageLpTextBox, partNumberTextBox;
            CheckBox inInstallationCheckBox;

            inInstallationCheckBox = (CheckBox)listView.EditItem.FindControl("InInstallationCheckBox");
            processingMethodDropDownList = (DropDownList)
                listView.EditItem.FindControl("ProcessingMethodDropDownList");
            manageLpTextBox = (TextBox)listView.EditItem.FindControl("ManageLpTextBox");
            installationDropDownList = (DropDownList)
                listView.EditItem.FindControl("InstallationDropDownList");
            partNumberTextBox = (TextBox)listView.EditItem.FindControl("PartNumberTextBox");
            e.NewValues["ProcessingMethod.Id"] = processingMethodDropDownList.SelectedValue;

            if (inInstallationCheckBox.Checked)
            {
                e.NewValues["Installation.Id"] = installationDropDownList.SelectedValue;
                e.NewValues["PartNumber"] = partNumberTextBox.Text;
                Common.SetToNull("ManageLp", e.NewValues, e.OldValues, " ");
            }
            else
            {
                Common.SetToNull("Installation.Id", e.NewValues, e.OldValues, 0);
                Common.SetToNull("PartNumber", e.NewValues, e.OldValues, 0);
                e.NewValues["ManageLp"] = manageLpTextBox.Text;
            }
        }
    }
}