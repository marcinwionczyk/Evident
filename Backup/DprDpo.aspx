<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="DprDpo.aspx.cs" Inherits="EVident.DprDpo1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>DPR/DPO</h3>
    <asp:EntityDataSource ID="dprDpoDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="DprDpoes" EntityTypeFilter="DprDpo" 
        Where="it.Department.Id == @DepartmentId &amp;&amp;
it.Period.Id == @PeriodId" Select="" Include="Contractor" >
        <WhereParameters>
            <asp:SessionParameter DbType="Int64" Name="DepartmentId" 
                SessionField="DepartmentId" />
            <asp:SessionParameter DbType="Int64" Name="PeriodId" SessionField="PeriodId" />
        </WhereParameters>
        <InsertParameters>
            <asp:SessionParameter DbType="Int64" Name="Department.Id" 
                SessionField="DepartmentId" />
            <asp:SessionParameter DbType="Int64" Name="Period.Id" SessionField="PeriodId" />
        </InsertParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="contractorDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="Contractors" 
        EntityTypeFilter="Contractor">
    </asp:EntityDataSource>
    <asp:ListView ID="dprDpoListView" runat="server" DataKeyNames="Id" 
        DataSourceID="dprDpoDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" 
        oniteminserting="DprDpoListViewItemInserting" 
        onitemupdating="DprDpoListViewItemUpdating">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:DropDownList ID="contractorDropDownList" CssClass="mediumDropDownList" runat="server" 
                    DataSourceID="contractorDataSource" DataTextField="ShortName" DataValueField="Id" SelectedValue='<%# Eval("Contractor.Id") %>'>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="DprNumberTextBox" runat="server" CssClass="mediumTextBox"
                        Text='<%# Bind("DprNumber") %>' />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="UPDATE" ControlToValidate="DprNumberTextBox" ErrorMessage="*" />
                </td>
                <td>
                    <asp:TextBox ID="DpoNumberTextBox" CssClass="mediumTextBox" runat="server" 
                        Text='<%# Bind("DpoNumber") %>' />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="UPDATE" ControlToValidate="DpoNumberTextBox" ErrorMessage="*" />
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" ValidationGroup="UPDATE"
                        Text="Zapisz" />&nbsp;
                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" CausesValidation="false"
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
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:DropDownList ID="contractorDropDownList" CssClass="mediumDropDownList" runat="server" DataSourceID="contractorDataSource" DataTextField="ShortName" DataValueField="Id">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="DprNumberTextBox" runat="server" CssClass="mediumTextBox"
                        Text='<%# Bind("DprNumber") %>' />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="INSERT" ControlToValidate="DprNumberTextBox" ErrorMessage="*" />
                </td>
                <td>
                    <asp:TextBox ID="DpoNumberTextBox" runat="server" CssClass="mediumTextBox"
                        Text='<%# Bind("DpoNumber") %>' />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="INSERT" ControlToValidate="DpoNumberTextBox" ErrorMessage="*" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" ValidationGroup="INSERT" CssClass="smallButton" runat="server" CommandName="Insert" 
                        Text="Dodaj" />
                    <asp:Button CausesValidation="false" ID="CancelButton" CssClass="smallButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="ContractorLabel" runat="server" 
                        Text='<%# Eval("Contractor.ShortName") %>' />
                </td>
                <td>
                    <asp:Label ID="DprNumberLabel" runat="server" Text='<%# Eval("DprNumber") %>' />
                </td>
                <td>
                    <asp:Label ID="DpoNumberLabel" runat="server" Text='<%# Eval("DpoNumber") %>' />
                </td>
                <td>
                    <span style="display: inline-block; width: 30%;">
                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Usuń" OnClientClick="javascript:return DeleteSurety();" />
                    </span>
                    <span style="display: inline-block; width: 65%; text-align: right;" runat="server">
                        <img alt="" src="./Graphic/GoTo.png" style="vertical-align: middle;" />
                        <asp:HyperLink ID="dprDpoElementLink" runat="server" Text="Szczegóły >>>"
                        NavigateUrl='<%# "./DprDpoElement.aspx?Id=" + Eval("Id") %>' />
                    </span>
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" class="dataTable" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Klient
                    </th>
                    <th runat="server">
                        DPR</th>
                    <th runat="server">
                        DPO</th>
                    <th>&nbsp;</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
