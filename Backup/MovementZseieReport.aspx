<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="MovementZseieReport.aspx.cs" Inherits="EVident.CommonWasteMovementReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Sprawozdanie o masie zebranego i przekazanego zużytego sprzętu</h3>
    Sprawozdanie za: 
    <asp:DropDownList runat="server" ID="YearHalfDDL">
        <asp:ListItem Text="I półrocze"/>
        <asp:ListItem Text="II półrocze"/>
    </asp:DropDownList>
    <asp:Button ID="RaportButton" runat="server" Text="Generuj raport" 
                CssClass="mediumButton" onclick="RaportButtonClick" OnClientClick="aspnetForm.target ='_blank';" />
</asp:Content>