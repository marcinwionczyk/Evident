<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AnnualReportSection1TableA.ascx.cs" Inherits="EVident.UserControl.AnnualReportSection1TableA" %>

<table id="section1TableA" runat="server" class="dataTable">
    <tr>
        <th colspan="8">Dane o posiadaczu odpadów</th>
        <td colspan="3">Rok sprawozdawczy<br /> <asp:Literal ID="yearLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="8">Posiadacz odpadów<br /> <asp:Literal ID="ownerNameLiteral" runat="server" /></td>
        <td colspan="3">Nr rejestrowy<br /> <asp:Literal ID="ownerRegisterNumberLiteral" runat="server" /></td>
    </tr>
    <tr>
        <th colspan="11">Adres posiadacza odpadów</th>
    </tr>
    <tr>
        <td colspan="3">Województwo<br /> <asp:Literal ID="ownerProvinceLiteral" runat="server" /></td>
        <td colspan="3">Miejscowość<br /> <asp:Literal ID="ownerPlaceLiteral" runat="server" /></td>
        <td colspan="3">Telefon służbowy<br /> <asp:Literal ID="ownerPhoneLiteral" runat="server" /></td>
        <td colspan="2">Faks służbowy<br /> <asp:Literal ID="ownerFaxLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="3">Kod pocztowy<br /> <asp:Literal ID="ownerPostCodeLiteral" runat="server" /></td>
        <td colspan="3">Ulica<br /> <asp:Literal ID="ownerStreetLiteral" runat="server" /></td>
        <td colspan="3">Nr domu<br /> <asp:Literal ID="ownerHomeNumberLiteral" runat="server" /></td>
        <td colspan="2">Nr lokalu<br /> <asp:Literal ID="ownerFlatLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="6">NIP<br /> <asp:Literal ID="ownerNipLiteral" runat="server" /></td>
        <td colspan="5">REGON<br /> <asp:Literal ID="ownerRegonLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="11">Rodzaj prowadzonej działalności według klasyfikacji PKD<br /><br /> <asp:Literal ID="ownerPkdLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td>Wypełniono i załączono działy, tabele</td>
        <td>
            1<br />
            <asp:CheckBox ID="section1TableACheckBox" runat="server" Text="Tabela A" Checked="true" Enabled="false" /><br />
            <asp:CheckBox ID="section1TableBCheckBox" runat="server" Text="Tabela B" Checked="true" Enabled="false" />
        </td>
        <td>2<br /><asp:CheckBox ID="section2CheckBox" runat="server" Enabled="false" /></td>
        <td>3<br /><asp:CheckBox ID="section3CheckBox" runat="server" Enabled="false" /></td>
        <td>4<br /><asp:CheckBox ID="section4CheckBox" runat="server" Enabled="false" /></td>
        <td>
            5<br />
            <asp:CheckBox ID="section5TableACheckBox" runat="server" Text="Tabela A" Enabled="false" /><br />
            <asp:CheckBox ID="section5TableBCheckBox" runat="server" Text="Tabela B" Enabled="false" /><br />
            <asp:CheckBox ID="section5TableCCheckBox" runat="server" Text="Tabela C" Enabled="false" />
        </td>
        <td>
            6<br />
            <asp:CheckBox ID="section6TableACheckBox" runat="server" Text="Tabela A" Enabled="false" /><br />
            <asp:CheckBox ID="section6TableBCheckBox" runat="server" Text="Tabela B" Enabled="false" />
        </td>
        <td>7<br /><asp:CheckBox ID="section7CheckBox" runat="server" Enabled="false" /></td>
        <td>8<br /><asp:CheckBox ID="section8CheckBox" runat="server" Enabled="false" /></td>
        <td>9<br /><asp:CheckBox ID="section9CheckBox" runat="server" Enabled="false" /></td>
        <td>
            10<br />
            <asp:CheckBox ID="section10TableACheckBox" runat="server" Text="Tabela A" Enabled="false" /><br />
            <asp:CheckBox ID="section10TableBCheckBox" runat="server" Text="Tabela B" Enabled="false" />
        </td>
    </tr>
    <tr>
        <td colspan="2">Łączna liczba załączników</td>
        <td colspan="9"><asp:Literal ID="checkedCountLiteral" runat="server" /></td>
    </tr>
    <tr>
        <th colspan="11">Dane osoby sporządzającej zbiorcze zestawienie danych</th>
    </tr>
    <tr>
        <td colspan="6">Imię<br /> <asp:Literal ID="authorFirstNameLiteral" runat="server" /></td>
        <td colspan="5">Nazwisko<br /> <asp:Literal ID="authorLastNameLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="3">Telefon służbowy<br /> <asp:Literal ID="authorPhoneLiteral" runat="server" /></td>
        <td colspan="3">Faks służbowy<br /> <asp:Literal ID="authorFaxLiteral" runat="server" /></td>
        <td colspan="5">E-Mail służbowy<br /> <asp:Literal ID="authorEmailLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="3">Data<br /> <asp:Literal ID="dateLiteral" runat="server" /></td>
        <td colspan="3">Podpis sporządzającego</td>
        <td colspan="5">Podpis i pieczątka posiadacza odpadów</td>
    </tr>
</table>