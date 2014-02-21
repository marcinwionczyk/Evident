<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="ProcessingMethod.aspx.cs" Inherits="EVident.ProcessingMethod1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Metody unieszkodliwiania i odzysku</h3>
    <span>Grupa: </span>
    <asp:DropDownList CssClass="smallDropDownList" AutoPostBack="true" ID="groupDropDownList" runat="server">
        <asp:ListItem Value="1">unieszkodliwianie</asp:ListItem>
        <asp:ListItem Value="0">odzysk</asp:ListItem>
    </asp:DropDownList>
    <span>Filtr: </span>
    <asp:TextBox CssClass="mediumTextBox" ID="filterTextBox" runat="server"></asp:TextBox>
    &nbsp;
    <asp:Button CssClass="smallButton" ID="filterButton" runat="server" Text="Filtruj" />
    <asp:EntityDataSource ID="processingMethodDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
        EntityTypeFilter="ProcessingMethod" Where="it.Kind == @Kind &amp;&amp; 
(it.Name LIKE '%' + @Filter + '%' || it.Description LIKE '%' + @Filter + '%')" 
        OrderBy="Length(it.Name), Right(it.Name, Length(it.Name) - 1)">
        <WhereParameters>
            <asp:ControlParameter ControlID="groupDropDownList" DbType="Int32" 
                Name="Kind" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="filterTextBox" 
                ConvertEmptyStringToNull="False" DbType="String" Name="Filter" 
                PropertyName="Text" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="processingMethodListView" runat="server" DataKeyNames="Id" 
        DataSourceID="processingMethodDataSource" EnableModelValidation="True">
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
                        Nazwa</th>
                    <th runat="server">
                        Opis</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
