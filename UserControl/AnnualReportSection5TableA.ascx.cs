using System;
using EVident.Code;
using System.Data.Common;

namespace EVident.UserControl
{
    public partial class AnnualReportSection5TableA : System.Web.UI.UserControl
    {
        public int FillUi(EVidentDataModel database, long companyId, long periodId)
        {
            DbDataReader reader;
            string query;
            int lp;

            query = string.Format(
                "SELECT wc.Name, wc.Description, SUM(wrce.ManageMass) AS Mass, " +
                "SUM(wrce.ManageDryMass) AS DryMass, pm.Name AS ProcessingMethodName " +
                "FROM WasteRecordCardElement wrce " +
                "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
                "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
                "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
                "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
                "INNER JOIN ProcessingMethod pm ON pm.Id = wrce.ManageProcessingMethodId " +
                "WHERE d.CompanyId = {0} " +
                "AND p.Id = {1} " +
                "AND wrce.Kind = 6 " +
                "AND wrce.ManageInstallationId IS NOT NULL " +
                "GROUP BY wc.Name, wc.Description, pm.Name " +
                "HAVING SUM(wrce.ManageMass) > 0 " +
                "ORDER BY wc.Name", companyId, periodId);
            lp = 0;

            using (reader = database.ExecuteReader(query))
            {
                while (reader.Read()) section5TableA.Rows.Add(
                    Common.GetHtmlTableRow(++lp, reader["Name"], reader["Description"],
                    Common.GetMassString(reader["Mass"], true), Common.GetMassString(reader["DryMass"], true), 
                    reader["ProcessingMethodName"]));
            }
            return lp;
        }
    }
}