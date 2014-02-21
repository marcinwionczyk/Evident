<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Period.aspx.cs" Inherits="EVident.Period1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="toolkitScriptManager" runat="server">
    </asp:ToolkitScriptManager>
    <h3>Okresy rozliczeniowe</h3>
    <asp:EntityDataSource ID="periodDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="Periods" EntityTypeFilter="Period" 
        OrderBy="it.Name" onupdating="PeriodDataSourceUpdating">
    </asp:EntityDataSource>
    <asp:ListView ID="periodListView" runat="server" DataKeyNames="Id" 
        DataSourceID="periodDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NameTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
                </td>
                <td>
                    <asp:TextBox ID="DateFromTextBox" runat="server" 
                        Text='<%# Bind("DateFrom", "{0:d}") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateFromTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
                    <asp:CalendarExtender TargetControlID="DateFromTextBox" DefaultView="Years" Format="yyyy-MM-dd" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="DateToTextBox" runat="server" 
                    Text='<%# Bind("DateTo", "{0:d}") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateToTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
                    <asp:CalendarExtender TargetControlID="DateToTextBox" DefaultView="Years" Format="yyyy-MM-dd" runat="server" />
                </td>
                <td>
                    <asp:CheckBox ID="IsMainCheckBox" runat="server" Checked='<%# Bind("IsMain") %>' />
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Zapisz" ValidationGroup="UPDATE" />&nbsp;
                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" CausesValidation="false" />
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
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NameTextBox" ErrorMessage="*" ValidationGroup="INSERT" />

                </td>
                <td>
                    <asp:TextBox ID="DateFromTextBox" runat="server" 
                        Text='<%# Bind("DateFrom") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateFromTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                    <asp:CalendarExtender TargetControlID="DateFromTextBox" DefaultView="Years" Format="yyyy-MM-dd" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="DateToTextBox" runat="server" 
                    Text='<%# Bind("DateTo") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateToTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                    <asp:CalendarExtender TargetControlID="DateToTextBox" DefaultView="Years" Format="yyyy-MM-dd" runat="server" />
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Dodaj" CssClass="smallButton" ValidationGroup="INSERT" />&nbsp;
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" CssClass="smallButton" CausesValidation="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                </td>
                <td>
                    <asp:Label ID="DateFromLabel" runat="server" Text='<%# Eval("DateFrom", "{0:d}") %>' />
                </td>
                <td>
                    <asp:Label ID="DateToLabel" runat="server" Text='<%# Eval("DateTo", "{0:d}") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="IsMainCheckBox" runat="server" 
                        Checked='<%# Eval("IsMain") %>' Enabled="false" />
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Usuń"
                        OnClientClick="javascript: return DeleteSurety();" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" class="dataTable" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Nazwa</th>
                    <th runat="server">
                        Od</th>
                    <th runat="server">
                        Do</th>
                    <th runat="server">
                        Domyślny</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
