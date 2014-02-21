using System;
using System.IO;
using System.Web;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.UI;
using iTextSharp.text;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Collections.Specialized;

namespace EVident.Code
{
    public static class Common
    {
        public const string CANT_DELETE_ROW =
            "Nie można usunąć wybranego wiersza, ponieważ jest on powiązany z innymi danymi w systemie.";
        public const string CANT_INSERT_ROW =
            "Nie można wstawić wybranego wiersza, ponieważ te dane istnieją już w systemie";
        public const string CANT_UPDATE_ROW =
            "Nie można zmienić wartości w wybranym wierszu, ponieważ istnieją już w systemie dane o tej samej wartości";
        private static readonly string PDF_REPORT_CSS =
            "table { width: 100%; border-collapse: collapse; }" +
            "td { padding: 5px; font-family: Tahoma; font-size: 10px; border-width: 1px; }" +
            "th { padding: 5px; font-family: Tahoma; font-size: 10px; border-width: 1px; text-align: center; background-color: rgb(240, 240, 240); }";
        private static EVidentDataModel _dataModel;

        public static EVidentDataModel GetDataModel()
        {
            return _dataModel ?? (_dataModel = new EVidentDataModel());
        }

        public static EVidentDataModel GetNotCachedDataModel()
        {
            return new EVidentDataModel();
        }

        public static void RegisterITextPolishFonts()
        {
            FontFactory.Register("./tahoma.ttf", "Tahoma");
            FontFactory.Register("./tahomabd.ttf", "TahomaPlBold");
        }

        public static void ExportToPdf(Control controlToRender, HttpResponse response, string fileName)
        {
            HtmlToPdfExporter exporter;
            StringWriter stringWriter;
            HtmlTextWriter htmlWriter;
            string html;

            stringWriter = new StringWriter();
            htmlWriter = new HtmlTextWriter(stringWriter);
            controlToRender.RenderControl(htmlWriter);
            html = stringWriter + "";
            response.ContentType = "application/pdf";
            response.AddHeader("content-disposition", string.Format("attachment;filename={0}", fileName));
            response.Cache.SetCacheability(HttpCacheability.NoCache);
            exporter = new HtmlToPdfExporter();
            exporter.Export(html, response.OutputStream);
        }

        public static Stream GetPdfReportCssStream()
        {
            return new MemoryStream(Encoding.UTF8.GetBytes(PDF_REPORT_CSS));
        }

        public static HtmlTableRow GetHtmlTableRow(params object[] data)
        {
            HtmlTableRow row;
            
            row = new HtmlTableRow();
            foreach (object o in data) row.Cells.Add(GetHtmlTableCell(o));
            return row;
        }

        public static HtmlTableCell GetHtmlTableCell(object o)
        {
            HtmlTableCell cell;

            cell = new HtmlTableCell();
            cell.InnerText = o + "";
            return cell;
        }

        public static string GetMassString(object mass, bool zeroAsNothing)
        {
            return GetMassString(mass, zeroAsNothing, " ");
        }

        public static string GetMassString(object mass, bool zeroAsNothing, string nothingSequence)
        {
            double m;

            m = Convert.ToDouble(mass);
            if (zeroAsNothing && m == 0) return nothingSequence;
            return string.Format("{0:f4}", m);
        }

        public static void SetToNull(string key, IOrderedDictionary newValues, 
            IOrderedDictionary oldValues, object placeHolder)
        {
            if (oldValues[key] == null) oldValues[key] = placeHolder;
            newValues[key] = null;
        }

        public static byte[] Md5(string input)
        {
            MD5 md5 = MD5.Create();
            return md5.ComputeHash(Encoding.UTF8.GetBytes(input));
        }

        internal static Department GetCurrentDepartment()
        {
            long? departmentId = ApplicationUser.CurrentDepartmentId;
            if (departmentId == null)
                throw new NoNullAllowedException("ApplicationUser.CurrentDepartmentId returned null value");
            return GetDataModel().Departments.First(d => d.Id == departmentId);
        }

        internal static Company GetCurrentCompany()
        {
            long? companyId = ApplicationUser.CurrentCompanyId;
            if (companyId == null)
                throw new NoNullAllowedException("ApplicationUser.CurrentCompanyId returned null value");
            return GetDataModel().Companies.First(c => c.Id == companyId);
        }

        internal static string GetAddress(Contractor c, bool _break = false)
        {
            if (c == null) return "";
            return c.Street + " " + c.BuildingNumber + (string.IsNullOrEmpty(c.FlatNumber) ? "" : "/" + c.FlatNumber) +
                   ", " +
                   (_break ? "<br/> " : "") + c.PostCode + " " + c.Place;
        }

        private static string GetAddress(Department d, bool _break = false)
        {
            if (d == null) return "";
            return d.Street + " " + d.BuildingNumber + (string.IsNullOrEmpty(d.FlatNumber) ? "" : "/" + d.FlatNumber) +
                   ", " +
                   (_break ? "<br/> " : "") + d.PostCode + " " + d.Place;
        }

        internal static string GetAddress(Company c, bool _break = false)
        {
            if (c == null) return "";
            return c.Street + " " + c.BuildingNumber + (string.IsNullOrEmpty(c.FlatNumber) ? "" : "/" + c.FlatNumber) +
                   ", " +
                   (_break ? " <br/> " : "") + c.PostCode + " " + c.Place;
        }

        internal static string GetRegisterNumber(Contractor c)
        {
            if (c == null) return "";
            if (string.IsNullOrEmpty(c.RegisterNumber.Trim())) return "";
            string toreturn = "E" + c.RegisterNumber +
                              (c.IsSellingElectronics ? "W" : "") +
                              (c.IsRecoveringElectronics ? "S" : "") +
                              (c.IsCollectingElectronics ? "Z" : "") +
                              (c.IsProcessingElectronics ? "P" : "") +
                              (c.IsRecyclingElectronics ? "R" : "") +
                              (c.IsSomeElseElectronics ? "X" : "");
            if (c.IsProcessingBattery || c.IsSellingBattery)
                toreturn += "B" + (c.IsSellingBattery ? "W" : "") +
                            (c.IsProcessingBattery ? "P" : "");
            return toreturn;
        }

        internal static string GetRegisterNumber(Company c)
        {
            if (c == null) return "";
            if (string.IsNullOrEmpty(c.RegisterNumber.Trim())) return "";
            string toreturn = "E" + c.RegisterNumber +
                              (c.IsSellingElectronics ? "W" : "") +
                              (c.IsRecoveringElectronics ? "S" : "") +
                              (c.IsCollectingElectronics ? "Z" : "") +
                              (c.IsProcessingElectronics ? "P" : "") +
                              (c.IsRecyclingElectronics ? "R" : "") +
                              (c.IsSomeElseElectronics ? "X" : "");
            if (c.IsProcessingBattery || c.IsSellingBattery)
                toreturn += "B" + (c.IsSellingBattery ? "W" : "") +
                            (c.IsProcessingBattery ? "P" : "");
            return toreturn;
        }

        public static bool ValidateNip(string nip)
        {
            string strippedNip = nip.Replace("-", "").Trim();
            if (strippedNip.Length != 10) return false;
            try { ulong.Parse(strippedNip); } catch { return false; }
            int[] weights = new int[] {6, 5, 7, 2, 3, 4, 5, 6, 7};
            int sum = 0;
            for (int i = 0; i < weights.Length; i++)
                sum += int.Parse(strippedNip.Substring(i, 1))*weights[i];
            return (sum%11) == int.Parse(strippedNip.Substring(9, 1));
        }

        public static bool ValidateREGON(string regon)
        {
            string strippedRegon = regon.Replace("-", "").Trim();
            try { ulong.Parse(strippedRegon); } catch { return false; }
            switch (strippedRegon.Length)
            {
                case 9:
                    {
                        int[] weights = {8, 9, 2, 3, 4, 5, 6, 7};
                        int checkDigit = int.Parse(strippedRegon.Substring(8, 1));
                        int sum = 0;
                        for (int i = 0; i < weights.Length; i++)
                            sum += int.Parse(strippedRegon.Substring(i, 1)) * weights[i];
                        if (sum % 11 == checkDigit) return true;
                        if ((sum % 11 == 10) && checkDigit == 0) return true;
                        break;
                    }
                case 14:
                    {
                        int[] weights = {2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8 };
                        int checkDigit = int.Parse(strippedRegon.Substring(13, 1));
                        int sum = 0;
                        for (int i = 0; i < weights.Length; i++)
                            sum += int.Parse(strippedRegon.Substring(i, 1)) * weights[i];
                        if (sum % 11 == checkDigit) return true;
                        break;
                    }
            }
            return false;
        }
    }
}