using System;
using System.Data.Common;
using System.Collections.Generic;

namespace EVident.Code
{
    public class WarningChecker
    {
        private static readonly string CREATION_WARNING_QUERY =
            "FROM WasteRecordCardElement wrce " +
            "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
            "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
            "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
            "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
            "WHERE wrce.Kind = 1 " +
            "AND PgoCommuneId IS NULL " +
            "AND d.CompanyId = {0} " +
            "AND p.Id = {1} " +
            "AND wc.Id NOT IN " +
            "( " +
            "SELECT _wc.Id " +
            "FROM DecisionElement _de " +
            "INNER JOIN Decision _d ON _d.Id = _de.DecisionId " +
            "INNER JOIN WasteCode _wc ON _wc.Id = _de.WasteCodeId " +
            "INNER JOIN Department _dp ON _dp.Id = _d.DepartmentId " +
            "WHERE _d.ValidFrom < p.DateTo " +
            "AND _d.ValidTo > p.DateFrom " +
            "AND _dp.CompanyId = {0} " +
            ") ";
        private static readonly string RECYCLING_WARNING_QUERY =
            "FROM WasteRecordCardElement wrce " +
            "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " + 
            "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
            "INNER JOIN Department d ON d.Id = wrc.DepartmentId " + 
            "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
            "WHERE wrce.Kind = 6 " +
            "AND d.CompanyId = {0} " +
            "AND p.Id = {1} " +
            "AND wrce.ManageInstallationId IS NULL " +
            "AND wc.Id NOT IN " +
            "( " + 
            "SELECT _wc.Id " +
            "FROM DecisionElement _de " +
            "INNER JOIN Decision _d ON _d.Id = _de.DecisionId " +
            "INNER JOIN WasteCode _wc ON _wc.Id = _de.WasteCodeId " +
            "INNER JOIN Department _dp ON _dp.Id = _d.DepartmentId " +
            "WHERE _d.ValidFrom < p.DateTo " +
            "AND _d.ValidTo > p.DateFrom " +
            "AND _dp.CompanyId = {0} " +
            "AND _de.RecycledInstallationId IS NULL " +
            ") ";
        private static readonly string RECYCLING_IN_INSTALLATION_WARNING_QUERY =
            "FROM WasteRecordCardElement wrce " +
            "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
            "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
            "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
            "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
            "INNER JOIN Installation i ON i.Id = wrce.ManageInstallationId " +
            "WHERE wrce.Kind = 6 " +
            "AND d.CompanyId = {0} " +
            "AND p.Id = {1} " +
            "AND wrce.ManageInstallationId IS NOT NULL " +
            "AND wc.Id NOT IN " +
            "( " +
            "SELECT _wc.Id " +
            "FROM DecisionElement _de " +
            "INNER JOIN Decision _d ON _d.Id = _de.DecisionId " +
            "INNER JOIN WasteCode _wc ON _wc.Id = _de.WasteCodeId " +
            "INNER JOIN Department _dp ON _dp.Id = _d.DepartmentId " +
            "WHERE _d.ValidFrom < p.DateTo " +
            "AND _d.ValidTo > p.DateFrom " +
            "AND _dp.CompanyId = {0} " +
            "AND _de.RecycledInstallationId IS NOT NULL " +
            ") ";
        private static readonly string DESTRUCTION_WARNING_QUERY =
            "FROM WasteRecordCardElement wrce " +
            "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
            "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
            "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
            "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
            "WHERE wrce.Kind = -7 " +
            "AND d.CompanyId = {0} " +
            "AND p.Id = {1} " +
            "AND wrce.ManageInstallationId IS NULL " +
            "AND wc.Id NOT IN " +
            "( " +
            "SELECT _wc.Id " +
            "FROM DecisionElement _de " +
            "INNER JOIN Decision _d ON _d.Id = _de.DecisionId " +
            "INNER JOIN WasteCode _wc ON _wc.Id = _de.WasteCodeId " +
            "INNER JOIN Department _dp ON _dp.Id = _d.DepartmentId " +
            "WHERE _d.ValidFrom < p.DateTo " +
            "AND _d.ValidTo > p.DateFrom " +
            "AND _dp.CompanyId = {0} " +
            "AND _de.RecycledInstallationId IS NULL " +
            ") ";
        private static readonly string DESTRUCTION_IN_INSTALLATION_WARNING_QUERY =
            "FROM WasteRecordCardElement wrce " +
            "INNER JOIN WasteRecordCard wrc ON wrc.Id = wrce.WasteRecordCardId " +
            "INNER JOIN WasteCode wc ON wc.Id = wrc.WasteCodeId " +
            "INNER JOIN Department d ON d.Id = wrc.DepartmentId " +
            "INNER JOIN Period p ON p.Id = wrc.PeriodId " +
            "INNER JOIN Installation i ON i.Id = wrce.ManageInstallationId " +
            "WHERE wrce.Kind = -7 " +
            "AND d.CompanyId = {0} " +
            "AND p.Id = {1} " +
            "AND wrce.ManageInstallationId IS NOT NULL " +
            "AND wc.Id NOT IN " +
            "( " +
            "SELECT _wc.Id " +
            "FROM DecisionElement _de " +
            "INNER JOIN Decision _d ON _d.Id = _de.DecisionId " +
            "INNER JOIN WasteCode _wc ON _wc.Id = _de.WasteCodeId " +
            "INNER JOIN Department _dp ON _dp.Id = _d.DepartmentId " +
            "WHERE _d.ValidFrom < p.DateTo " +
            "AND _d.ValidTo > p.DateFrom " +
            "AND _dp.CompanyId = {0} " +
            "AND _de.RecycledInstallationId IS NOT NULL " +
            ") ";
        private EVidentDataModel database;
        private long companyId;
        private long periodId;

        public WarningChecker(EVidentDataModel database, long companyId, long periodId)
        {
            this.database = database;
            this.companyId = companyId;
            this.periodId = periodId;
        }

        public int GetCreationWarningCount()
        {
            return GetCount(string.Format(CREATION_WARNING_QUERY, companyId, periodId));
        }

        public List<Dictionary<string, string>> GetCreationWarningList()
        {
            return GetList(string.Format(CREATION_WARNING_QUERY, companyId, periodId), 
                "1", "wc.Name", "wrc.Number");
        }

        public List<Dictionary<string, string>> GetCreationInInstallationWarningList()
        {
            return null;
        }

        public int GetRecyclingWarningCount()
        {
            return GetCount(string.Format(RECYCLING_WARNING_QUERY, companyId, periodId));
        }

        public List<Dictionary<string, string>> GetRecyclingWarningList()
        {
            return GetList(string.Format(RECYCLING_WARNING_QUERY, companyId, periodId),
                "1", "wc.Name", "wrc.Number");
        }

        public int GetRecyclingInInstallationWarningCount()
        {
            return GetCount(string.Format(RECYCLING_IN_INSTALLATION_WARNING_QUERY, companyId, periodId));
        }

        public List<Dictionary<string, string>> GetRecyclingInInstallationWarningList()
        {
            return GetList(string.Format(RECYCLING_IN_INSTALLATION_WARNING_QUERY, companyId, periodId),
                "1", "wc.Name", "wrc.Number", "i.Name");
        }

        public int GetDestructionWarningCount()
        {
            return GetCount(string.Format(DESTRUCTION_WARNING_QUERY, companyId, periodId));
        }

        public List<Dictionary<string, string>> GetDestructionWarningList()
        {
            return GetList(string.Format(DESTRUCTION_WARNING_QUERY, companyId, periodId),
                "1", "wc.Name", "wrc.Number");
        }

        public int GetDestructionInInstallationWarningCount()
        {
            return GetCount(string.Format(DESTRUCTION_IN_INSTALLATION_WARNING_QUERY, companyId, periodId));
        }

        public List<Dictionary<string, string>> GetDestructionInInstallationWarningList()
        {
            return GetList(string.Format(DESTRUCTION_IN_INSTALLATION_WARNING_QUERY, companyId, periodId),
                "1", "wc.Name", "wrc.Number", "i.Name");
        }

        public List<Dictionary<string, string>> GetCollectionWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        // ###

        public List<Dictionary<string, string>> GetCreationLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public List<Dictionary<string, string>> GetCreationInInstallationLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public List<Dictionary<string, string>> GetRecyclingLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public List<Dictionary<string, string>> GetRecyclingInInstallationLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public List<Dictionary<string, string>> GetDestructionLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public List<Dictionary<string, string>> GetDestructionInInstallationLimitWarningList()
        {
            List<Dictionary<string, string>> result;

            result = new List<Dictionary<string, string>>();
            return result;
        }

        public int GetWarningCount()
        {
            return GetCreationWarningCount() +
                GetRecyclingWarningCount() +
                GetRecyclingInInstallationWarningCount() +
                GetDestructionWarningCount() +
                GetDestructionInInstallationWarningCount();
        }

        private int GetCount(string text)
        {
            text = "SELECT COUNT(*) " + text;
            return Convert.ToInt32(database.ExecuteScalar(text));
        }

        private List<Dictionary<string, string>> 
            GetList(string text, string orderBy, params string[] fields)
        {
            DbDataReader reader;
            List<Dictionary<string, string>> result;
            Dictionary<string, string> row;
            string select;
            int i;

            select = "SELECT ";
            foreach (string field in fields) select += field + ",";
            select = select.TrimEnd(',');
            text = select + " " + text + " ORDER BY " + orderBy;
            result = new List<Dictionary<string, string>>();

            using (reader = database.ExecuteReader(text))
            {
                while (reader.Read())
                {
                    row = new Dictionary<string, string>();
                    for (i = 0; i < reader.FieldCount; i++) row[i + ""] = reader[i] + "";
                    result.Add(row);
                }
            }
            return result;
        }
    }
}