<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovementBatteryReportView.aspx.cs" Inherits="EVident.MovementBatteryReportView" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Roczne sprawozdanie o masie zebranych i zużytych baterii i akumulatorów przenośnych</title>
    <link href="Default.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="./JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="page" style="border: none;" runat="server">
        <table class="dataTable">
            <tr>
                <th>
                    SPRAWOZDANIE O MASIE ZEBRANYCH ZUŻYTYCH <br/> 
                    BATERII PRZENOŚNYCH I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH <br/> 
                    za <asp:Literal runat="server" ID="YearL"/> &nbsp;rok

                </th>
                <td>
                    <span class="smaller">Adresat:</span><br/>MARSZAŁEK<br />WOJEWÓDZTWA<br/><asp:Literal runat="server" ID="MarshalProvinceL"/>
                </td>
            </tr>
        </table>
        <table class="dataTable">
            <tr>
                <td colspan="4">
                    <b>I. DANE ZBIERAJĄCEGO ZUŻYTE BATERIE LUB ZUŻYTE AKUMULATORY</b>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <span class="smaller">Firma przedsiębiorcy</span><br/><asp:Literal runat="server" ID="CompanyNameL"/>
                </td>
            </tr>
            <tr>
                <td colspan="4"><b>Oznaczenie siedziby i adres</b></td>
            </tr>
            <tr>
                <td colspan="2"><span class="smaller">Województwo</span><br/><asp:Literal runat="server" ID="CompanyProvinceL"/></td>
                <td colspan="2"><span class="smaller">Miejscowość</span><br/><asp:Literal runat="server" ID="CompanyPlaceL"/></td>
            </tr>
            <tr>
                <td><span class="smaller">Kod pocztowy</span><br/><asp:Literal runat="server" ID="CompanyPostCodeL"/></td>
                <td><span class="smaller">Ulica</span><br/><asp:Literal runat="server" ID="CompanyStreetL"/></td>
                <td><span class="smaller">Nr domu</span><br/><asp:Literal runat="server" ID="CompanyBuildingNumberL"/></td>
                <td><span class="smaller">Nr lokalu</span><br/><asp:Literal runat="server" ID="CompanyFlatNumber"/></td>
            </tr>
            <tr>
                <td colspan="4"><span class="smaller">NIP</span><br/><asp:Literal runat="server" ID="CompanyNIPL"/></td>
            </tr>
            <tr>
                <td colspan="4"><span class="smaller">REGON</span><br/><asp:Literal runat="server" ID="CompanyREGONL"/></td>
            </tr>
        </table>
        <table class="dataTable">
            <tr>
                <td colspan="2"><b>II. DANE DOTYCZĄCE MASY ZEBRANYCH ZUŻYTYCH BATERII PRZENOŚNYCH <br/> &nbsp;&nbsp;&nbsp;&nbsp;I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH OGÓŁEM</b></td>
            </tr>
            <tr>
                <th><span class="smaller">Rodzaj zebranych zużytych <br/> baterii przenośnych i zużytych <br/> akumulatorów przenośnych</span></th>
                <th><span class="smaller">Ogólna masa zebranych zużytych baterii przenośnych <br/> i zużytych akumulatorów przenośnych <br/> [kg]</span></th>
            </tr>
            <tr>
                <td><span class="smaller">16 06 01*</span></td>
                <td class="alignright"><asp:Literal runat="server" ID="Weight160601L2"/></td>
            </tr>
            <tr>
                <td><span class="smaller">16 06 02*</span></td>
                <td class="alignright"><asp:Literal runat="server" ID="Weight160602L2"/></td>
            </tr>
            <tr>
                <td><span class="smaller">16 06 03*</span></td>
                <td rowspan="3" class="alignright"><asp:Literal runat="server" ID="Weight16060345L2"/></td>
            </tr>
            <tr><td><span class="smaller">16 06 04</span></td></tr>
            <tr><td><span class="smaller">16 06 05</span></td></tr>
            <tr>
                <td><span class="smaller">20 01 33*</span></td>
                <td class="alignright"><asp:Literal runat="server" ID="Weight200133L2"/></td>
            </tr>
            <tr>
                <td><span class="smaller">20 01 34</span></td>
                <td class="alignright"><asp:Literal runat="server" ID="Weight200134L2"/></td>
            </tr>
            <tr>
                <td class="alignright"><b>Ogółem</b></td>
                <td class="alignright"><b><asp:Literal runat="server" ID="WeightSumL2"/></b></td>
            </tr>
        </table>
        
            <asp:Repeater ID="Table3Repeater" runat="server" 
            onitemdatabound="Table3RepeaterItemDataBound">
                <HeaderTemplate>
                    <table class="pagebreak, dataTable">
                        <tr>
                            <td colspan="3"><b>III. DANE DOTYCZĄCE MASY ZEBRANYCH ZUŻYTYCH BATERII PRZENOŚNYCH <br/> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH ZEBRANYCH BEZPOŚREDNIO DLA <br/> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WPROWADZAJĄCEGO BATERIE LUB AKUMULATORY</b></td>
                        </tr>
                        <tr>
                            <th colspan="2"><span class="smaller">Dane wprowadzającego baterie przenośne lub <br/> akumulatory przenośne</span></th>
                            <th rowspan="2"><span class="smaller">Masa zebranych i zużytych baterii <br /> przenośnych i zużytych <br/> akumulatorów przenośnych <br/> [kg]</span></th>
                        </tr>
                        <tr>
                            <th><span class="smaller">numer rejestrowy</span></th>
                            <th><span class="smaller">firma przedsiębiorcy</span></th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                         <td>
                             <asp:Literal ID="L1" runat="server" Text='<%#Eval("numer") %>'/>
                         </td>
                         <td>
                             <asp:Literal ID="L2" runat="server" Text='<%#Eval("name") %>'/>
                         </td>
                         <td class="alignright">
                             <asp:Literal ID="L3" runat="server" Text='<%#Eval("mass","{0:F2}") %>'/>
                         </td>
                     </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="2" class="alignright"><span class="smaller"><b>Ogółem</b></span></td>
                        <td class="alignright"><b><asp:Literal runat="server" ID="Table3Sum"/></b></td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <div style="height: 40mm"></div>
            <asp:Repeater runat="server" ID="Table4Repeater" 
                    onitemdatabound="Table4RepeaterItemDataBound">
                <HeaderTemplate>
                    <table class="dataTable">
                        <tr>
                            <td colspan="3">
                                <b>IV. DANE DOTYCZĄCE MASY ZEBRANYCH BATERII PRZENOŚNYCH<br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I ZUŻYTYCH AKUMULATORÓW PRZENOŚNYCH ZEBRANYCH DLA INNYCH<br/> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PODMIOTÓW</b>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2"><span class="smaller">Dane podmiotu</span></th>
                            <th rowspan="2"><span class="smaller">Masa zebranych zużytych baterii<br/>przenośnych i zużytych akumulatorów przenośnych<br/>[kg]</span></th>
                        </tr>
                        <tr>
                            <th><span class="smaller">firma przedsiębiorcy</span></th>
                            <th><span class="smaller">oznaczenie siedziby<br/>i adres</span></th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><asp:Literal runat="server" Text='<%# Eval("name") %>'/></td>
                        <td><asp:Literal runat="server" Text='<%#Eval("address") %>'/></td>
                        <td class="alignright"><asp:Literal runat="server" Text='<%#Eval("mass","{0:F2}") %>'/></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        <tr>
                            <td colspan="2" class="alignright"><span class="smaller">Ogółem</span></td>
                            <td class="alignright"><b><asp:Literal runat="server" ID="Table4Sum" /></b></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <table class="pagebreak, dataTable">
                <tr>
                    <td colspan="6"><b>V. DANE OSOBY WYPEŁNIAJĄCEJ SPRAWOZDANIE</b></td>
                </tr>
                <tr>
                    <td colspan="3"><span class="smaller">Imię<br />
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
                    <td colspan="4"><div style="height: 4em"><span class="smaller">Podpis i pieczątka zbierającego zużyte baterie lub zyżyte akumulatory</span></div></td>
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
