using System;
using System.IO;
using System.Web;
using System.Text;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;


namespace EVident.Code
{
    public class HtmlToPdfExporter
    {
        public void Export(string html, Stream output)
        {
            Document pdf;
            PdfWriter pdfWriter;
            Stream cssStream;
            MemoryStream stringStream;

            Common.RegisterITextPolishFonts();    
            pdf = new Document(PageSize.A4.Rotate());
            pdfWriter = PdfWriter.GetInstance(pdf, output);
            pdf.Open();

            try
            {
                cssStream = Common.GetPdfReportCssStream();
                stringStream = new MemoryStream(Encoding.UTF8.GetBytes(html));
               // XMLWorkerHelper.GetInstance().ParseXHtml(
               //     pdfWriter, pdf, stringStream, cssStream, Encoding.UTF8);
            }
            finally
            {
                pdf.Close();
            }
        }
    }
}