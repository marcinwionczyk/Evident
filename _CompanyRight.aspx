<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="_CompanyRight.aspx.cs" Inherits="EVident._CompanyRight" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Uprawnienia zarejestrowanej firmy</h3>
    <h4>FIRMA: <asp:Literal ID="companyFullNameLiteral" runat="server" /></h4><br />
    <asp:CheckBox ID="creationCheckBox" Text="Wytworzenie" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="collectionCheckBox" Text="Przyjęcie" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="collectionZseieCheckBox" Text="Przyjęcie ZSEiE" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="collectionBatteryCheckBox" Text="Przyjęcie baterii" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="collectionMetalCheckBox" Text="Przyjęcie metali" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="recyclingCheckBox" Text="Odzysk" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="destructionCheckBox" Text="Unieszkodliwianie" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="transferCheckBox" Text="Przekazanie" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="transferZseieCheckBox" Text="Przekazanie ZSEiE" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="transferBatteryCheckBox" Text="Przekazanie baterii" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="transferIndividualCheckBox" Text="Przekazanie osobom i organizacjom" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="kpoCheckBox" Text="KPO" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="dprDpoCheckBox" Text="DPR/DPO" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="annualReportCheckBox" Text="Zestawienie roczne o odpadach" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="movementZseieReportCheckBox" Text="Sprawozdanie o masie zebranego i przekazanego, zużytego sprzętu" runat="server" CssClass="defaultCheckBox" /><br />
    <asp:CheckBox ID="movementBatteryReportCheckBox" Text="Sprawozdanie o masie zebranych i zużytych baterii i akumulatorów" runat="server" CssClass="defaultCheckBox" /><br /><br />
    <asp:Button ID="saveButton" runat="server" Text="Aktualizuj" 
        CssClass="mediumButton" onclick="SaveButtonClick" />
</asp:Content>
