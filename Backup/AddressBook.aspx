<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="AddressBook.aspx.cs" Inherits="EVident.AddressBook1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
<h3>Książka adresowa</h3>
    <asp:EntityDataSource ID="addressBookDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="AddressBooks" 
        EntityTypeFilter="AddressBook" OrderBy="it.Kind, it.Name" 
        Where="it.Kind = @Kind &amp;&amp;
(
it.Name LIKE '%' + @Filter + '%' ||
it.PostCode LIKE '%' + @Filter + '%' ||
it.Street LIKE '%' + @Filter + '%' ||
it.City LIKE '%' + @Filter + '%' ||
it.Fax LIKE '%' + @Filter + '%' ||
it.Phone LIKE '%' + @Filter + '%' ||
it.HomeSite LIKE '%' + @Filter + '%' ||
it.Email LIKE '%' + @Filter + '%'
)" Select="">
        <WhereParameters>
            <asp:ControlParameter ControlID="groupDropDownList" DbType="Int32" Name="Kind" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="filterTextBox" DbType="String" Name="Filter" 
                PropertyName="Text" ConvertEmptyStringToNull="False" />
        </WhereParameters>
    </asp:EntityDataSource>
    <span>Grupa: </span>
    <asp:DropDownList AutoPostBack="true" CssClass="smallDropDownList" ID="groupDropDownList" runat="server">
        <asp:ListItem Value="2">W.I.O.Ś.</asp:ListItem>
        <asp:ListItem Value="1">R.D.O.Ś.</asp:ListItem>
        <asp:ListItem Value="3">U.M.</asp:ListItem>
    </asp:DropDownList>
    &nbsp;
    <span>Filtr: </span>
    <asp:TextBox CssClass="mediumTextBox" ID="filterTextBox" runat="server"></asp:TextBox>
    &nbsp;
    <asp:Button CssClass="smallButton" runat="server" Text="Filtruj" />
    <asp:ListView ID="groupListView" runat="server" DataKeyNames="Id" 
        DataSourceID="addressBookDataSource" EnableModelValidation="True">
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
                    <asp:Label ID="StreetLabel" runat="server" Text='<%# Eval("Street") %>' />
                </td>
                <td>
                    <asp:Label ID="PostCodeLabel" runat="server" Text='<%# Eval("PostCode") %>' />
                </td>
                <td>
                    <asp:Label ID="CityLabel" runat="server" Text='<%# Eval("City") %>' />
                </td>
                <td>
                    <asp:Label ID="FaxLabel" runat="server" Text='<%# Eval("Fax") %>' />
                </td>
                <td>
                    <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone") %>' />
                </td>
                <td>
                    <asp:Label ID="HomeSiteLabel" runat="server" Text='<%# Eval("HomeSite") %>' />
                </td>
                <td>
                    <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
                        <table ID="itemPlaceholderContainer" runat="server" border="0" style="" class="dataTable">
                            <tr runat="server" style="">
                                <th id="Th1" runat="server">
                                    Nazwa</th>
                                <th runat="server">
                                    Ulica</th>
                                <th runat="server">
                                    Kod pocztowy</th>
                                <th runat="server">
                                    Miasto</th>
                                <th runat="server">
                                    Fax</th>
                                <th runat="server">
                                    Telefon</th>
                                <th runat="server">
                                    WWW</th>
                                <th runat="server">
                                    E-Mail</th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
        </LayoutTemplate>
    </asp:ListView>

</asp:Content>
