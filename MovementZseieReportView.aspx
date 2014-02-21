<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovementZseieReportView.aspx.cs" Inherits="EVident.MovementZSEiEReportView" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title> Sprawozdanie o masie zebranego sprzętu i przekazanego do prowadzącego zakład przetwarzania zużytego sprzętu </title>
        <link href="Default.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="./JavaScript.js"> </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div id="page" style="border: none;" runat="server">
                <div id="firstpage" style="min-height: 280mm; height: auto" >
            
        
                    <table class="dataTable">
                        <tr>
                            <th>
                                SPRAWOZDANIE O MASIE ZEBRANEGO <br/> 
                                I PRZEKAZANEGO DO PROWADZĄCEGO <br/>
                                ZAKŁAD PRZETWARRZANIA ZUŻYTEGO SPRZĘTU <br/>
                                za <asp:Literal runat="server" ID="HalfOfYear"/> roku
                            </th>
                            <th style="text-align: left">
                                ADRESAT: <br/>
                                GŁÓWNY INSPEKTOR
                                OCHRONY 
                                <br />
                                ŚRODOWISKA
                            </th>
                        </tr>
                    </table>
                    <table class="dataTable">
                        <tr>
                            <td colspan="4"><b>I. DANE ZBIERAJĄCEGO ZUŻYTY SPRZĘT</b></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="smaller">Numer rejestrowy</span><br/>
                                <asp:Literal runat="server" ID="GIOSRegisterNumber"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="smaller">Firma przedsiębiorcy</span><br/>
                                <asp:Literal runat="server" ID="CompanyFullName"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4"><b>Oznaczenie siedziby i adres</b></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <span class="smaller">Województwo</span><br/>
                                <asp:Literal runat="server" ID="Province"/>
                            </td>
                            <td colspan="2">
                                <span class="smaller">Miejscowość</span><br/>
                                <asp:Literal runat="server" ID="Place"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="smaller">Kod pocztowy</span><br/>
                                <asp:Literal runat="server" ID="PostCode"/>
                            </td>
                            <td>
                                <span class="smaller">Ulica</span><br/>
                                <asp:Literal runat="server" ID="Street"/>
                            </td>
                            <td>
                                <span class="smaller">Numer domu</span> <br/>
                                <asp:Literal runat="server" ID="BuildingNumber"/>
                            </td>
                            <td>
                                <span class="smaller">Numer lokalu</span> <br/>
                                <asp:Literal runat="server" ID="FlatNumber"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="smaller">NIP</span><br/>
                                <asp:Literal runat="server" ID="NIP"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="smaller">REGON</span><br/>
                                <asp:Literal runat="server" ID="REGON"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <b>Adresy miejsc w których zbierany jest zużyty sprzęt</b>
                            </td>
                        </tr>
                    </table>
                    <asp:Repeater runat="server" ID="WhereUsedEquipmentISCollected">
                        <HeaderTemplate>
                            <table class="dataTable">
                            <tr>
                                <th>L.p.</th>
                                <th>Miejscowość</th>    
                                <th>Kod pocztowy</th>
                                <th>Ulica</th>
                                <th>Numer domu</th>
                                <th>Numer lokalu</th>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Container.ItemIndex + 1 %>
                                </td>
                                <td>
                                    <asp:Literal runat="server" Text='<%# Eval("Place") %>'/>
                                </td>
                                <td>
                                    <asp:Literal runat="server" Text='<%# Eval("PostCode") %>'/>
                                </td>
                                <td>
                                    <asp:Literal runat="server" Text='<%# Eval("Street") %>'/>
                                </td>
                                <td>
                                    <asp:Literal runat="server" Text='<%# Eval("BuildingNumber") %>'/>
                                </td>
                                <td>
                                    <asp:Literal runat="server" Text='<%# Eval("FlatNumber") %>'/>
                                </td>
                            </tr>
                
                        </ItemTemplate>
                        <FooterTemplate>
                        </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div id ="secondpage" style="min-height: 280mm; height: auto">
                    <table class="dataTable">
                        <tr>
                            <td colspan="5"><b>II. DANE DOTYCZĄCE ZUŻYTEGO SPRZĘTU</b></td>
                        </tr>
                        <asp:Repeater runat="server" ID="DataCollectedAboutWasteEquipment">
                            <HeaderTemplate>
                                <tr>
                                    <td rowspan="3">Numer i nazwa grupy <br/> wprowadzonego sprzętu, z <br/> którego powstał zużyty sprzęt</td>
                                    <td rowspan="3">Numer i nazwa rodzaju <br/> wprowadzonego sprzętu, z <br/> którego powstał zebrany zużyty <br/> sprzęt</td>
                                    <td colspan="2">Masa zebrnego zużytego sprzętu</td>
                                    <td rowspan="2">Masa zużytego <br/> sprzętu <br/> przekazanego do prowadzącego zakład przetwarzania</td>
                                </tr>
                                <tr>
                                    <td>pochodzącego z gospodarstw domowych</td>
                                    <td>pochodzącego od użytkowników innych niż gospodarstwa domowe</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: center">[kg]</td>
                                </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("ZseieKind") %>'/>
                                    </td> 
                                    <td>
                                        <asp:Literal ID="Literal2" runat="server" Text='<%# Eval("ZseieCod") %>'/>
                                    </td> 
                                    <td>
                                        <asp:Literal ID="Literal3" runat="server" Text='<%# Eval("ReceivedMassFromHomeSum", "{0:F2}") %>'/>
                                    </td> 
                                    <td>
                                        <asp:Literal ID="Literal4" runat="server" Text='<%# Eval("ReceivedFromOthersSum", "{0:F2}") %>'/>
                                    </td> 
                                    <td>
                                        <asp:Literal ID="Literal5" runat="server" Text='<%# Eval("TransferedSum", "{0:F2}") %>'/>
                                    </td> 
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>     
                </div>
       
                <table class="dataTable">
                    <tr>
                        <td colspan="6"><b>III. DANE OSOBY SPORZĄDZAJĄCEJ SPRAWOZDANIE</b></td>
                    </tr>
                    <tr>
                        <td colspan="3"><span class="smaller">Imię
                                        </span><br/><asp:Literal runat="server" ID="BussinessFirstNameL"/></td>
                        <td colspan="3"><span class="smaller">Nazwisko</span><br/><asp:Literal runat="server" ID="BussinessLastNameL"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span class="smaller">Telefon służbowy</span><br/><asp:Literal runat="server" ID="BussinessPhoneL"/></td>
                        <td colspan="2"><span class="smaller">Faks służbowy</span><br/><asp:Literal runat="server" ID="BussinessFaxL"/></td>
                        <td colspan="2"><span class="smaller">E-mail służbowy</span><br/><asp:Literal runat="server" ID="BussinessEmailL"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><div style="height: 4em"><span class="smaller">Data</span></div></td>
                        <td colspan="4"><div style="height: 4em"><span class="smaller">Podpis i pieczątka zbierającego zużyty sprzęt</span></div></td>
                    </tr>
                </table>
                <asp:Button ID="PrintButton" runat="server" Text="Drukuj" 
                            OnClientClick="javascript: return PrintPage(this);" CssClass="smallButton"/>
                <asp:Button ID="exportToPdfButton" CssClass="mediumButton" runat="server" 
                Text="Eksportuj do PDF" onclick="ExportToPdfButtonClick" />
            </div>
        </form>
    </body>
</html>