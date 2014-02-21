<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="NoCompanyRight.aspx.cs" Inherits="EVident.NoCompanyRight" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Brak uprawnień do wybranej podstrony (<asp:Literal ID="pagePathLiteral" runat="server" />)</h3>
    <p class="error">Twoja firma nie ma odpowiednich uprawnień aby wejść na wybraną podstronę.</p>
</asp:Content>
