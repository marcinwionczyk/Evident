using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident
{
    public partial class WasteRecordCard1 : System.Web.UI.Page
    {
        private const string TIP = "(wybór karty)";
        private EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            database = Common.GetDataModel();
            tipLiteral.Text = !string.IsNullOrEmpty(Request["Kind"]) ? TIP : "";
        }

        protected void WasteRecordCardListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            DropDownList wasteCodeDropDownList;

            wasteCodeDropDownList = (DropDownList)
                wasteRecordCardListView.InsertItem.FindControl("wasteCodeDropDownList");
            if (WasteCodeCount(wasteCodeDropDownList.SelectedItem.Text) > 0)
            {
                duplicatedWasteCodeLabel.Visible = true;
                e.Cancel = true;
            }
            else e.Values["WasteCode.Id"] = long.Parse(wasteCodeDropDownList.SelectedValue);
        }

        private int WasteCodeCount(string wasteCode)
        {
            return (from wrc in database.WasteRecordCards
                    where wrc.Department.Id == ApplicationUser.CurrentDepartmentId &&
                    wrc.Period.Id == ApplicationUser.CurrentPeriodId &&
                    wrc.WasteCode.Name == wasteCode
                    select wrc).Count();
        }

        private void WasteCodeDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox numberTextBox;
            DropDownList wasteCodeDropDownList;
            Label wasteCodeDescriptionLabel;
            Period period;
            int nextNumber = 0;
            long id;
            string wasteCode;

            numberTextBox = (TextBox)wasteRecordCardListView.InsertItem.FindControl("numberTextBox");
            wasteCodeDescriptionLabel = (Label)wasteRecordCardListView.InsertItem.FindControl("wasteCodeDescriptionLabel");
            wasteCodeDropDownList = (DropDownList)sender;

            if (ApplicationUser.CurrentDepartmentId != null && ApplicationUser.CurrentPeriodId != null)
                    nextNumber = database.GetNextWasteRecordCardNumber(
                        (long) ApplicationUser.CurrentDepartmentId, (long) ApplicationUser.CurrentPeriodId);
            wasteCode = wasteCodeDropDownList.SelectedItem.Text;
            wasteCode = wasteCode.Replace(" ", "").Replace("*", "");
            period = database.Periods.First(p => p.Id == (long)ApplicationUser.CurrentPeriodId);
            numberTextBox.Text = string.Format("{0:0000}/{1}/{2}", nextNumber, wasteCode, period.DateFrom.Year);
            id = long.Parse(wasteCodeDropDownList.SelectedValue);
            wasteCodeDescriptionLabel.Text = database.WasteCodes.First(wc => wc.Id == id).Description;
        }

        protected void WasteRecordCardListViewItemCreated(object sender, ListViewItemEventArgs e)
        {
            DropDownList wasteCodeDropDownList;

            if (e.Item == wasteRecordCardListView.InsertItem)
            {
                wasteCodeDropDownList = (DropDownList)e.Item.FindControl("wasteCodeDropDownList");
                wasteCodeDropDownList.SelectedIndexChanged += WasteCodeDropDownListSelectedIndexChanged;
                wasteCodeDropDownList.DataBound += WasteCodeDropDownListDataBound;
            }
        }

        private void WasteCodeDropDownListDataBound(object sender, EventArgs e)
        {
            if (!IsPostBack) WasteCodeDropDownListSelectedIndexChanged(sender, e);
        }
    }
}