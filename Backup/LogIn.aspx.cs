/*
 * WLASCICIEL: amadej
 * TABELE: Company
 * 
 * Logowanie użytkownika.
 * 
 * - Na podstawie jakiej tabeli ma odbyć się logowanie?
*/

using System;
using System.Linq;
using EVident.Code;

namespace EVident
{
    public partial class LogIn : System.Web.UI.Page
    {
        private EVidentDataModel _database;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void zalogujButton_Click(object sender, EventArgs e)
        {
            Company company;
            byte[] md5;

            _database = Common.GetDataModel();
            string login = loginTextBox.Text.Trim();            
            md5 = Common.Md5(hasloTextBox.Text.Trim());            
            try
            {
                company = _database.Companies.Include("Departments").FirstOrDefault(c => c.Login == login && c.PasswordHash == md5);
                ApplicationUser.LogIn(company);
                if (Session["LastPage"] != null) Response.Redirect((string)Session["LastPage"]);
                Response.Redirect("./Company.aspx");
            }
            catch (InvalidOperationException)
            {
                komunikatLabel.Visible = true;
                komunikatLabel.Text = "Wprowadzono błędny login lub hasło.";
            } 
        }
    }
}