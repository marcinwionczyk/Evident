/*
 * WLASCICIEL: amadej
 * TABELE: brak
 * 
 * Wyczyszczenie danych sesji użytkownika.
*/

using System;
using EVident.Code;

namespace EVident
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ApplicationUser.LogOut();            
            Response.Redirect("~/Default.aspx");
        }
    }
}