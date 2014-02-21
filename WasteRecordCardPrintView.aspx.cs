using System;
using System.IO;
using System.Web;
using System.Linq;
using EVident.Code;
using System.Web.UI;
using System.Data.Common;
using System.Collections.Generic;

namespace EVident
{
    public partial class WasteRecordCardPrintView : System.Web.UI.Page
    {
        EVidentDataModel database;

        protected void Page_Load(object sender, EventArgs e)
        {
            WasteRecordCard wasteRecordCard;
            long wasteRecordCardId;

            if (long.TryParse(Request["Id"], out wasteRecordCardId))
            {
                database = Common.GetNotCachedDataModel();
                wasteRecordCard = database.WasteRecordCards.
                    Include("WasteCode").
                    Include("Period").
                    Include("Department.Company.Commune.District.Province").
                    Include("Department.Commune.District.Province").
                    First(wrc => wrc.Id == wasteRecordCardId);
                FillUi(wasteRecordCard);
            }
            else Response.Redirect("./Default.aspx", true);
        }

        private void FillUi(WasteRecordCard wasteRecordCard)
        {
            List<Decision> currentDecisionList;

            cardNumberLiteral.Text = wasteRecordCard.Number;
            yearLiteral.Text = wasteRecordCard.Period.DateFrom.Year + "";
            wasteCodeNameLiteral.Text = wasteRecordCard.WasteCode.Name;
            wasteCodeDescriptionLiteral.Text = wasteRecordCard.WasteCode.Description;
            pcbLiteral.Text = "---";
            ownerNameLiteral.Text = wasteRecordCard.Department.Company.FullName;
            ownerProvinceLiteral.Text = wasteRecordCard.Department.Company.Commune.District.Province.Name;
            ownerCommuneLiteral.Text = wasteRecordCard.Department.Company.Commune.Name;
            ownerPlaceLiteral.Text = wasteRecordCard.Department.Company.Place;
            ownerPhoneLiteral.Text = wasteRecordCard.Department.Company.BusinessPhone;
            ownerFaxLiteral.Text = wasteRecordCard.Department.Company.BusinessFax;
            ownerStreetLiteral.Text = wasteRecordCard.Department.Company.Street;
            ownerHomeNumberLiteral.Text = wasteRecordCard.Department.Company.BuildingNumber;
            ownerFlatNumberLiteral.Text = wasteRecordCard.Department.Company.FlatNumber;
            ownerPostCodeLiteral.Text = wasteRecordCard.Department.Company.PostCode;
            departmentProvinceLiteral.Text = wasteRecordCard.Department.Commune.District.Province.Name;
            departmentCommuneLiteral.Text = wasteRecordCard.Department.Commune.Name;
            departmentPlaceLiteral.Text = wasteRecordCard.Department.Place;
            departmentPhoneLiteral.Text = wasteRecordCard.Department.Phone;
            departmentFaxLiteral.Text = wasteRecordCard.Department.Fax;
            departmentStreetLiteral.Text = wasteRecordCard.Department.Street;
            departmentHomeNumberLiteral.Text = wasteRecordCard.Department.BuildingNumber;
            departmentFlatNumberLiteral.Text = wasteRecordCard.Department.FlatNumber;
            departmentPostCodeLiteral.Text = wasteRecordCard.Department.PostCode;
            currentDecisionList = database.GetCurrentDecisionList(wasteRecordCard.Department.Id, wasteRecordCard.Period);
            if (database.GetCreationDecisionList(currentDecisionList).Count > 0) creationSpan.InnerText = "[X]";
            if (database.GetCollectionDecisionList(currentDecisionList).Count > 0) collectionSpan.InnerText = "[X]";
            if (database.GetRecyclingDecisionList(currentDecisionList).Count > 0) recyclingSpan.InnerText = "[X]";
            if (database.GetDestructionDecisionList(currentDecisionList).Count > 0) destructionSpan.InnerText = "[X]";
            FillData(wasteRecordCard);
        }

        private void FillData(WasteRecordCard wasteRecordCard)
        {
            DbDataReader reader;

            using (reader = database.ExecuteReader(string.Format(
                "SELECT wrce.Date, wrce.CreatedMass, 0 AS CommunalMass, wrce.ReceivedMass, " +
                "wrce.ReceivedCardNumber, wrce.ManageMass, CASE WHEN wrce.Kind = 6 THEN pm.Name ELSE NULL END AS RecyclingMethod, " +
                "CASE WHEN wrce.Kind = -7 THEN pm.Name ELSE NULL END AS DestructionMethod, wrce.TransferMass, wtr.TransferCardNumber " +
                "FROM WasteRecordCardElement wrce " +
                "LEFT JOIN WasteTransferCard wtr ON wtr.Id = wrce.WasteTransferCardId " +
                "LEFT JOIN ProcessingMethod pm ON pm.Id = wrce.ManageProcessingMethodId " +
                "WHERE wrce.WasteRecordCardId = {0} " +
                "ORDER BY wrce.Date DESC", wasteRecordCard.Id)))
            {
                while (reader.Read())
                    table.Rows.Add(Common.GetHtmlTableRow(Convert.ToDateTime(reader["Date"]).ToShortDateString(),
                        Common.GetMassString(reader["CreatedMass"], true, ""), Common.GetMassString(reader["CommunalMass"], true, ""),
                        Common.GetMassString(reader["ReceivedMass"], true, ""), reader["ReceivedCardNumber"],
                        Common.GetMassString(reader["ManageMass"], true, ""), reader["RecyclingMethod"],
                        reader["DestructionMethod"], Common.GetMassString(reader["TransferMass"], true, ""),
                        reader["TransferCardNumber"], ""));
            }
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