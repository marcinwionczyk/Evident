/*
 * WLASCICIEL: mwionczyk
 * TABELE: Installation
 * 
 * Pozwala wstawiać, edytować i usuwać instalacje.
*/

using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Installation1 : Page
    {
        private readonly EVidentDataModel _database;

        protected Installation1()
        {
            _database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void InstallationListView_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList installationKindDropDownList, installationProcessingMethodsDropDownList;
            long installationKindSelectedValue, installationProcessingMethodSelectedValue;
            long? departmentId = ApplicationUser.CurrentDepartmentId;

            installationKindDropDownList = (DropDownList) e.Item.FindControl("InstallationKindDropDownList");
            installationProcessingMethodsDropDownList =
                (DropDownList) e.Item.FindControl("InstallationProcessingMethodsDropDownList");

            installationKindSelectedValue = long.Parse(installationKindDropDownList.SelectedValue);
            installationProcessingMethodSelectedValue =
                long.Parse(installationProcessingMethodsDropDownList.SelectedValue);
            if (departmentId == null) return;
            e.Values["InstallationKind.Id"] = installationKindSelectedValue;
            e.Values["InstallationProcessingMethod.Id"] = installationProcessingMethodSelectedValue;
            e.Values["Department.Id"] = departmentId;
        }

        protected void InstallationKindDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList installationKindDropDownList;
            Literal installationKindDescriptionLiteral;

            installationKindDropDownList = (DropDownList) sender;
            installationKindDescriptionLiteral = (Literal)
                                                 installationKindDropDownList.Parent.FindControl(
                                                     "InstallationKindDescriptionLiteral");
            long selectedValue = long.Parse(installationKindDropDownList.SelectedValue);
            InstallationKind kind = _database.InstallationKinds.First(i => i.Id == selectedValue);
            installationKindDescriptionLiteral.Text = kind.Description;
            
        }

        protected void InstallationListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            LinkButton deleteButton = (LinkButton) e.Item.FindControl("DeleteButton");
            Installation installation = ((ListViewDataItem) e.Item).DataItem.GetEntityAs<Installation>();
            if (!installation.DecisionElements.Any() && !installation.DecisionElements1.Any() &&
                !installation.DecisionElements2.Any() && !installation.InstallationWasteCodes.Any()) return;
            if (deleteButton == null) return;
            deleteButton.Enabled = false;
            deleteButton.OnClientClick = "";
        }

        protected void InstallationListView_DataBound(object sender, EventArgs e)
        {
            Literal installationKindDescriptionLiteral = (Literal)
                InstallationListView.InsertItem.FindControl("InstallationKindDescriptionLiteral");
            DropDownList installationKindDropDownList = (DropDownList)
                InstallationListView.InsertItem.FindControl("InstallationKindDropDownList");
            installationKindDropDownList.DataBind();
            long selectedValue = long.Parse(installationKindDropDownList.SelectedValue);
            InstallationKind kind = _database.InstallationKinds.First(i => i.Id == selectedValue);
            installationKindDescriptionLiteral.Text = kind.Description;
        }
    }
}