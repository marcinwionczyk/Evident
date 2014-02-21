<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnnualReportPrintView.aspx.cs" Inherits="EVident.AnnualReportPrintView" EnableEventValidation="false" %>

<%@ Register src="UserControl/AnnualReportSection1TableA.ascx" tagname="AnnualReportSection1TableA" tagprefix="uc1" %>
<%@ Reference Control="UserControl/AnnualReportSection1TableB.ascx" %>
<%@ Register src="UserControl/AnnualReportSection2Table.ascx" tagname="AnnualReportSection2Table" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection4Table.ascx" tagname="AnnualReportSection4Table" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection5TableA.ascx" tagname="AnnualReportSection5TableA" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection5TableB.ascx" tagname="AnnualReportSection5TableB" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection5TableC.ascx" tagname="AnnualReportSection5TableC" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection6TableA.ascx" tagname="AnnualReportSection6TableA" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection6TableB.ascx" tagname="AnnualReportSection6TableB" tagprefix="uc1" %>
<%@ Register src="UserControl/AnnualReportSection7Table.ascx" tagname="AnnualReportSection7Table" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Zestawienie roczne</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="./JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="page" style="border: none;" runat="server">
        <asp:Label runat="server">ZBIORCZE ZESTAWIENIE DANYCH O RODZAJACH I ILOŚCIACH ODPADÓW, O SPOSOBACH GOSPODAROWANIA NIMI ORAZ O INSTALACJACH I
            URZĄDZENIACH SŁUŻĄCYCH DO ODZYSKU LUB UNIESZKODLIWIANIA ODPADÓW</asp:Label><br /><br />
        <div id="section1Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 1. Dane o posiadaczu odpadów</asp:Label><br /><br />
            <div id="section1TableADiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela A. Dane o posiadaczu odpadów</asp:Label><br />
                <uc1:AnnualReportSection1TableA ID="annualReportSection1TableA" runat="server" /><br />
            </div>
            <div id="section1TableBDiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela B. Dane o miejscu prowadzenia działalności</asp:Label><br />
                <asp:PlaceHolder ID="section1TableBPlaceHolder" runat="server" /><br />
            </div>
        </div>
        <div id="section2Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 2. Zbiorcze zestawienie danych o rodzajach i ilościach wytworzonych odpadów</asp:Label><br /><br />
            <uc1:AnnualReportSection2Table ID="annualReportSection2Table" runat="server" /><br />
        </div>
        <div id="section4Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 4. Zbiorcze zestawienie danych o rodzajach i ilościach zebranych odpadów</asp:Label><br /><br />
            <uc1:AnnualReportSection4Table ID="annualReportSection4Table" runat="server" /><br />
        </div>
        <div id="section5Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 5. Zbiorcze zestawienie danych o rodzajach i ilościach odpadów poddanych odzyskowi</asp:Label><br /><br />
            <div id="section5TableADiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela A. Zbiorcze zestawienie danych o rodzajach i ilościach odpadów poddanych odzyskowi w instalacjach lub urządzeniach</asp:Label><br />
                <uc1:AnnualReportSection5TableA ID="annualReportSection5TableA" runat="server" /><br />
            </div>
            <div id="section5TableBDiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela B. Zbiorcze zestawienie danych o rodzajach i ilościach odpadów poddanych odzyskowi poza instalacjami i urządzeniami</asp:Label><br />
                <uc1:AnnualReportSection5TableB ID="annualReportSection5TableB" runat="server" /><br />
            </div>
            <div id="section5TableCDiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela C. Zbiorcze zestawienie danych o rodzajach i ilościach odpadów przekazanych w celu ich wykorzystania osobom fizycznym lub jednostkom organizacyjnym, niebędącym przedsiębiorcami, na ich własne potrzeby</asp:Label><br />
                <uc1:AnnualReportSection5TableC ID="annualReportSection5TableC" runat="server" /><br />
            </div>
        </div>
        <div id="section6Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 6. Zbiorcze zestawienie danych o rodzajach i ilościach unieszkodliwionych odpadów</asp:Label><br /><br />
            <div id="section6TableADiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela A. Zbiorcze zestawienie danych o rodzajach i ilościach unieszkodliwionych odpadów w instalacjach lub urządzeniach</asp:Label><br />
                <uc1:AnnualReportSection6TableA ID="annualReportSection6TableA" runat="server" /><br />
            </div>
            <div id="section6TableBDiv" runat="server">
                <asp:Label runat="server" CssClass="reportSectionTableHeader">Tabela B. Zbiorcze zestawienie danych o rodzajach i ilościach unieszkodliwionych odpadów poza instalacjami i urządzeniami</asp:Label><br />
                <uc1:AnnualReportSection6TableB ID="annualReportSection6TableB" runat="server" /><br />
            </div>
        </div>
        <div id="section7Div" runat="server">
            <asp:Label runat="server" CssClass="reportSectionHeader">Dział 7. Zbiorcze zestawienie danych o instalacjach i urządzeniach służących do odzysku lub unieszkodliwiania odpadów, z wyłączeniem składowisk odpadów, obiektów unieszkodliwiania odpadów wydobywczych oraz spalarni i współspalarni odpadów</asp:Label><br /><br />
            <uc1:AnnualReportSection7Table ID="annualReportSection7Table" runat="server" /><br />
        </div>
        <asp:Button ID="printButton" OnClientClick="javascript: return PrintPage(this);" CssClass="smallButton" runat="server" Text="Drukuj" />&nbsp;
        <asp:Button ID="exportToPdfButton" CssClass="mediumButton" runat="server" 
            Text="Eksportuj do PDF" onclick="ExportToPdfButtonClick" />
    </div>
    </form>
</body>
</html>
