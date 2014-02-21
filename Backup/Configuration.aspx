<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Configuration.aspx.cs" Inherits="EVident.Configuration1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Konfiguracja</h3>
    <asp:EntityDataSource ID="configurationDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="Configurations" 
        EntityTypeFilter="Configuration">
    </asp:EntityDataSource>
    <asp:ListView ID="configurationListView" runat="server" DataKeyNames="Id" 
        DataSourceID="configurationDataSource" EnableModelValidation="True" 
        InsertItemPosition="None" ConvertEmptyStringToNull="False">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="KeyLabel" runat="server" Text='<%# Eval("Key") %>' />
                </td>
                <td>
                    <asp:TextBox CssClass="largeTextBox" ID="ValueTextBox" runat="server" Text='<%# Bind("Value") %>' />
                    <asp:RequiredFieldValidator ValidationGroup="UPDATE" ControlToValidate="ValueTextBox" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:LinkButton ValidationGroup="UPDATE" ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Zapisz" />&nbsp;
                    <asp:LinkButton CausesValidation="false" ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" />
                </td>
            </tr>
        </EditItemTemplate>
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
                    <asp:Label ID="KeyLabel" runat="server" Text='<%# Eval("Key") %>' />
                </td>
                <td>
                    <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("Value") %>' />
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" class="dataTable" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Klucz</th>
                    <th runat="server">
                        Wartość</th>
                    <th id="Th1" runat="server">
                        &nbsp;
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
