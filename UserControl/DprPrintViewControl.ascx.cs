using System;
using System.Linq;
using EVident.Code;
using System.Web.UI;
using System.Collections.Generic;

namespace EVident.UserControl
{
    public partial class DprPrintViewControl : System.Web.UI.UserControl
    {
        private static readonly string MASS_UNIT = "kg";
        private EVidentDataModel database;

        public DprPrintViewControl()
        {
            database = Common.GetNotCachedDataModel();
        }

        public string CustomLetter { get; set; }
        public string CustomTitle { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            DprDpo dprDpo;
            long dprDpoId;

            customLetterLiteral.Text = CustomLetter;
            customTitleLiteral.Text = CustomTitle;

            if (long.TryParse(Request["Id"], out dprDpoId))
            {
                dprDpo = database.DprDpoes.
                    Include("Contractor").
                    Include("Period").
                    Include("Department.Company").
                    First(d => d.Id == dprDpoId);
                FillUi(dprDpo);
            }
        }

        private void FillUi(DprDpo dprDpo)
        {
            yearLiteralA.Text = dprDpo.Period.DateFrom.Year + "";
            dprNumberLiteralA.Text = dprDpo.DprNumber;
            decisionNumberLiteralA.Text = GetDecisionNumber(dprDpo);
            transferorLiteralA.Text = dprDpo.Contractor.FullName;
            receiverLiteralA.Text = dprDpo.Department.Company.FullName;
            transferorAddressLiteralA.Text = Common.GetAddress(dprDpo.Contractor, true);
            receiverAddressLiteralA.Text = Common.GetAddress(dprDpo.Department.Company, true);
            transferorPhoneFaxLiteralA.Text = dprDpo.Contractor.Phone + "/" + dprDpo.Contractor.Fax;
            receiverPhoneFaxLiteralA.Text = dprDpo.Department.Company.Phone + "/" + dprDpo.Department.Company.Fax;
            transferorNipLiteralA.Text = dprDpo.Contractor.Nip;
            receiverNipLiteralA.Text = dprDpo.Department.Company.Nip;
            FillFirstTableData(dprDpo);
            FillSecondTableData(dprDpo);
        }

        private void FillFirstTableData(DprDpo dprDpo)
        {
            IEnumerable<DprDpoElement> elements;
            string text;
            int lp;

            elements = from e in database.DprDpoElements.
                           Include("WasteCode").
                           Include("ProcessingMethod")
                       where e.DprDpo.Id == dprDpo.Id &&
                       e.RecyclingKind.Kind == 1
                       select e;
            text = "";
            lp = 0;

            foreach (DprDpoElement element in elements)
            {
                text += "<tr>";
                text += "<td>" + (++lp) + "</td>";
                text += "<td>" + element.WasteCode.Name + "</td>";
                text += "<td>" + element.WasteCode.Description + "</td>";
                text += "<td>" + MASS_UNIT + "</td>";
                text += "<td>" + element.ReceivedMass + "</td>";
                text += "<td>" + element.ProcessingMethod.Name + "</td>";
                text += "</tr>";
            }
            firstTableLiteralA.Text = text;
        }

        private void FillSecondTableData(DprDpo dprDpo)
        {
            double _0Value, _1Value, _2Value, _3Value, _4Value, _6Value;
            double _01Value, _11Value, _21Value, _31Value, _41Value, _51Value, _61Value, _71Value;
            double _02Value, _12Value, _22Value, _32Value, _42Value, _52Value, _62Value, _72Value;

            _00LiteralA.Text = GetDoubleText(_0Value = database.GetDprDpo00Value(dprDpo, 1));
            _10LiteralA.Text = GetDoubleText(_1Value = database.GetDprDpo10Value(dprDpo, 1));
            _20LiteralA.Text = GetDoubleText(_2Value = database.GetDprDpo20Value(dprDpo, 1));
            _30LiteralA.Text = GetDoubleText(_3Value = database.GetDprDpo30Value(dprDpo, 1));
            _40LiteralA.Text = GetDoubleText(_4Value = database.GetDprDpo40Value(dprDpo, 1));
            _50LiteralA.Text = GetDoubleText(_3Value + _4Value);
            _60LiteralA.Text = GetDoubleText(_6Value = database.GetDprDpo60Value(dprDpo, 1));
            _70LiteralA.Text = GetDoubleText(_0Value + _1Value + _2Value + _3Value + _4Value + _6Value);
            _01LiteralA.Text = GetDoubleText(_01Value = _0Value = database.GetDprDpo01Value(dprDpo, 1));
            _11LiteralA.Text = GetDoubleText(_11Value = _1Value = database.GetDprDpo11Value(dprDpo, 1));
            _21LiteralA.Text = GetDoubleText(_21Value = _2Value = database.GetDprDpo21Value(dprDpo, 1));
            _31LiteralA.Text = GetDoubleText(_31Value = _3Value = database.GetDprDpo31Value(dprDpo, 1));
            _41LiteralA.Text = GetDoubleText(_41Value = _4Value = database.GetDprDpo41Value(dprDpo, 1));
            _51LiteralA.Text = GetDoubleText(_51Value = _3Value + _4Value);
            _61LiteralA.Text = GetDoubleText(_61Value = _6Value = database.GetDprDpo61Value(dprDpo, 1));
            _71LiteralA.Text = GetDoubleText(_71Value = _0Value + _1Value + _2Value + _3Value + _4Value + _6Value);
            _02LiteralA.Text = GetDoubleText(_02Value = _0Value = database.GetDprDpo02Value(dprDpo, 1));
            _12LiteralA.Text = GetDoubleText(_12Value = _1Value = database.GetDprDpo12Value(dprDpo, 1));
            _22LiteralA.Text = GetDoubleText(_22Value = _2Value = database.GetDprDpo22Value(dprDpo, 1));
            _32LiteralA.Text = GetDoubleText(_32Value = _3Value = database.GetDprDpo32Value(dprDpo, 1));
            _42LiteralA.Text = GetDoubleText(_42Value = _4Value = database.GetDprDpo42Value(dprDpo, 1));
            _52LiteralA.Text = GetDoubleText(_52Value = _3Value + _4Value);
            _62LiteralA.Text = GetDoubleText(_62Value = _6Value = database.GetDprDpo62Value(dprDpo, 1));
            _72LiteralA.Text = GetDoubleText(_72Value = _0Value + _1Value + _2Value + _3Value + _4Value + _6Value);
            _03LiteralA.Text = GetDoubleText(_01Value + _02Value);
            _13LiteralA.Text = GetDoubleText(_11Value + _12Value);
            _23LiteralA.Text = GetDoubleText(_21Value + _22Value);
            _33LiteralA.Text = GetDoubleText(_31Value + _32Value);
            _43LiteralA.Text = GetDoubleText(_41Value + _42Value);
            _53LiteralA.Text = GetDoubleText(_51Value + _52Value);
            _63LiteralA.Text = GetDoubleText(_61Value + _62Value);
            _73LiteralA.Text = GetDoubleText(_71Value + _72Value);
        }

        private string GetDoubleText(double input)
        {
            if (input == 0.0) return "---";
            return input + "";
        }

        private string GetDecisionNumber(DprDpo dprDpo)
        {
            IEnumerable<Decision> decisions;
            string result;

            // pobieramy te decyzje, które obowiązują w okresie rozliczeniowym dla DPR
            // korzystamy z własności nakładania się przedziałów
            // s2 < e1 && s1 < e2 -> przedziały nakładają się gdy wynik będzie true
            // przedziały to i1 = (s1, e1) oraz i2 = (s2, e2)
            // i1 -> decyzja, i2 -> okres rozliczeniowy

            decisions = from d in database.Decisions
                        where dprDpo.Period.DateFrom < d.ValidTo &&
                        dprDpo.Period.DateTo > d.ValidFrom &&
                        dprDpo.Department.Id == d.Department.Id
                        orderby d.ReleaseDate
                        select d;
            result = "";
            foreach (Decision decision in decisions) result += decision.Number + "<br />";
            return result;
        }
    }
}