/*
 * WLASCICIEL: phalladin
 * TABELE: Period
 * 
 * Pozwala wstawiać, edytować i usuwać okresy rozliczeniowe. Można zaznaczyć okres domyślny.
 * 
*/

using System;
using System.Linq;
using EVident.Code;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace EVident
{
    public partial class Period1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PeriodDataSourceUpdating(object sender, EntityDataSourceChangingEventArgs e)
        {
            Period period;

            period = (Period)e.Entity;
            if (period.IsMain) CancelMainPeriod(period);
        }

        private void CancelMainPeriod(Period period)
        {
            EVidentDataModel database;
            IEnumerable<Period> otherPeriods;

            database = Common.GetNotCachedDataModel();
            otherPeriods = from p in database.Periods
                           where p.Id != period.Id
                           select p;
            foreach (Period p in otherPeriods) p.IsMain = false;
            database.SaveChanges();
        }
    }
}