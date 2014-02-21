/*
 * WLASCICIEL: phalladin
 * TABELE: brak własnych (generowany z danych z innych tabel)
 * 
 * Obowiązkowy raport składany co rok (do 15 marca) do gminy. 
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class AnnualReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            goToReportHyperLink.NavigateUrl = 
                "./AnnualReportPrintView.aspx?Id=" + yearDropDownList.SelectedValue;
        }
    }
}