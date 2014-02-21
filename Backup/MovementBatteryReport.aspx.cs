/*
 * WLASCICIEL: mwionczyk
 * TABELE: brak własnych (generowany z danych z innych tabel)
 * 
 * Raport o zgromadzonych i przekazanych bateriach. Działanie raportu można znaleźć w programie
 * Ewidencja Plus w Raporty -> Sprawozdania ZSEiE i Baterie -> Sprawozdanie o masie zebranych baterii.
*/

using System;
using System.Linq;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class BatteryWasteMovementReport : System.Web.UI.Page
    {
        private EVidentDataModel _database;
        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            IQueryable<int> years =
                _database.WasteRecordCardElements.Include("WasteRecordCard.WasteCode").Where(
                    w =>
                    w.WasteRecordCard.WasteCode.IsBattery &&
                    w.WasteRecordCard.Department.Company.Id == ApplicationUser.CurrentCompanyId).Select(w => w.Date.Year).Distinct();
            foreach (int year in years)
            {
                ListItem item = new ListItem(year.ToString());
                YearDDL.Items.Add(item);
            }
        }

        protected void RaportButtonClick(object sender, EventArgs e)
        {
            Response.Redirect("~/MovementBatteryReportView.aspx?Year=" + YearDDL.SelectedItem.Text + "&Id=" + ApplicationUser.CurrentCompanyId);
        }
    }
}