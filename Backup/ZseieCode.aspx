<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="ZseieCode.aspx.cs" Inherits="EVident.ZseieCode1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Katalog ZSEiE</h3>
    <span>Filtr: </span>
    <asp:TextBox CssClass="mediumTextBox" ID="filterTextBox" runat="server"></asp:TextBox>
    &nbsp;
    <asp:Button CssClass="smallButton" ID="filterButton" runat="server" Text="Filtruj" />
    <asp:EntityDataSource ID="zseieCodeDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="ZseieCodes" 
        EntityTypeFilter="ZseieCode" 
    Where="it.Level = 1 &amp;&amp; (it.Name LIKE '%' + @Filter + '%' || it.Description LIKE '%' + @Filter + '%')">
        <WhereParameters>
            <asp:ControlParameter ControlID="filterTextBox" 
                ConvertEmptyStringToNull="False" DbType="String" Name="Filter" 
                PropertyName="Text" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="zseieCodeListView" runat="server" DataKeyNames="Id" 
        DataSourceID="zseieCodeDataSource" EnableModelValidation="True">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>
                        Tabela nie zawiera danych.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                </td>
                <td>
                    <asp:Label ID="DescriptionLabel" runat="server" 
                        Text='<%# Eval("Description") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table class="dataTable" ID="itemPlaceholderContainer" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Lp.</th>
                    <th runat="server">
                        Opis</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
