<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Warning.aspx.cs" Inherits="EVident.Warning" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Nieprawidłowości w prowadzonej ewidencji</h3>
    <asp:Literal ID="warningLiteral" runat="server" />
</asp:Content>
