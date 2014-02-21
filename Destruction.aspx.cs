/* 
 * WLASCICIEL: mwionczyk
 * TABELE: WasteRecordCard, WasteRecordCardElement
 * 
 * Strona realizująca unieszkodliwienie odpadu. Strona obsługuje dwie tabele, na górze WasteRecordCard, a pod nią 
 * WasteCardElement z zawartością zależną od wyboru wiersza w WasteRecordCard.
 * 
 * Wartości niezbędne przy unieszkodliwieniu:
 * 
 * 	-7. UNIESZKODLIWIANIE.
	*****************************************************************************************
	* - masa zagospodarowanych odpadów                                                      *
	* - sucha masa zagospodarowanych odpadów                                                *
	* - nr partii                                                                           *
	* - identyfikator metody unieszkodliwiania                                              *
	* - identyfikator instalacji (jeżeli unieszkodliwianie w instalacji)                    *
	*****************************************************************************************
*/

using System;
using System.Linq;
using System.Web.UI.WebControls;
using EVident.Code;

namespace EVident
{
    public partial class Destruction : System.Web.UI.Page
    {
        private long _wasteRecordCardId;
        private EVidentDataModel _database;
        private const int Kind = -7;
        private bool _isDryMassRequired;
        protected void Page_Load(object sender, EventArgs e)
        {
            _database = Common.GetNotCachedDataModel();
            if (!long.TryParse(Request.QueryString["WasteRecordCardId"], out _wasteRecordCardId)) return;
            WasteCode wastecode = _database.WasteRecordCards.
                Include("WasteCode").First(w => w.Id == _wasteRecordCardId).
                WasteCode;
            WasteCodeLabel.Text = wastecode.Name;
            _isDryMassRequired = wastecode.RequireDryMass;
            if (Page.IsPostBack) return;
            DestructionListViewDataBind();
        }
        private void DestructionListViewDataBind()
        {
            IQueryable<WasteRecordCardElement> cardElements = _database.WasteRecordCardElements.
                Include("Installation").Include("ProcessingMethod").Include("WasteRecordCard").Where(
                    w => w.WasteRecordCard.Id == _wasteRecordCardId && w.Kind == Kind).OrderByDescending(w => w.PartNumber);
            DestructionListView.DataSource = cardElements;
            DestructionListView.DataBind();
        }
        protected void DestructionListViewItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            DestructionListView.EditIndex = -1;
            DestructionListViewDataBind();
        }

        protected void DestructionListViewItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            DataKey key = DestructionListView.DataKeys[e.ItemIndex];
            if (key == null) throw new NullReferenceException();
            long keyId = long.Parse(key.Value.ToString());
            WasteRecordCardElement cardElement = _database.WasteRecordCardElements.FirstOrDefault(w => w.Id == keyId);
            if (cardElement == null) return;
            _database.DeleteObject(cardElement);
            _database.SaveChanges();
            DestructionListViewDataBind();
        }

        protected void DestructionListViewItemEditing(object sender, ListViewEditEventArgs e)
        {
            DataKey key = DestructionListView.DataKeys[e.NewEditIndex];
            if (key==null) throw new NullReferenceException();
            DestructionListView.EditIndex = e.NewEditIndex;
            DestructionListViewDataBind();
            TextBox manageDryMassTB = DestructionListView.EditItem.FindControl("ManageDryMassTB") as TextBox;
            if (manageDryMassTB == null) throw new NullReferenceException();
            RequiredFieldValidator fieldValidator =
                DestructionListView.EditItem.FindControl("DryMassRequiredValidator") as RequiredFieldValidator;
            if (fieldValidator == null) throw new NullReferenceException();
            manageDryMassTB.Enabled = _isDryMassRequired;
            fieldValidator.Enabled = _isDryMassRequired;
            if (_isDryMassRequired == false) manageDryMassTB.Text = "";
        }

        protected void DestructionListViewItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox dateTB = e.Item.FindControl("DateTB") as TextBox;
            if (dateTB == null) throw new NullReferenceException();
            TextBox manageMassTB = e.Item.FindControl("ManageMassTB") as TextBox;
            if (manageMassTB == null) throw new NullReferenceException();
            TextBox manageDryMassTB = e.Item.FindControl("ManageDryMassTB") as TextBox;
            if (manageDryMassTB == null) throw new NullReferenceException();
            DropDownList destructionMethodDDL = e.Item.FindControl("DestructionMethodDDL") as DropDownList;
            if (destructionMethodDDL == null) throw new NullReferenceException();
            DropDownList installationsDDL = e.Item.FindControl("InstallationsDDL") as DropDownList;
            if (installationsDDL == null) throw new NullReferenceException();
            TextBox partNumber = e.Item.FindControl("PartNumberTB") as TextBox;
            if (partNumber == null) throw new NullReferenceException();
            long processingMethodId = long.Parse(destructionMethodDDL.SelectedValue);
            long installationId = long.Parse(installationsDDL.SelectedValue);
            WasteRecordCardElement cardElement = new WasteRecordCardElement
                                                     {
                                                         Date = DateTime.Parse(dateTB.Text),
                                                         ManageMass = double.Parse(manageMassTB.Text),
                                                         ManageDryMass =
                                                             _isDryMassRequired ? double.Parse(manageDryMassTB.Text) : 0,
                                                         ProcessingMethod = _database.ProcessingMethods.First(
                                                             p => p.Id == processingMethodId),
                                                         Installation =
                                                             _database.Installations.FirstOrDefault(p => p.Id == installationId),
                                                         Kind = Kind,
                                                         WasteRecordCard = _database.WasteRecordCards.First(
                                                             w => w.Id == _wasteRecordCardId),
                                                         PartNumber = int.Parse(partNumber.Text)
                                                     };
            _database.AddToWasteRecordCardElements(cardElement);
            _database.SaveChanges();
            DestructionListViewDataBind();
        }

        protected void DestructionListViewItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DataKey key = DestructionListView.DataKeys[e.ItemIndex];
            if (key == null) throw new NullReferenceException();
            long cardElementId = long.Parse(key.Value.ToString());
            TextBox dateTB = DestructionListView.EditItem.FindControl("DateTB") as TextBox;
            if (dateTB == null) throw new NullReferenceException();
            TextBox manageMassTB = DestructionListView.EditItem.FindControl("ManageMassTB") as TextBox;
            if (manageMassTB == null) throw new NullReferenceException();
            TextBox manageDryMassTB = DestructionListView.EditItem.FindControl("ManageDryMassTB") as TextBox;
            if (manageDryMassTB == null) throw new NullReferenceException();
            DropDownList destructionMethodDDL = DestructionListView.EditItem.FindControl("DestructionMethodDDL") as DropDownList;
            if (destructionMethodDDL == null) throw new NullReferenceException();
            DropDownList installationsDDL = DestructionListView.EditItem.FindControl("InstallationsDDL") as DropDownList;
            if (installationsDDL == null) throw new NullReferenceException();
            TextBox partNumber = DestructionListView.EditItem.FindControl("PartNumberTB") as TextBox;
            if (partNumber == null) throw new NullReferenceException();
            long processingMethodId = long.Parse(destructionMethodDDL.SelectedValue);
            long installationId = long.Parse(installationsDDL.SelectedValue);
            WasteRecordCardElement cardElement = _database.WasteRecordCardElements.First(w => w.Id == cardElementId);
            cardElement.Date = DateTime.Parse(dateTB.Text);
            cardElement.ManageMass = double.Parse(manageMassTB.Text);
            cardElement.ManageDryMass = _isDryMassRequired ? double.Parse(manageDryMassTB.Text) : 0;
            cardElement.ProcessingMethod = _database.ProcessingMethods.First(
                p => p.Id == processingMethodId);
            //cardElement.Installation = _database.Installations.First(p => p.Id == installationId);
            cardElement.ReceivedCardNumber = partNumber.Text;
            _database.SaveChanges();
            DestructionListView.EditIndex = -1;
            DestructionListViewDataBind();
        }

        protected void DestructionListViewItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Label manageDryMassLabel = e.Item.FindControl("ManageDryMassLabel") as Label;
            if (manageDryMassLabel != null)
                if (!_isDryMassRequired) manageDryMassLabel.Text = "sucha masa nie jest wymagana";
        }

        protected void DestructionListViewDataBound(object sender, EventArgs e)
        {
            TextBox dateTB = DestructionListView.InsertItem.FindControl("DateTB") as TextBox;
            if (dateTB != null) dateTB.Text = DateTime.Now.ToShortDateString();
            TextBox manageDryMassTB = DestructionListView.InsertItem.FindControl("ManageDryMassTB") as TextBox;
            if (manageDryMassTB == null) throw new NullReferenceException();
            RequiredFieldValidator fieldValidator =
                DestructionListView.InsertItem.FindControl("DryMassRequiredValidator") as RequiredFieldValidator;
            if(fieldValidator == null) throw new NullReferenceException();
            manageDryMassTB.Enabled = _isDryMassRequired;
            fieldValidator.Enabled = _isDryMassRequired;
            TextBox partNumberTB = DestructionListView.InsertItem.FindControl("PartNumberTB") as TextBox;
            if (partNumberTB == null) throw new NullReferenceException();
            // numer partii niech będzie tylko jako numer. Jeżeli użytkownik oprócz liczb wstawiałby 
            // jeszcze jakieś litery, byłoby z tym za dużo zabawy
            int? nextPartNumber = _database.GetNextPartNumber(_wasteRecordCardId);
            partNumberTB.Text = nextPartNumber + "";
        }
    }
}