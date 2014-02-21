/*
 * WLASCICIEL: mwionczyk
 * TABELE: WasteTransferCard
 * 
 * Strona wyświetlająca karty przekazania odpadów (KPO). Tylko do odczytu ponieważ KPO są wystawianie
 * przy okazji:
 * a) przekazania odpadów (zawsze)
 * b) przyjęcia (tylko gdy wystawiamy KPO za kontrahenta)
*/

using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class TransferCard : Page
    {
        private EVidentDataModel _database;

        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            CollectionListViewDataBind();
            MultiView.SetActiveView(CollectionView);
        }

        protected void IsCollectionDDLSelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsCollectionDDL.SelectedValue == "0") //Przyjęcie odpadu
            {
                MultiView.SetActiveView(CollectionView);
                CollectionListViewDataBind();
            }
            else //przekazanie odpadu
            {
                MultiView.SetActiveView(TransferView);
                TransferListViewDataBind();
            }
        }

        private void TransferListViewDataBind()
        {
            IOrderedQueryable<WasteTransferCard> transferCards = _database.WasteTransferCards.
                Include("WasteRecordCardElements").
                Include("WasteRecordCard.Department.Company").
                Include("WasteRecordCard.WasteCode").
                Include("Contractor").
                Include("TransportContractor").
                Where(w => w.IsCollection == false && w.WasteRecordCardElements.Any() && w.WasteRecordCard.Department.Company.Id == ApplicationUser.CurrentCompanyId).OrderBy(w => w.TransferCardNumber);
            TransferListView.DataSource = transferCards;
            TransferListView.DataBind();
        }

        private void CollectionListViewDataBind()
        {
            IOrderedQueryable<WasteTransferCard> transferCards = _database.WasteTransferCards.
                Include("WasteRecordCardElements").
                Include("WasteRecordCard.WasteCode").
                Include("Contractor").
                Include("TransportContractor").
                Where(w => w.IsCollection && w.WasteRecordCardElements.Any() && w.WasteRecordCard.Department.Company.Id == ApplicationUser.CurrentCompanyId).OrderByDescending(w => w.WasteRecordCard.Period.Id).OrderBy(
                    w => w.TransferCardNumber);
            CollectionListView.DataSource = transferCards;
            CollectionView.DataBind();
        }

        protected void CollectionListViewItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Literal transportWayLiteral = e.Item.FindControl("TransportWayLiteral") as Literal;
            if (transportWayLiteral == null) throw new NullReferenceException();
            Label wasteCodeNameLabel = e.Item.FindControl("WasteCodeNameLabel") as Label;
            if (wasteCodeNameLabel == null) throw new NullReferenceException();
            ListViewDataItem dataItem = e.Item as ListViewDataItem;
            if (dataItem == null) throw new NullReferenceException();
            WasteTransferCard transferCard = dataItem.DataItem.GetEntityAs<WasteTransferCard>();
            switch (transferCard.TransportKind)
            {
                case 0:
                    {
                        transportWayLiteral.Text = "Własny";
                        break;
                    }
                case 1:
                    {
                        transportWayLiteral.Text = "Przekazującego";
                        break;
                    }
                case 2:
                    {
                        transportWayLiteral.Text = "Firma transportowa <br/> " +
                                                   transferCard.TransportContractor.FullName;
                        break;
                    }
            }
            long cardElementId = transferCard.WasteRecordCardElements.First().Id;
            WasteCode wasteCode =
                _database.WasteRecordCardElements.Include("WasteRecordCard.WasteCode").
                    First(w => w.Id == cardElementId).WasteRecordCard.WasteCode;
            wasteCodeNameLabel.Text = wasteCode.Name;
            wasteCodeNameLabel.ToolTip = wasteCode.Description;
        }

        protected void TransferListViewItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Label transportWayLabel = e.Item.FindControl("TransportWayLabel") as Label;
            if (transportWayLabel == null) throw new NullReferenceException();
            Label wasteCodeNameLabel = e.Item.FindControl("WasteCodeNameLabel") as Label;
            if (wasteCodeNameLabel == null) throw new NullReferenceException();
            ListViewDataItem dataItem = e.Item as ListViewDataItem;
            if (dataItem == null) throw new NullReferenceException();
            WasteTransferCard transferCard = dataItem.DataItem.GetEntityAs<WasteTransferCard>();
            switch (transferCard.TransportKind)
            {
                case 0:
                    {
                        transportWayLabel.Text = "Własny";
                        break;
                    }
                case 1:
                    {
                        transportWayLabel.Text = "Przejmującego";
                        break;
                    }
                case 2:
                    {
                        transportWayLabel.Text = "Firma transportowa";
                        break;
                    }
            }
            WasteCode wasteCode = transferCard.WasteRecordCardElements.First().WasteRecordCard.WasteCode;
            wasteCodeNameLabel.Text = wasteCode.Name;
            wasteCodeNameLabel.ToolTip = wasteCode.Description;
        }

        protected void CollectionListViewItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "print")
            {
                Response.Redirect("~/TransferCardView.aspx?Id=" + e.CommandArgument);
            }
        }

        protected void TransferListViewItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "print")
            {
                Response.Redirect("~/TransferCardView.aspx?Id=" + e.CommandArgument);
            }
        }
    }
}