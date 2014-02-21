/*
 * WLASCICIEL: phalladin
 * TABELE: DprDpo, DprDpoElement
*/

using System;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class DprDpo1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void DprDpoListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList contractorDropDownList;

            contractorDropDownList = (DropDownList) dprDpoListView.InsertItem.FindControl("contractorDropDownList");
            e.Values["Contractor.Id"] = contractorDropDownList.SelectedValue;
        }

        protected void DprDpoListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownList contractorDropDownList;

            contractorDropDownList = (DropDownList)dprDpoListView.EditItem.FindControl("contractorDropDownList");
            e.NewValues["Contractor.Id"] = contractorDropDownList.SelectedValue;
        }
    }
}