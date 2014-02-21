<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransferCardView.aspx.cs" Inherits="EVident.TransferCardView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>KPO</title>
        <link href="Default.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="./JavaScript.js"> </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div id="page">
                <table class="dataTable">
                    <tr>
                        <th style="vertical-align: middle">KARTA PRZEKAZANIA ODPADU</th>
                        <td><span class="smaller">Nr karty</span><br/><asp:Literal ID="TransferCardNumberL" runat="server"/> </td>
                        <td><span class="smaller">Rok kalendarzowy</span><br/><asp:Literal ID="YearL" runat="server"/></td>
                    </tr>
                </table>
                <table class="dataTable">
                    <tr>
                        <td><div style="height: 1.5em"><span class="smaller">Posiadacz odpadów, który przekazuje odpad</span></div><br/>
                            <asp:Literal ID="WhoIsTransferingNameL" runat="server"/>
                        </td>
                        <td><div style="height: 1.5em"><span class="smaller">Transportujący odpad</span></div><br/>
                            <asp:Literal ID="WhoIsTransportingNameL" runat="server"/>
                        </td>
                        <td><div style="height: 1.5em"><span class="smaller">Posiadacz odpadów, który przejmuje odpad</span></div><br/>
                            <asp:Literal ID="WhoTakesWasteNameL" runat="server"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="height: .5em"><span class="smaller">Adres</span></div><br/>
                            <asp:Literal ID="WhoIsTransferringAddressL" runat="server"/>
                        </td>
                        <td>
                            <div style="height: .5em"><span class="smaller">Adres</span></div><br/>
                            <asp:Literal ID="WhoIsTransportingAddressL" runat="server"/>
                        </td>
                        <td>
                            <div style="height: .5em"><span class="smaller">Adres</span></div><br/>
                            <asp:Literal runat="server" ID="WhoTakesWasteAddressL"/>
                        </td>
                    </tr>
                    <tr>
                        <td><div style="height: .5em"><span class="smaller">Nr REGON</span></div><br/><asp:Literal ID="WhoIsTransferringREGON_L" runat="server"/></td>
                        <td><div style="height: .5em"><span class="smaller">Nr REGON</span></div><br/><asp:Literal ID="WhoIsTransportingREGON_L" runat="server"/></td>
                        <td><div style="height: .5em"><span class="smaller">Nr REGON</span></div><br/><asp:Literal ID="WhoTakesWasteREGON_L" runat="server"/></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div style="height: .5em"><span class="smaller">Miejsce przeznaczenia odpadów</span></div><br/>
                            <asp:Literal runat="server" ID="WasteDestinationAddressL"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div style="height: .5em"><span class="smaller">Rodzaj procesu przetwarzania, któremu powinien zostać poddany odpad</span></div><br/>
                            <asp:Literal runat="server" ID="WasteProcessingMethodL"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            Wnioskuję o wydanie dokumentu potwierdzającego odzysk lub recykling: 
                            <div style="float: right; width: 15%"><asp:CheckBox runat="server" ID="DpoNotRequired" Text="Nie" /></div>
                            <div style="width: 15%; float: right"><asp:CheckBox ID="DpoRequired" runat="server" Text="Tak"/></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="smaller">Kod odpadu</span><br/>
                            <asp:Literal ID="WasteCodeNameL" runat="server"/>
                        </td>
                        <td colspan="2">
                            <span class="smaller">Rodzaj odpadu </span><br/>
                            <asp:Literal runat="server" ID="WasteCodeDescriptionL"/>
                        </td>
                    </tr>
             
                    <asp:Repeater ID="Repeater1" runat="server">
                        <HeaderTemplate>
                            <tr style="vertical-align: middle">
                                <th>Data / miesiąc</th>
                                <th>Masa przekazanych odpadów [Mg]</th>
                                <th>Numer rejestracyjny pojazdu, przyczepy lub naczepy</th>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("DateItem", "{0:d MMMM yyyy}") %>'/>
                                </td>
                                <td>
                                    <asp:Literal ID="Literal2" runat="server" Text='<%# Eval("MassItem", "{0:F4}") %>'/>
                                </td>
                                <td>
                                    <asp:Literal ID="Literal3" runat="server" Text='<%# Eval("VehicleNumberItem") %>'/>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td>
                            <div style="height: 6em"><span class="smaller">Potwierdzam przekazanie odpadu</span></div>
                            <span class="smaller">data, pieczęć i podpis</span>
                        </td>
                        <td>
                            <div style="height: 6em"><span class="smaller">Potwierdzam wykonanie usługi transportu</span></div>
                            <span class="smaller">data, pieczęć i podpis</span>
                        </td>
                        <td>
                            <div style="height: 6em"><span class="smaller">Potwierdzam przyjęcie odpadu</span></div>
                            <span class="smaller">data, pieczęć i podpis</span>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="PrintButton" runat="server" Text="Drukuj " 
                            OnClientClick="javascript: return PrintPage(this);" CssClass="smallButton"/>
            </div>
        </form>

    </body>
</html>