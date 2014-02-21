using System;
using System.Linq;
using EVident.Code;
using System.Web.UI;
using System.Collections.Generic;

namespace EVident
{
    public partial class DprPrintView : System.Web.UI.Page
    {
        public DprPrintView()
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            long dprDpoId;

            if (!long.TryParse(Request["Id"], out dprDpoId)) 
                Response.Redirect("./Default.aspx", true);
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
