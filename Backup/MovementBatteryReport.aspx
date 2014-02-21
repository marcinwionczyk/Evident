<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="MovementBatteryReport.aspx.cs" Inherits="EVident.BatteryWasteMovementReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Sprawozdanie o masie zebranych i zużytych baterii i akumulatorów</h3>
    <p>Wybierz rok: 
        <asp:DropDownList ID="YearDDL" runat="server" DataTextField="Year"/>
    </p>
    <asp:Button ID="RaportButton" runat="server" Text="Generuj raport" 
        CssClass="mediumButton" onclick="RaportButtonClick" OnClientClick="aspnetForm.target ='_blank';" />
</asp:Content>
