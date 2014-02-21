/*
 * WLASCICIEL: mwionczyk
 * TABELE: Decision, DecisionElement
 * 
 * Strona pozwalająca zarządzać decyzjami. Na górze tabela powiązana z Decision, 
 * pod nią tabela powiązana z DecisionElement o wartość zależnej od wyboru z Decision.
 * Wybór oddziału z ComboBox'a.
*/

using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Decision1 : Page
    {
        private readonly EVidentDataModel _database;

        protected Decision1()
        {
            _database = Common.GetNotCachedDataModel();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DecisionElementPanel.Visible = (DecisionsListView.SelectedDataKey != null);
        }

        protected void DecisionElementListView_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            /*
         * WasteCode.Id WasteCodesDropDownList2
         * Installation.Id InstallationDropDownList2
         * ProcessingMethod.Id ProcessingMethodDropDownList2
         * Installation1.Id Installation1DropDownList2
         * ProcessingMethod1.Id ProcessingMethod1DropDownList2
         * Installation2.Id Installation2DropDownList2
         */
            DropDownList wasteCodesDropDownList = e.Item.FindControl("WasteCodesDropDownList2") as DropDownList;
            DropDownList installationDropDownList = e.Item.FindControl("InstallationDropDownList2") as DropDownList;
            DropDownList processingMethodDropDownList =
                e.Item.FindControl("ProcessingMethodDropDownList2") as DropDownList;
            DropDownList installation1DropDownList = e.Item.FindControl("Installation1DropDownList2") as DropDownList;
            DropDownList processingMethod1DropDownList =
                e.Item.FindControl("ProcessingMethod1DropDownList2") as DropDownList;
            DropDownList installation2DropDownList = e.Item.FindControl("Installation2DropDownList2") as DropDownList;
            if (wasteCodesDropDownList != null)
                e.Values["WasteCode.Id"] = long.Parse(wasteCodesDropDownList.SelectedValue);
            if (installationDropDownList != null && installationDropDownList.SelectedValue != "")
                e.Values["Installation.Id"] = long.Parse(installationDropDownList.SelectedValue);
            if (processingMethodDropDownList != null && processingMethodDropDownList.SelectedValue != "")
                e.Values["ProcessingMethod.Id"] = long.Parse(processingMethodDropDownList.SelectedValue);
            if (installation1DropDownList != null && installation1DropDownList.SelectedValue != "")
                e.Values["Installation1.Id"] = long.Parse(installation1DropDownList.SelectedValue);
            if (processingMethod1DropDownList != null && processingMethod1DropDownList.SelectedValue != "")
                e.Values["ProcessingMethod1.Id"] = long.Parse(processingMethod1DropDownList.SelectedValue);
            if (installation2DropDownList != null && installation2DropDownList.SelectedValue != "")
                e.Values["Installation2.Id"] = long.Parse(installation2DropDownList.SelectedValue);
        }

        protected void DecisionsListView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DecisionsListView.SelectedDataKey != null)
            {
                DecisionIdHiddenField.Value = DecisionsListView.SelectedDataKey.Value.ToString();
                DecisionElementListView.DataBind();
            }
            DecisionElementPanel.Visible = (DecisionsListView.SelectedDataKey != null);
        }

        protected void DecisionsListViewItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            long id = long.Parse(e.Keys["Id"].ToString());
            Decision decision = _database.Decisions.First(it => it.Id == id);
            decision.DecisionElements.Load();
            foreach (DecisionElement element in decision.DecisionElements.ToList())
            {
                _database.DeleteObject(element);
            }
            _database.SaveChanges();
            if (DecisionsListView.SelectedIndex != e.ItemIndex) return;
            DecisionIdHiddenField.Value = "";
            DecisionElementPanel.Visible = false;
        }

        protected void DecisionsListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            e.Values["Department.Id"] = (long)ApplicationUser.CurrentDepartmentId;
        }
    }
}