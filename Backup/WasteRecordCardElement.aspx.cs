using System;

namespace EVident
{
    public partial class WasteRecordCardElement1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            long wasteRecordCardId;
            int wasteRecordCardElementKind;
            string url;

            url = null;
            if (long.TryParse(Request["Id"], out wasteRecordCardId) &&
                int.TryParse(Request["Kind"], out wasteRecordCardElementKind))
            {
                switch (wasteRecordCardElementKind)
                {
                    case 1: url = "./Creation.aspx"; break;
                    case 2: url = "./Collection.aspx"; break;
                    case 3: url = "./CollectionZseie.aspx"; break;
                    case 4: url = "./CollectionBattery.aspx"; break;
                    case 5: url = "./CollectionMetal.aspx"; break;
                    case 6: url = "./Recycling.aspx"; break;
                    case -7: url = "./Destruction.aspx"; break;
                    case -8: url = "./Transfer.aspx"; break;
                    case -9: url = "./TransferZseie.aspx"; break;
                    case -10: url = "./TransferBattery.aspx"; break;
                    case -11: url = "./TransferIndividual.aspx"; break;
                }

                if (url != null) url += "?WasteRecordCardId=" + wasteRecordCardId;
                else url = "./Default.aspx";
            }
            else url = "./Default.aspx";
            Response.Redirect(url, true);
        }
    }
}