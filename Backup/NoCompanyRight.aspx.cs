using System;

namespace EVident
{
    public partial class NoCompanyRight : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pagePathLiteral.Text = Request["PagePath"];
        }
    }
}