using System;
using EVident.Code;
using System.Data.Common;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;

namespace EVident.UserControl
{
    public partial class AnnualReportSection7Table : System.Web.UI.UserControl
    {
        public int FillUi(EVidentDataModel database, long companyId, long periodId)
        {
            DbDataReader majorReader, minorReader;
            string majorQuery, minorQuery;
            long wasteCodeId, installationId, processingMethodId;
            List<object> minorList;
            int lp;

            majorQuery = string.Format(
                "SELECT i.Name, ik.Name AS InstallationKind, i.ProcessingLimit, i.ProcessingCapacity, " +
                "wc.Name AS WasteCodeName, wc.Description AS WasteCodeDescription, pm.Name AS ProcessingMethod, " +
                "SUM(wrce.ManageMass) AS ManageMass, SUM(wrce.ManageDryMass) AS ManageDryMass, " +
                "wc.Id AS WasteCodeId, i.Id AS InstallationId, pm.Id AS ProcessingMethodId " +
                "FROM Installation i " +
                "INNER JOIN InstallationKind ik ON ik.Id = i.InstallationKindId " +
                "INNER JOIN Department d ON d.Id = i.DepartmentId " +
                "INNER JOIN Company c ON c.Id = d.CompanyId " +
                "INNER JOIN WasteRecordCard wrc ON d.Id = wrc.DepartmentId " +
                "INNER JOIN WasteRecordCardElement wrce ON wrc.Id = wrce.WasteRecordCardId " +
                "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
                "INNER JOIN ProcessingMethod pm ON pm.Id = wrce.ManageProcessingMethodId " +
                "WHERE i.Id = wrce.ManageInstallationId " +
                "AND c.Id = {0} " +
                "AND wrc.PeriodId = {1} " +
                "AND (wrce.Kind = 6 OR wrce.Kind = -7) " +
                "GROUP BY i.Name, ik.Name, i.ProcessingLimit, i.ProcessingCapacity, wc.Name, wc.Description, pm.Name, wc.Id, i.Id, pm.Id " +
                "ORDER BY i.Name, wc.Name, pm.Name", companyId, periodId);
            lp = 0;

            using (majorReader = database.ExecuteReader(majorQuery))
            {
                while (majorReader.Read())
                {
                    wasteCodeId = Convert.ToInt64(majorReader["WasteCodeId"]);
                    installationId = Convert.ToInt64(majorReader["InstallationId"]);
                    processingMethodId = Convert.ToInt64(majorReader["ProcessingMethodId"]);
                    minorQuery = string.Format(
                        "SELECT wc.Name AS WasteCodeName, wc.Description AS WasteCodeDescription, " +
                        "SUM(wrce.CreatedMass) AS CreatedMass, SUM(wrce.CreatedDryMass) AS CreatedDryMass " +
                        "FROM WasteRecordCardElement wrce " +
                        "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
                        "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
                        "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
                        "INNER JOIN Company c ON c.Id = d.CompanyId " +
                        "WHERE c.Id = {0} " +
                        "AND wrc.PeriodId = {1} " +
                        "AND wrce.Kind = 1 " +
                        "AND wrce.PartNumber IS NOT NULL " +
                        "AND wrce.PartNumber IN " +
                        "( " +
                        "SELECT _wrce.PartNumber " +
                        "FROM WasteRecordCardElement _wrce " +
                        "INNER JOIN WasteRecordCard _wrc ON _wrc.Id = _wrce.WasteRecordCardId " +
                        "INNER JOIN WasteCode _wc ON _wc.Id = _wrc.WasteCodeId " +
                        "INNER JOIN Department _d ON _d.Id = _wrc.DepartmentId " +
                        "INNER JOIN Company _c ON _c.Id = _d.CompanyId " +
                        "INNER JOIN Installation _i ON _i.Id = _wrce.ManageInstallationId " +
                        "INNER JOIN ProcessingMethod _pm ON _pm.Id = _wrce.ManageProcessingMethodId " +
                        "WHERE _c.Id = {0} " +
                        "AND _wrc.PeriodId = {1} " +
                        "AND (_wrce.Kind = 6 OR _wrce.Kind = -7) " +
                        "AND _wc.Id = {2} " +
                        "AND _i.Id = {3} " +
                        "AND _pm.Id = {4} " +
                        ") " +
                        "GROUP BY wc.Name, wc.Description " +
                        "ORDER BY wc.Name ", companyId, periodId, wasteCodeId, installationId, processingMethodId);

                    using (minorReader = database.ExecuteReader(minorQuery))
                    {
                        minorList = new List<object>();
                        while (minorReader.Read())
                        {
                            minorList.Add(new string[]
                            {
                                minorReader["WasteCodeName"] + "",
                                minorReader["WasteCodeDescription"] + "",
                                Common.GetMassString(minorReader["CreatedMass"], true),
                                Common.GetMassString(minorReader["CreatedMass"], true),
                            });
                        }
                    }
                    UpdateTableData(++lp, majorReader, minorList);
                }
                return lp;
            }
        }

        private void UpdateTableData(int lp, DbDataReader majorReader, List<object> minorList)
        {
            HtmlTableRow row;

            if (minorList.Count == 0) minorList.Add(new string[] { "---", "---", "---", "---" });
            row = Common.GetHtmlTableRow(lp, majorReader["Name"], "---", majorReader["InstallationKind"], "---",
                Common.GetMassString(majorReader["ProcessingLimit"], true),
                Common.GetMassString(majorReader["ProcessingCapacity"], true), majorReader["WasteCodeName"],
                majorReader["WasteCodeDescription"], majorReader["ProcessingMethod"],
                Common.GetMassString(majorReader["ManageMass"], true),
                Common.GetMassString(majorReader["ManageDryMass"], true));
            foreach (HtmlTableCell cell in row.Cells) cell.RowSpan = minorList.Count;

            foreach (string[] minorRow in minorList)
            {
                row.Cells.Add(Common.GetHtmlTableCell(minorRow[0]));
                row.Cells.Add(Common.GetHtmlTableCell(minorRow[1]));
                row.Cells.Add(Common.GetHtmlTableCell(minorRow[2]));
                row.Cells.Add(Common.GetHtmlTableCell(minorRow[3]));
                section7Table.Rows.Add(row);
                row = new HtmlTableRow();
            }
        }
    }
}