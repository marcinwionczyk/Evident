/*
 * WLASCICIEL: mwionczyk
 * TABELE: brak własnych (generowany z danych z innych tabel)
 * 
 * Raport o zgromadzonych i przekazanych ZSEiE. Działanie raportu można znaleźć w programie
 * Ewidencja Plus w Raporty -> Sprawozdania ZSEiE i Baterie -> Sprawozdanie ZSEiE
*/

using System;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class CommonWasteMovementReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void RaportButtonClick(object sender, EventArgs e)
        {
            if (Master == null) return;
            DropDownList period = Master.FindControl("periodDropDownList") as DropDownList;
            if (period == null) return;
            Response.Redirect("~/MovementZseieReportView.aspx?Year=" + period.SelectedItem.Text +
                              "&Id=" + ApplicationUser.CurrentCompanyId + "&Half=" + (YearHalfDDL.SelectedIndex + 1));
        }
    }
}