using System;
using System.Web.UI.WebControls;

namespace EVident.UserControl
{
    public partial class DropDownListExtended : DropDownList
    {
        protected override void PerformDataBinding(System.Collections.IEnumerable dataSource)
        {
            try
            {
                base.PerformDataBinding(dataSource);
            }
            catch (ArgumentOutOfRangeException) { }
        }
    }
}