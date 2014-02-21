using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class _Company : System.Web.UI.Page
    {
        private EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            database = Common.GetNotCachedDataModel();
        }

        protected void CompanyListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox passwordHashTextBox;

            passwordHashTextBox = (TextBox)companyListView.InsertItem.FindControl("PasswordHashTextBox");
            e.Values["PasswordHash"] = Common.Md5(passwordHashTextBox.Text);
            e.Values["RegisterNumber"] = "";
            e.Values["Commune.Id"] = database.Communes.First().Id;
            e.Values["Place"] = "";
            e.Values["Street"] = "";
            e.Values["BuildingNumber"] = "";
            e.Values["FlatNumber"] = "";
            e.Values["PostCode"] = "";
            e.Values["Nip"] = "";
            e.Values["Regon"] = "";
            e.Values["Phone"] = "";
            e.Values["Fax"] = "";
            e.Values["Email"] = "";
            e.Values["StartDate"] = DateTime.Parse("1970-01-01");
            e.Values["BusinessFirstName"] = "";
            e.Values["BusinessLastName"] = "";
            e.Values["BusinessPhone"] = "";
            e.Values["BusinessFax"] = "";
            e.Values["BusinessEmail"] = "";
        }

        protected void CompanyDataSourceInserted(object sender, EntityDataSourceChangedEventArgs e)
        {
            Company company;
            long id;

            id = ((Company)e.Entity).Id;
            company = database.Companies.First(c => c.Id == id);

            company.Departments.Add(new Department()
            {
                BuildingNumber = "",
                Commune = database.Communes.First(),
                Fax = "",
                FlatNumber = "",
                FullName = "Oddział główny",
                IsMain = true,
                Phone = "",
                Place = "",
                PostCode = "",
                StartDate = DateTime.Parse("1970-01-01"),
                Street = ""
            });
            database.SaveChanges();
        }

        protected void CompanyListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox passwordHashTextBox;

            passwordHashTextBox = (TextBox)companyListView.EditItem.FindControl("PasswordHashTextBox");
            if (passwordHashTextBox.Text != "") e.NewValues["PasswordHash"] = Common.Md5(passwordHashTextBox.Text);
        }
    }
}