<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="_Company.aspx.cs" Inherits="EVident._Company" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Lista zarejestrowanych firm</h3>
    <asp:EntityDataSource ID="companyDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="Companies" EntityTypeFilter="Company" 
        OrderBy="it.FullName" oninserted="CompanyDataSourceInserted">
    </asp:EntityDataSource>
    <asp:ListView ID="companyListView" runat="server" DataKeyNames="Id" 
        DataSourceID="companyDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" 
        oniteminserting="CompanyListViewItemInserting" 
        onitemupdating="CompanyListViewItemUpdating">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="LoginTextBox" runat="server" Text='<%# Bind("Login") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="LoginTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
                </td>
                <td>
                    <asp:TextBox ID="PasswordHashTextBox" runat="server" Text="" TextMode="Password" CssClass="smallTextBox" />
                </td>
                <td>
                    <asp:TextBox ID="FullNameTextBox" runat="server" 
                        Text='<%# Bind("FullName") %>' CssClass="mediumTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="FullNameTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
                </td>
                <td>
                    <asp:TextBox ID="ShortNameTextBox" runat="server" 
                        Text='<%# Bind("ShortName") %>' CssClass="mediumTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ShortNameTextBox" ErrorMessage="*" ValidationGroup="UPDATE" />
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
                    <asp:TextBox ID="LoginTextBox" CssClass="smallTextBox" runat="server" Text='<%# Bind("Login") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="LoginTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:TextBox ID="PasswordHashTextBox" runat="server" CssClass="smallTextBox" 
                        Text="" TextMode="Password" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="PasswordHashTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:TextBox ID="FullNameTextBox" CssClass="mediumTextBox" runat="server" 
                        Text='<%# Bind("FullName") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="FullNameTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:TextBox ID="ShortNameTextBox" runat="server" CssClass="mediumTextBox" 
                        Text='<%# Bind("ShortName") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ShortNameTextBox" ErrorMessage="*" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" CssCLass="smallButton"
                        Text="Dodaj" ValidationGroup="INSERT" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="smallButton"
                        Text="Anuluj" CausesValidation="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="LoginLabel" runat="server" Text='<%# Eval("Login") %>' />
                </td>
                <td>
                    <asp:Label ID="PasswordHashLabel" runat="server" Text="**********" />
                </td>
                <td>
                    <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                </td>
                <td>
                    <asp:Label ID="ShortNameLabel" runat="server" Text='<%# Eval("ShortName") %>' />
                </td>
                <td>
                    <span style="display: inline-block; width: 30%;">
                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Usuń" OnClientClick="javascript: return DeleteSurety();"  />
                    </span>
                    <span style="display: inline-block; width: 65%; text-align: right;" runat="server">
                    <img alt="" src="./Graphic/GoTo.png" style="vertical-align: middle;" />
                    <asp:HyperLink ID="companyRightLink" runat="server" Text="Uprawnienia >>>"
                        NavigateUrl='<%# "./_CompanyRight.aspx?Id=" + Eval("Id") %>' />
                    </span>
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table class="dataTable" ID="itemPlaceholderContainer" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Login</th>
                    <th runat="server">
                        Hasło</th>
                    <th runat="server">
                        Nazwa pełna</th>
                    <th runat="server">
                        Nazwa skrócona</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
