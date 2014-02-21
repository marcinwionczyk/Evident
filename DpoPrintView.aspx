<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DpoPrintView.aspx.cs" Inherits="EVident.DpoPrintView" EnableEventValidation="false" %>

<%@ Register src="UserControl/DpoPrintViewControl.ascx" tagname="DpoPrintViewControl" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DPO</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="./JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="page" style="border: none;" runat="server">
        
        <uc1:DpoPrintViewControl ID="DpoPrintViewControlA" runat="server" 
            CustomLetter="A" CustomTitle="przeznaczony dla przekazującego odpad do odzysku" />
        <p style="page-break-after: always;">&nbsp;</p>
        <uc1:DpoPrintViewControl ID="DpoPrintViewControlB" runat="server" 
            CustomLetter="B" CustomTitle="przeznaczony dla prowadzącego odzysk" />
        <p style="page-break-after: always;">&nbsp;</p>
        <uc1:DpoPrintViewControl ID="DpoPrintViewControlC" runat="server" 
            CustomLetter="C" CustomTitle="przeznaczony dla wojewódzkiego inspektora ochrony środowiska" />
        <br />
        <asp:Button ID="printButton" OnClientClick="javascript: return PrintPage(this);" CssClass="smallButton" runat="server" Text="Drukuj" />&nbsp;
        <asp:Button ID="exportToPdfButton" CssClass="mediumButton" runat="server" 
                Text="Eksportuj do PDF" onclick="ExportToPdfButtonClick" />
    </div>
    </form>
</body>
</html>
