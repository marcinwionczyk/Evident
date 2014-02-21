using System;
using System.Data;
using System.Linq;
using EVident.Code;
using System.Data.Common;
using System.Data.EntityClient;
using System.Collections.Generic;
using System.Data.Objects.DataClasses;

namespace EVident
{
    public partial class EVidentDataModel
    {
        // pozwala wywołać komendę natywną - dla serwera - komendę SQL
        // komendy powinny zwracać dane (wiersze)
        public DbDataReader ExecuteReader(string nativeSql)
        {
            DbConnection connection;
            ConnectionState initialState;
            DbCommand command;

            connection = ((EntityConnection)Connection).StoreConnection;
            initialState = connection.State;
            if (initialState != ConnectionState.Open) connection.Open();
            command = connection.CreateCommand();
            command.CommandText = nativeSql;
            return command.ExecuteReader((initialState != ConnectionState.Open) ? 
                CommandBehavior.CloseConnection : CommandBehavior.Default);
        }

        public object ExecuteScalar(string nativeSql)
        {
            DbConnection connection;
            ConnectionState initialState;
            DbCommand command;

            connection = ((EntityConnection)Connection).StoreConnection;
            initialState = connection.State;
            try
            {
                if (initialState != ConnectionState.Open) connection.Open();
                command = connection.CreateCommand();
                command.CommandText = nativeSql;
                return command.ExecuteScalar();
            }
            finally
            {
                if (initialState != ConnectionState.Open) connection.Close();
            }
        }

        // pobieramy te decyzje, które obowiązują w okresie rozliczeniowym
        // korzystamy z własności nakładania się przedziałów
        // s2 < e1 && s1 < e2 -> przedziały nakładają się gdy wynik będzie true
        // przedziały to i1 = (s1, e1) oraz i2 = (s2, e2)
        // i1 -> decyzja, i2 -> okres rozliczeniowy
        public List<Decision> GetCurrentDecisionList(long departmentId, Period period)
        {
            return (from d in Decisions.Include("DecisionElements")
                    where d.Department.Id == departmentId &&
                    period.DateFrom < d.ValidTo &&
                    period.DateTo > d.ValidFrom
                    orderby d.ReleaseDate
                    select d).ToList();
        }

        public List<Decision> GetCreationDecisionList(List<Decision> decisionList)
        {
            return (from d in decisionList
                    where d.DecisionElements.Any(de => de.CreatedLimit > 0)
                    select d).ToList();
        }

        public List<Decision> GetCollectionDecisionList(List<Decision> decisionList)
        {
            return (from d in decisionList
                    where d.DecisionElements.Any(de => de.CanCollect)
                    select d).ToList();
        }

        public List<Decision> GetRecyclingDecisionList(List<Decision> decisionList)
        {
            return (from d in decisionList
                    where d.DecisionElements.Any(de => de.RecycledLimit > 0)
                    select d).ToList();
        }

        public List<Decision> GetDestructionDecisionList(List<Decision> decisionList)
        {
            return (from d in decisionList
                    where d.DecisionElements.Any(de => de.DestroyedLimit > 0)
                    select d).ToList();
        }

        public List<Decision> GetCommunalDecisionList(List<Decision> decisionList)
        {
            throw new NotImplementedException();
        }

        public int GetNextPartNumber(long wasteRecordCardId)
        {
            int? n;

            n = WasteRecordCardElements.
                Where(w => w.WasteRecordCard.Id == wasteRecordCardId && (w.Kind == 6 || w.Kind == -7)).
                Select(w => w.PartNumber).Max();
            if (n != null) return n.Value + 1;
            return 1;
        }

        public string GetNextTransferCardNumber(long wasteRecordCardId)
        {
            IEnumerable<WasteTransferCard> transferCards;
            int maximum, index, lp;
            WasteCode wasteCode;
            Period period;

            transferCards = from wtc in WasteTransferCards
                            where wtc.WasteRecordCard.Id == wasteRecordCardId
                            select wtc;

            maximum = 0;
            foreach (WasteTransferCard transferCard in transferCards)
            {
                index = transferCard.TransferCardNumber.IndexOf('/');
                if (index > 0 && int.TryParse(
                    transferCard.TransferCardNumber.Substring(0, index), out lp) && lp > maximum)
                    maximum = lp;
            }

            wasteCode = (from wrc in WasteRecordCards
                        where wrc.Id == wasteRecordCardId
                        select wrc.WasteCode).First();
            period = (from wrc in WasteRecordCards
                      where wrc.Id == wasteRecordCardId
                      select wrc.Period).First();
            return string.Format("{0:000000}/{1}/{2}", 
                maximum + 1, wasteCode.Name.Replace(" ", ""), period.DateFrom.Year);
        }

        public Company GetCurrentCompany()
        {
            return Companies.Include("Commune.District.Province").
                First(c => c.Id == ApplicationUser.CurrentCompanyId);
        }

        public Department GetCurrentDepartment()
        {
            return Departments
                .Include("Commune.District.Province").First(c => c.Id == ApplicationUser.CurrentDepartmentId);
        }

        public Period GetMainPeriodOrFirst()
        {
            Period period;

            period = Periods.FirstOrDefault(p => p.IsMain);
            if (period == null) period = Periods.First();
            return period;
        }

        public string GetConfigurationValue(string key)
        {
            return Configurations.Where(c => c.Key == key).Select(c => c.Value).First();
        }

        public int GetNextWasteRecordCardNumber(long departmentId, long periodId)
        {
            var wasteRecordCards = WasteRecordCards.Where(wrc => wrc.Department.Id == departmentId &&
                                        wrc.Period.Id == periodId).OrderByDescending(wrc => wrc.Number);

            int currentNumber = 0;
            foreach (var wasteRecordCard in wasteRecordCards)
            {
                if (wasteRecordCard.Number.Length == 16)
                {
                    string firstPart = wasteRecordCard.Number.Substring(0, 4);
                    int n;
                    if (int.TryParse(firstPart, out n) && currentNumber < n) currentNumber = n;
                }
            }
            return currentNumber + 1;
        }

        public string GetNextMetalFormNumber(long wasteRecordCardId)
        {
            int maximum, lp, index;
            IEnumerable<WasteRecordCardElement> elements;
            Period period;
            WasteCode wasteCode;

            elements = from wrce in WasteRecordCardElements
                       where wrce.WasteRecordCard.Id == wasteRecordCardId &&
                       wrce.Kind == 5
                       select wrce;
            maximum = 0;

            foreach (WasteRecordCardElement element in elements)
            {
                if (element.ReceivedCardNumber != null)
                {
                    index = element.ReceivedCardNumber.IndexOf('/');
                    if (index > 0 && int.TryParse(
                        element.ReceivedCardNumber.Substring(0, index), out lp) && lp > maximum)
                        maximum = lp;
                }
            }

            period = (from wrc in WasteRecordCards
                      where wrc.Id == wasteRecordCardId
                      select wrc.Period).First();
            wasteCode = (from wrc in WasteRecordCards
                         where wrc.Id == wasteRecordCardId
                         select wrc.WasteCode).First();

            return string.Format("{0:000000}/{1}/{2}", 
                maximum + 1, wasteCode.Name.Replace(" ", ""), period.DateFrom.Year);
        }

        public Department GetSelectedDepartment(long id)
        {
            return Departments.Include("Company.Commune.District.Province").FirstOrDefault(d => d.Id == id);
        }

        public double GetDprDpo00Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 0
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo10Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 1
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo20Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 2
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo30Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 3
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo40Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 4
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo60Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 6
                    select e.ReceivedMass).Sum();
        }

        public double GetDprDpo01Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 0 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo11Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 1 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo21Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 2 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo31Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 3 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo41Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 4 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo61Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 6 &&
                    e.RecyclingKind.Index == 1
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo02Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 0 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo12Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 1 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo22Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 2 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo32Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 3 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo42Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 4 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDprDpo62Value(DprDpo dprDpo, int kind)
        {
            return (from e in GetDprDpoElements(dprDpo, kind)
                    where e.PackageKind.Index == 6 &&
                    e.RecyclingKind.Index == 2
                    select e.RecycledMass).Sum();
        }

        public double GetDpo04Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 0 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo14Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 1 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo24Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 2 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo34Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 3 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo44Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 4 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo64Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 6 &&
                    e.RecyclingKind.Index == 4
                    select e.RecycledMass).Sum();
        }

        public double GetDpo05Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 0 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo15Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 1 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo25Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 2 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo35Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 3 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo45Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 4 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo65Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 6 &&
                    e.RecyclingKind.Index == 5
                    select e.RecycledMass).Sum();
        }

        public double GetDpo06Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 0 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        public double GetDpo16Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 1 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        public double GetDpo26Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 2 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        public double GetDpo36Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 3 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        public double GetDpo46Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 4 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        public double GetDpo66Value(DprDpo dprDpo)
        {
            return (from e in GetDprDpoElements(dprDpo, 0)
                    where e.PackageKind.Index == 6 &&
                    e.RecyclingKind.Index == 6
                    select e.RecycledMass).Sum();
        }

        private IEnumerable<DprDpoElement> GetDprDpoElements(DprDpo dprDpo, int kind)
        {
            IEnumerable<DprDpoElement> result;
            if (kind != -1) result = from e in DprDpoElements.
                                     Include("PackageKind").
                                     Include("RecyclingKind")
                                     where e.DprDpo.Id == dprDpo.Id &&
                                     e.RecyclingKind.Kind == kind
                                     select e;
            else result = from e in DprDpoElements.
                          Include("PackageKind").
                          Include("RecyclingKind")
                          where e.DprDpo.Id == dprDpo.Id
                          select e;
            return result;
        }
    }
}