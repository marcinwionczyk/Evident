<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="WasteCode.aspx.cs" Inherits="EVident.WasteCode1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Kody odpadów</h3>
    <span>Grupa: </span>
    <asp:EntityDataSource ID="groupDataSource" runat="server"
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="WasteCodes" 
        Select="it.[Name]" Where="it.Level = 0">
    </asp:EntityDataSource>
    <asp:DropDownList ID="groupDropDownList" runat="server" AutoPostBack="True" 
        CssClass="smallDropDownList" DataSourceID="groupDataSource" 
        DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">
        <asp:ListItem>brak</asp:ListItem>
    </asp:DropDownList>
    &nbsp;
    <span>Filtr: </span>
    <asp:TextBox ID="filterTextBox" CssClass="mediumTextBox" runat="server"></asp:TextBox>
    &nbsp;
    <asp:Button ID="filterButton" CssClass="smallButton" runat="server" Text="Filtruj" />
    <asp:EntityDataSource ID="wasteCodeDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="WasteCodes"
        EntityTypeFilter="WasteCode" OrderBy="it.Name" 
        Where="it.Level = 2 &amp;&amp;
(
CASE WHEN @GroupName == 'brak' THEN TRUE 
ELSE it.Name LIKE '' + @GroupName + '%' 
END
) 
 &amp;&amp;
(it.Name LIKE '%' + @Filter + '%' || it.Description LIKE '%' + @Filter + '%')">
        <WhereParameters>
            <asp:ControlParameter ControlID="groupDropDownList" DbType="String" 
                Name="GroupName" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="filterTextBox" 
                ConvertEmptyStringToNull="False" DbType="String" Name="Filter" 
                PropertyName="Text" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="wasteCodeListView" runat="server" DataKeyNames="Id" 
        DataSourceID="wasteCodeDataSource" EnableModelValidation="True">
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
                <td>
                    <asp:CheckBox ID="RequireDryMassCheckBox" runat="server" 
                        Checked='<%# Eval("RequireDryMass") %>' Enabled="false" />
                </td>
                <td>
                    <asp:CheckBox ID="IsBatteryCheckBox" runat="server" 
                        Checked='<%# Eval("IsBattery") %>' Enabled="false" />
                </td>
                <td>
                    <asp:CheckBox ID="IsZseieCheckBox" runat="server" 
                        Checked='<%# Eval("IsZseie") %>' Enabled="false" />
                </td>
                <td>
                    <asp:CheckBox ID="IsDangerousCheckBox" runat="server" 
                        Checked='<%# Eval("IsDangerous") %>' Enabled="false" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table class="dataTable" ID="itemPlaceholderContainer" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th style="width: 75px;" runat="server">
                        Kod</th>
                    <th runat="server">
                        Opis</th>
                    <th runat="server">
                        Sucha masa</th>
                    <th runat="server">
                        Baterie</th>
                    <th runat="server">
                        ZSEiE</th>
                    <th runat="server">
                        Niebezpieczny</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
