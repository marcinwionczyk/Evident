using System;
using System.Data;
using System.Linq;
using EVident.Code;

namespace EVident
{
    public partial class TransferCardView : System.Web.UI.Page
    {
        private EVidentDataModel _database;
        private long _transferCardId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            DpoNotRequired.Attributes.Add("onclick", "return false");
            DpoRequired.Attributes.Add("onclick", "return false");
            if (!long.TryParse(Request.QueryString["Id"], out _transferCardId)) return;
            WasteTransferCard transferCard = _database.WasteTransferCards.
                Include("Contractor").
                Include("TransportContractor").
                Include("WasteRecordCardElements").
                Include("WasteRecordCard.WasteCode").
                Include("WasteRecordCard.Period").
                Include("ProcessingMethod").First(w => w.Id == _transferCardId);
            TransferCardNumberL.Text = transferCard.TransferCardNumber;
            YearL.Text = transferCard.WasteRecordCard.Period.Name;
            Company company = _database.Companies.First(c => c.Id == ApplicationUser.CurrentCompanyId);
            if (transferCard.IsCollection)
            {
                WhoIsTransferingNameL.Text = transferCard.Contractor.FullName;
                WhoIsTransferringAddressL.Text = Common.GetAddress(transferCard.Contractor, true);
                WhoIsTransferringREGON_L.Text = transferCard.Contractor.Regon;
                WhoTakesWasteNameL.Text = company.FullName;
                WhoTakesWasteAddressL.Text = Common.GetAddress(company, true);
                WhoTakesWasteREGON_L.Text = company.Regon;
                switch (transferCard.TransportKind)
                {
                    case 0:
                        {
                            WhoIsTransportingNameL.Text = company.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(company, true);
                            WhoIsTransportingREGON_L.Text = company.Regon;
                            break;
                        }
                    case 1:
                        {
                            WhoIsTransportingNameL.Text = transferCard.Contractor.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(transferCard.Contractor, true);
                            WhoIsTransportingREGON_L.Text = transferCard.Contractor.Regon;
                            break;
                        }
                    case 2:
                        {
                            WhoIsTransportingNameL.Text = transferCard.TransportContractor.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(transferCard.TransportContractor, true);
                            WhoIsTransportingREGON_L.Text = transferCard.TransportContractor.Regon;
                            break;
                        }
                }
            }
            else
            {
                WhoIsTransferingNameL.Text = company.FullName;
                WhoIsTransferringAddressL.Text = Common.GetAddress(company, true);
                WhoIsTransferringREGON_L.Text = company.Regon;
                WhoTakesWasteNameL.Text = transferCard.Contractor.FullName;
                WhoTakesWasteAddressL.Text = Common.GetAddress(transferCard.Contractor, true);
                switch (transferCard.TransportKind)
                {
                    case 0:
                        {
                            WhoIsTransportingNameL.Text = company.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(company, true);
                            WhoIsTransportingREGON_L.Text = company.Regon;
                            break;
                        }
                    case 1:
                        {
                            WhoIsTransportingNameL.Text = transferCard.Contractor.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(transferCard.Contractor, true);
                            WhoIsTransportingREGON_L.Text = transferCard.Contractor.Regon;
                            break;
                        }
                    case 2:
                        {
                            WhoIsTransportingNameL.Text = transferCard.TransportContractor.FullName;
                            WhoIsTransportingAddressL.Text = Common.GetAddress(transferCard.TransportContractor, true);
                            WhoIsTransportingREGON_L.Text = transferCard.TransportContractor.Regon;
                            break;
                        }
                }
            }
            WasteDestinationAddressL.Text = transferCard.WasteDestination;
            if (transferCard.ProcessingMethod != null)
                WasteProcessingMethodL.Text = transferCard.ProcessingMethod.Name + " - " +
                                              transferCard.ProcessingMethod.Description;
            if (transferCard.DPOrequired)
            {
                DpoRequired.Checked = true;
                DpoNotRequired.Checked = false;
            }
            else
            {
                DpoRequired.Checked = false;
                DpoNotRequired.Checked = true;
            }
            
            WasteCodeNameL.Text = transferCard.WasteRecordCard.WasteCode.Name;
            WasteCodeDescriptionL.Text =
                transferCard.WasteRecordCard.WasteCode.Description;
            if (!transferCard.WasteRecordCardElements.Any()) return;
            DataTable repeaterDataSource = new DataTable();
            DataColumn dateColumn = new DataColumn("DateItem", typeof (DateTime));
            DataColumn transferMassColumn = new DataColumn("MassItem", typeof (double));
            DataColumn vehicleNumberColumn = new DataColumn("VehicleNumberItem", typeof (string));
            repeaterDataSource.Columns.Add(dateColumn);
            repeaterDataSource.Columns.Add(transferMassColumn);
            repeaterDataSource.Columns.Add(vehicleNumberColumn);
            foreach (WasteRecordCardElement cardElement in transferCard.WasteRecordCardElements)
            {
                DataRow row = repeaterDataSource.NewRow();
                row["DateItem"] = cardElement.Date;
                row["MassItem"] = transferCard.IsCollection ? cardElement.ReceivedMass : cardElement.TransferMass;
                row["VehicleNumberItem"] = transferCard.TransportVehicleNumber;
                repeaterDataSource.Rows.Add(row);
            }
            Repeater1.DataSource = repeaterDataSource;
            Repeater1.DataBind();
        }
    }
}