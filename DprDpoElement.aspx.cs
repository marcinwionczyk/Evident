using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class DprDpoElement1 : System.Web.UI.Page
    {
        private EVidentDataModel database;
        private DprDpo dprDpo;

        protected void Page_Load(object sender, EventArgs e)
        {
            long dprDpoId;

            if (long.TryParse(Request.QueryString["Id"], out dprDpoId))
            {
                database = Common.GetDataModel();
                dprDpo = database.DprDpoes.Include("Contractor").First(d => d.Id == dprDpoId);
                contractorLiteral.Text = dprDpo.Contractor.ShortName;
                dprLiteral.Text = dprDpo.DprNumber;
                dpoLiteral.Text = dprDpo.DpoNumber;
                dprHyperLink.NavigateUrl = "./DprPrintView.aspx?Id=" + dprDpoId;
                dpoHyperLink.NavigateUrl = "./DpoPrintView.aspx?Id=" + dprDpoId;
            }
            else Response.Redirect("./Default.aspx", true);
        }

        protected void DprDpoElementListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList wasteCodeDropDownList, processingMethodDropDownList, 
                packageKindDropDownList, recyclingKindDropDownList;

            wasteCodeDropDownList = (DropDownList)dprDpoElementListView.InsertItem.FindControl("wasteCodeDropDownList");
            processingMethodDropDownList = (DropDownList)dprDpoElementListView.InsertItem.FindControl("processingMethodDropDownList");
            packageKindDropDownList = (DropDownList)dprDpoElementListView.InsertItem.FindControl("packageKindDropDownList");
            recyclingKindDropDownList = (DropDownList)dprDpoElementListView.InsertItem.FindControl("recyclingKindDropDownList");
            e.Values["WasteCode.Id"] = wasteCodeDropDownList.SelectedValue;
            e.Values["ProcessingMethod.Id"] = processingMethodDropDownList.SelectedValue;
            e.Values["PackageKind.Id"] = packageKindDropDownList.SelectedValue;
            e.Values["RecyclingKind.Id"] = recyclingKindDropDownList.SelectedValue;
        }

        protected void DprDpoElementListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DropDownList wasteCodeDropDownList, processingMethodDropDownList,
                packageKindDropDownList, recyclingKindDropDownList;

            wasteCodeDropDownList = (DropDownList)dprDpoElementListView.EditItem.FindControl("wasteCodeDropDownList");
            processingMethodDropDownList = (DropDownList)dprDpoElementListView.EditItem.FindControl("processingMethodDropDownList");
            packageKindDropDownList = (DropDownList)dprDpoElementListView.EditItem.FindControl("packageKindDropDownList");
            recyclingKindDropDownList = (DropDownList)dprDpoElementListView.EditItem.FindControl("recyclingKindDropDownList");
            e.NewValues["WasteCode.Id"] = wasteCodeDropDownList.SelectedValue;
            e.NewValues["ProcessingMethod.Id"] = processingMethodDropDownList.SelectedValue;
            e.NewValues["PackageKind.Id"] = packageKindDropDownList.SelectedValue;
            e.NewValues["RecyclingKind.Id"] = recyclingKindDropDownList.SelectedValue;
        }
    }
}