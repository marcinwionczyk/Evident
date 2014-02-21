<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="AnnualReport.aspx.cs" Inherits="EVident.AnnualReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:Label runat="server">Wybierz rok: </asp:Label>
    <asp:DropDownList ID="yearDropDownList" runat="server" AutoPostBack="true">
        <asp:ListItem Value="1">2012</asp:ListItem>
    </asp:DropDownList>
    <asp:HyperLink ID="goToReportHyperLink" runat="server" Target="_blank">Przejdź do raportu</asp:HyperLink>
</asp:Content>
