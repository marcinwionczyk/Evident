using System;
using EVident.Code;
using System.Data.Common;

namespace EVident.UserControl
{
    public partial class AnnualReportSection2Table : System.Web.UI.UserControl
    {
        public int FillUi(EVidentDataModel database, long companyId, long periodId)
        {
            DbDataReader reader;
            string query;
            int lp;

            query = string.Format(
                "SELECT wc.Name, wc.Description, SUM(wrce.CreatedMass) AS Mass, SUM(wrce.CreatedDryMass) AS DryMass " +
                "FROM WasteRecordCardElement wrce " +
                "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
                "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
                "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
                "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
                "WHERE d.CompanyId = {0} " +
                "AND p.Id = {1} " +
                "GROUP BY wc.Name, wc.Description " +
                "HAVING SUM(wrce.CreatedMass) > 0 " +
                "ORDER BY wc.Name", companyId, periodId);
            lp = 0;

            using (reader = database.ExecuteReader(query))
            {
                while (reader.Read()) section2Table.Rows.Add(
                    Common.GetHtmlTableRow(++lp, reader["Name"], reader["Description"], 
                    Common.GetMassString(reader["Mass"], true), Common.GetMassString(reader["DryMass"], true))); 
            }
            return lp;
        }
    }
}