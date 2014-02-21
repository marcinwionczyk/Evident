using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;

namespace EVident.UserControl
{
    public partial class CommuneSelector : System.Web.UI.UserControl
    {
        private EVidentDataModel database;

        public CommuneSelector()
        {
            database = Common.GetNotCachedDataModel();
        }

        public long CommuneId
        {
            get
            {
                return long.Parse(communeDropDownList.SelectedValue);
            }

            set
            {
                Commune commune;

                commune = database.Communes.Include(
                    "District.Province").FirstOrDefault(c => c.Id == value);
                SelectCommuneDistrictProvince(commune);       
            }
        }

        public bool Enabled
        {
            get
            {
                return communeDropDownList.Enabled && 
                    districtDropDownList.Enabled && 
                    provinceDropDownList.Enabled;
            }

            set
            {
                communeDropDownList.Enabled = value;
                districtDropDownList.Enabled = value;
                provinceDropDownList.Enabled = value;
            }
        }

        private void SelectCommuneDistrictProvince(Commune commune)
        {
            if (commune != null)
            {
                provinceDropDownList.SelectedValue = commune.District.Province.Id + "";
                districtDropDownList.SelectedValue = commune.District.Id + "";
                communeDropDownList.SelectedValue = commune.Id + "";
            }
            else
            {
                AddAndSelectEmptyItemIfShould(provinceDropDownList);
                AddAndSelectEmptyItemIfShould(districtDropDownList);
                AddAndSelectEmptyItemIfShould(communeDropDownList);
            }
        }

        private void AddAndSelectEmptyItemIfShould(DropDownList dropDownList)
        {
            if (dropDownList.Items.Count > 0 && dropDownList.Items[0].Text != "")
            {
                dropDownList.Items.Insert(0, new ListItem("", ""));
                // dropDownList.SelectedValue = ""; ZERUJEMY TYLKO KOMBO Z GMINĄ
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (provinceDropDownList.Items.Count == 0)
            {
                provinceDropDownList.DataSource = provinceDataSource;
                provinceDropDownList.DataBind();
                ProvinceDropDownListSelectedIndexChanged(sender, e);
            }
        }

        protected void ProvinceDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            districtDropDownList.DataSource = districtDataSource;
            districtDropDownList.DataBind();
            DistrictDropDownListSelectedIndexChanged(sender, e);
        }

        protected void DistrictDropDownListSelectedIndexChanged(object sender, EventArgs e)
        {
            communeDropDownList.DataSource = communeDataSource;
            communeDropDownList.DataBind();
        }
    }
}