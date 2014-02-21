using System;
using System.Linq;
using EVident.Code;
using System.Collections.Generic;

namespace EVident.UserControl
{
    public partial class AnnualReportSection1TableB : System.Web.UI.UserControl
    {
        public void FillUi(EVidentDataModel database, long departmentId, long periodId)
        {
            Department department;
            Period period;
            List<Decision> currentDecisionList, creationDecisionList, 
                collectionDecisionList, recyclingDecisionList, destructionDecisionList;

            department = database.Departments.
                Include("Commune.District.Province").First(d => d.Id == departmentId);
            period = database.Periods.First(p => p.Id == periodId);
            provinceLiteral.Text = department.Commune.District.Province.Name;
            communeLiteral.Text = department.Commune.District.Name;
            placeLiteral.Text = department.Place;
            streetLiteral.Text = department.Street;
            homeNumberLiteral.Text = department.BuildingNumber;
            flatNumberLiteral.Text = department.FlatNumber;
            startDateLiteral.Text = department.StartDate.ToShortDateString();
            if (department.EndDate != null) endDateLiteral.Text = department.EndDate.Value.ToShortDateString();
            currentDecisionList = database.GetCurrentDecisionList(department.Id, period);
            creationDecisionList = database.GetCreationDecisionList(currentDecisionList);
            creationDecisionNumberLiteral.Text = GetDecisionListNumber(creationDecisionList);
            creationDecisionReleaseDateLiteral.Text = GetDecisionListReleaseDate(creationDecisionList);
            creationDecisionPeriodLiteral.Text = GetDecisionListPeriod(creationDecisionList);
            creationDecisionReleaseAuthorityLiteral.Text = GetDecisionListReleaseAuthority(creationDecisionList);
            collectionDecisionList = database.GetCollectionDecisionList(currentDecisionList);
            collectionDecisionNumberLiteral.Text = GetDecisionListNumber(collectionDecisionList);
            collectionDecisionReleaseDateLiteral.Text = GetDecisionListReleaseDate(collectionDecisionList);
            collectionDecisionPeriodLiteral.Text = GetDecisionListPeriod(collectionDecisionList);
            collectionDecisionReleaseAuthorityLiteral.Text = GetDecisionListReleaseAuthority(collectionDecisionList);
            recyclingDecisionList = database.GetRecyclingDecisionList(currentDecisionList);
            recyclingDecisionNumberLiteral.Text = GetDecisionListNumber(recyclingDecisionList);
            recyclingDecisionReleaseDateLiteral.Text = GetDecisionListReleaseDate(recyclingDecisionList);
            recyclingDecisionPeriodLiteral.Text = GetDecisionListPeriod(recyclingDecisionList);
            recyclingDecisionReleaseAuthorityLiteral.Text = GetDecisionListReleaseAuthority(recyclingDecisionList);
            destructionDecisionList = database.GetDestructionDecisionList(currentDecisionList);
            destructionDecisionNumberLiteral.Text = GetDecisionListNumber(destructionDecisionList);
            destructionDecisionReleaseDateLiteral.Text = GetDecisionListReleaseDate(destructionDecisionList);
            destructionDecisionPeriodLiteral.Text = GetDecisionListPeriod(destructionDecisionList);
            destructionDecisionReleaseAuthorityLiteral.Text = GetDecisionListReleaseAuthority(destructionDecisionList);
            creationCheckBox.Checked = creationDecisionList.Count > 0;
            collectionCheckBox.Checked = collectionDecisionList.Count > 0;
            recyclingCheckBox.Checked = recyclingDecisionList.Count > 0;
            destructionCheckBox.Checked = destructionDecisionList.Count > 0;
        }

        private string GetDecisionListNumber(List<Decision> decisionList)
        {
            string result;

            result = "";
            foreach (Decision decision in decisionList) result += decision.Number + "<br />";
            return result;
        }

        private string GetDecisionListReleaseDate(List<Decision> decisionList)
        {
            string result;

            result = "";
            foreach (Decision decision in decisionList) 
                result += decision.ReleaseDate.ToShortDateString() + "<br />";
            return result;
        }

        private string GetDecisionListPeriod(List<Decision> decisionList)
        {
            string result;

            result = "";
            foreach (Decision decision in decisionList) 
                result += "od " + decision.ValidFrom.ToShortDateString() + 
                " do " + decision.ValidTo.ToShortDateString() + "<br />";
            return result;
        }

        private string GetDecisionListReleaseAuthority(List<Decision> decisionList)
        {
            string result;

            result = "";
            foreach (Decision decision in decisionList) result += decision.ReleaseAuthority + "<br />";
            return result;
        }
    }
}