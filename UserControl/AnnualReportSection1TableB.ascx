<%@ Control ClassName="AnnualReportSection1TableB" Language="C#" AutoEventWireup="true" CodeBehind="AnnualReportSection1TableB.ascx.cs" Inherits="EVident.UserControl.AnnualReportSection1TableB" %>

<table id="section1TableB" runat="server" class="dataTable">
    <tr>
        <th colspan="5">Miejsce prowadzenia działalności</th>
    </tr>
    <tr>
        <td colspan="2">Województwo<br /> <asp:Literal ID="provinceLiteral" runat="server" /></td>
        <td colspan="2">Gmina<br /> <asp:Literal ID="communeLiteral" runat="server" /></td>
        <td colspan="1">Miejscowość<br /> <asp:Literal ID="placeLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="2">Ulica<br /> <asp:Literal ID="streetLiteral" runat="server" /></td>
        <td colspan="2">Nr domu<br /> <asp:Literal ID="homeNumberLiteral" runat="server" /></td>
        <td colspan="1">Nr lokalu<br /> <asp:Literal ID="flatNumberLiteral" runat="server" /></td>
    </tr>
    <tr>
        <th colspan="5">Decyzje</th>
    </tr>
    <tr>
        <td>Decyzja w zakresie gospodarki odpadami</td>
        <td>Znak decyzji</td>
        <td>Data wydania</td>
        <td>Termin obowiązywania decyzji</td>
        <td>Organ wydający decyzję</td>
    </tr>
    <tr>
        <td>Wytwarzanie odpadów</td>
        <td><asp:Literal ID="creationDecisionNumberLiteral" runat="server" /></td>
        <td><asp:Literal ID="creationDecisionReleaseDateLiteral" runat="server" /></td>
        <td><asp:Literal ID="creationDecisionPeriodLiteral" runat="server" /></td>
        <td><asp:Literal ID="creationDecisionReleaseAuthorityLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td>Zbieranie odpadów</td>
        <td><asp:Literal ID="collectionDecisionNumberLiteral" runat="server" /></td>
        <td><asp:Literal ID="collectionDecisionReleaseDateLiteral" runat="server" /></td>
        <td><asp:Literal ID="collectionDecisionPeriodLiteral" runat="server" /></td>
        <td><asp:Literal ID="collectionDecisionReleaseAuthorityLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td>Odzysk</td>
        <td><asp:Literal ID="recyclingDecisionNumberLiteral" runat="server" /></td>
        <td><asp:Literal ID="recyclingDecisionReleaseDateLiteral" runat="server" /></td>
        <td><asp:Literal ID="recyclingDecisionPeriodLiteral" runat="server" /></td>
        <td><asp:Literal ID="recyclingDecisionReleaseAuthorityLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td>Unieszkodliwianie odpadów</td>
        <td><asp:Literal ID="destructionDecisionNumberLiteral" runat="server" /></td>
        <td><asp:Literal ID="destructionDecisionReleaseDateLiteral" runat="server" /></td>
        <td><asp:Literal ID="destructionDecisionPeriodLiteral" runat="server" /></td>
        <td><asp:Literal ID="destructionDecisionReleaseAuthorityLiteral" runat="server" /></td>
    </tr>
    <tr>
        <td>Odbieranie odpadów komunalnych</td>
        <td><asp:Literal ID="communalDecisionNumberLiteral" runat="server" /></td>
        <td><asp:Literal ID="communalDecisionReleaseDateLiteral" runat="server" /></td>
        <td><asp:Literal ID="communalDecisionPeriodLiteral" runat="server" /></td>
        <td><asp:Literal ID="communalDecisionReleaseAuthorityLiteral" runat="server" /></td>
    </tr>
    <tr>
        <th colspan="5">Rodzaj prowadzonej działalności</th>
    </tr>
    <tr>
        <td colspan="5">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 20%; border: none; text-align: center;"><asp:CheckBox ID="creationCheckBox" runat="server" Text="W" Enabled="false" /></td>
                    <td style="width: 20%; border: none; text-align: center;"><asp:CheckBox ID="collectionCheckBox" runat="server" Text="Zb" Enabled="false" /></td>
                    <td style="width: 20%; border: none; text-align: center;"><asp:CheckBox ID="recyclingCheckBox" runat="server" Text="Od" Enabled="false" /></td>
                    <td style="width: 20%; border: none; text-align: center;"><asp:CheckBox ID="destructionCheckBox" runat="server" Text="Un" Enabled="false" /></td>
                    <td style="width: 20%; border: none; text-align: center;"><asp:CheckBox ID="communalCheckBox" runat="server" Text="Ok" Enabled="false" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <th colspan="3">Data rozpoczęcia prowadzenia działalności</th>
        <td colspan="2"><asp:Literal ID="startDateLiteral" runat="server" /></td>
    </tr>
    <tr>
        <th colspan="3">Data zakończenia prowadzenia działalności (jeśli dotyczy)</th>
        <td colspan="2"><asp:Literal ID="endDateLiteral" runat="server" /></td>
    </tr>
</table>