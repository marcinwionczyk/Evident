<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WasteRecordCardPrintView.aspx.cs" Inherits="EVident.WasteRecordCardPrintView" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Karta ewidencji odpadu</title>
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="./JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="page" style="border: none;" runat="server">
            <table class="dataTable" border="1">
                <tr>
                    <th colspan="3">KARTA EWIDENCJI ODPADU</th>
                    <td>Nr karty<br /><asp:Literal ID="cardNumberLiteral" runat="server" /></td>
                    <td>Rok kalendarzowy<br /><asp:Literal ID="yearLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="5"><b>Kod odpadu</b> <asp:Literal ID="wasteCodeNameLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="5"><b>Rodzaj odpadu</b> <asp:Literal ID="wasteCodeDescriptionLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="5"><b>Procentowa zawartość PCB w odpadzie</b> <asp:Literal ID="pcbLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="5"><b>Posiadacz odpadów</b> <asp:Literal ID="ownerNameLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <th colspan="5">Adres posiadacza odpadów</th>
                </tr>
                <tr>
                    <td>Województwo<br /><asp:Literal ID="ownerProvinceLiteral" runat="server" /></td>
                    <td>Gmina<br /><asp:Literal ID="ownerCommuneLiteral" runat="server" /></td>
                    <td>Miejscowość<br /><asp:Literal ID="ownerPlaceLiteral" runat="server" /></td>
                    <td>Telefon służbowy<br /><asp:Literal ID="ownerPhoneLiteral" runat="server" /></td>
                    <td>Faks służbowy<br /><asp:Literal ID="ownerFaxLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="2">Ulica<br /><asp:Literal ID="ownerStreetLiteral" runat="server" /></td>
                    <td>Nr domu<br /><asp:Literal ID="ownerHomeNumberLiteral" runat="server" /></td>
                    <td>Nr lokalu<br /><asp:Literal ID="ownerFlatNumberLiteral" runat="server" /></td>
                    <td>Kod pocztowy<br /><asp:Literal ID="ownerPostCodeLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <th colspan="5">Miejsce prowadzenia działalności</th>
                </tr>
                <tr>
                    <td>Województwo<br /><asp:Literal ID="departmentProvinceLiteral" runat="server" /></td>
                    <td>Gmina<br /><asp:Literal ID="departmentCommuneLiteral" runat="server" /></td>
                    <td>Miejscowość<br /><asp:Literal ID="departmentPlaceLiteral" runat="server" /></td>
                    <td>Telefon służbowy<br /><asp:Literal ID="departmentPhoneLiteral" runat="server" /></td>
                    <td>Faks służbowy<br /><asp:Literal ID="departmentFaxLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="2">Ulica<br /><asp:Literal ID="departmentStreetLiteral" runat="server" /></td>
                    <td>Nr domu<br /><asp:Literal ID="departmentHomeNumberLiteral" runat="server" /></td>
                    <td>Nr lokalu<br /><asp:Literal ID="departmentFlatNumberLiteral" runat="server" /></td>
                    <td>Kod pocztowy<br /><asp:Literal ID="departmentPostCodeLiteral" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="5">
                        Działalność w zakresie<br /><br />
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 20%; border-width: 0px; text-align: center;">W <span id="creationSpan" runat="server">[ ]</span></td>
                                <td style="width: 20%; border-width: 0px; text-align: center;">Zb <span id="collectionSpan" runat="server">[ ]</span></td>
                                <td style="width: 20%; border-width: 0px; text-align: center;">Od <span id="recyclingSpan" runat="server">[ ]</span></td>
                                <td style="width: 20%; border-width: 0px; text-align: center;">Un <span id="destructionSpan" runat="server">[ ]</span></td>
                                <td style="width: 20%; border-width: 0px; text-align: center;">Ok <span id="communalSpan" runat="server">[ ]</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table id ="table" class="miniDataTable" runat="server" border="1">
                <tr>
                    <th style="min-width: 55px" rowspan="3">Data</th>
                    <th rowspan="3">Masa wytworzonych odpadów [Mg]</th>
                    <th rowspan="3">Masa odebranych odpadów komunalnych [Mg]</th>
                    <th rowspan="3">Masa przyjętych odpadów [Mg]</th>
                    <th rowspan="3">Nr karty przekazania odpadu</th>
                    <th colspan="6">Gospodarowanie odpadami</th>
                </tr>
                <tr>
                    <th colspan="3">We własnym zakresie</th>
                    <th colspan="2">Odpady przekazane</th>
                    <th rowspan="2">Imię i nazwisko osoby sporządzającej</th>
                </tr>
                <tr>
                    <th>masa [Mg]</th>
                    <th>metoda odzysku R</th>
                    <th>metoda unieszkodliwiania D</th>
                    <th>masa [Mg]</th>
                    <th>nr karty przekazania odpadu</th>
                </tr>
            </table>
            <asp:Button ID="printButton" OnClientClick="javascript: return PrintPage(this);" 
                CssClass="smallButton" runat="server" Text="Drukuj" />&nbsp;
            <asp:Button ID="exportToPdfButton" CssClass="mediumButton" runat="server" 
                Text="Eksportuj do PDF" onclick="ExportToPdfButtonClick" />
        </div>
    </form>
</body>
</html>
