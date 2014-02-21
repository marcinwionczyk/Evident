/*
 * WLASCICIEL: phalladin
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca przyjęcie metali. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy przyjęciu metali:
 * 
 * 	+5. PRZYJĘCIE METALI.
	*****************************************************************************************
	* - data                                                                                *
	* - masa przyjętych odpadów                                                             *
	* - sucha masa przyjętych odpadów                                                       *
	* - nr formularza (nadawany automatycznie)                                              *
	* - imię i nazwisko                                                                     *
	* - PESEL                                                                               *
	* - nr dokumentu tożsamości                                                             *
	* - nazwa i adres siedziby przedsiębiorstwa przekazującego odpady                       *
	* - źródło pochodzenia odpadów                                                          *
	* - linia adresowa A (ulica i nr)                                                       *
	* - linia adresowa B (kod i miasto)                                                     *
	*****************************************************************************************
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class CollectionMetal : System.Web.UI.Page
    {
        private static readonly int KIND = 5;
        private EVidentDataModel database;

        public CollectionMetal()
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

        protected void ListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            e.Values["WasteRecordCard.Id"] = Request["WasteRecordCardId"];
            e.Values["ReceivedDryMass"] = 0;
            e.Values["CreatedMass"] = 0;
            e.Values["CreatedDryMass"] = 0;
            e.Values["ManageMass"] = 0;
            e.Values["ManageDryMass"] = 0;
            e.Values["TransferMass"] = 0;
            e.Values["TransferDryMass"] = 0;
            e.Values["IsBatteryFromCar"] = false;
            e.Values["IsPositive"] = true;
            e.Values["Kind"] = KIND;
            e.Values["IsFromHome"] = false;
        }

        protected void ListViewItemCreated(object sender, ListViewItemEventArgs e)
        {
            TextBox dateTextBox, receivedCardNumberTextBox;

            dateTextBox = (TextBox)listView.InsertItem.FindControl("DateTextBox");
            if (dateTextBox.Text == "") dateTextBox.Text = DateTime.Now.ToShortDateString();
            receivedCardNumberTextBox = (TextBox)
                listView.InsertItem.FindControl("ReceivedCardNumberTextBox");
            receivedCardNumberTextBox.Text = database.GetNextMetalFormNumber(
                ((Default)Master).GetCurrentWasteRecordCard().Id);
        }
    }
}