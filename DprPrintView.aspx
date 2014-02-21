<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DprPrintView.aspx.cs" Inherits="EVident.DprPrintView" EnableEventValidation="false" %>

<%@ Register src="UserControl/DprPrintViewControl.ascx" tagname="DprPrintViewControl" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DPR</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="./JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="page" style="border: none;" runat="server">
        
        <uc1:DprPrintViewControl ID="DprPrintViewControlA" CustomLetter="A" 
            CustomTitle="przeznaczony dla przekazującego odpad do recyklingu" runat="server" />
        <p style="page-break-after: always;">&nbsp;</p>
                <uc1:DprPrintViewControl ID="DprPrintViewControlB" CustomLetter="B" 
            CustomTitle="przeznaczony dla prowadzącego recykling" runat="server" />
        <p style="page-break-after: always;">&nbsp;</p>
                <uc1:DprPrintViewControl ID="DprPrintViewControlC" CustomLetter="C" 
            CustomTitle="przeznaczony dla wojewódzkiego inspektora ochrony środowiska" runat="server" />
        <br />
        <asp:Button ID="printButton" OnClientClick="javascript: return PrintPage(this);" CssClass="smallButton" runat="server" Text="Drukuj" />
        <asp:Button ID="exportToPdfButton" CssClass="mediumButton" runat="server" 
                Text="Eksportuj do PDF" onclick="ExportToPdfButtonClick" />
    </div>
    </form>
</body>
</html>
