using System;
using EVident.Code;
using System.Web.UI;

namespace EVident
{
    public partial class DpoPrintView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ExportToPdfButtonClick(object sender, EventArgs e)
        {
            Common.ExportToPdf(page, Response, "Eksport.pdf");
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}