<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="WasteRecordCard.aspx.cs" Inherits="EVident.WasteRecordCard1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:HiddenField ID="cardCurrentNumber" runat="server" Value="" />
    <h3>Karty ewidencji odpadów <asp:Literal ID="tipLiteral" runat="server" /></h3>
    <asp:Label ID="duplicatedWasteCodeLabel" runat="server" Visible="False" 
        Text="Karta dla wybranego kodu odpadu już istnieje." CssClass="error" 
        EnableViewState="False"></asp:Label>
    <asp:EntityDataSource ID="wasteRecordCardDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteRecordCards" 
        EntityTypeFilter="WasteRecordCard" OrderBy="it.Number" Select="" Where="it.Department.Id = @DepartmentId &amp;&amp;
it.Period.Id = @PeriodId" Include="WasteCode">
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
    <asp:EntityDataSource ID="wasteCodeDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="WasteCodes" 
        EntityTypeFilter="WasteCode" OrderBy="it.Name" Select="it.[Id], it.[Name]" 
        Where="it.Level = 2">
    </asp:EntityDataSource>
    <asp:ListView ID="wasteRecordCardListView" runat="server" DataKeyNames="Id" 
        DataSourceID="wasteRecordCardDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" 
        oniteminserting="WasteRecordCardListViewItemInserting" 
        onitemcreated="WasteRecordCardListViewItemCreated">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox CssClass="mediumTextBox" ID="NumberTextBox" runat="server" Text='<%# Bind("Number") %>' />
                    <asp:RequiredFieldValidator ValidationGroup="UPDATE" runat="server" ControlToValidate="NumberTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Label ID="wasteCodeLabel" runat="server" Text='<%# Eval("WasteCode.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="WasteDescriptionLabel" runat="server" 
                        Text='<%# Eval("WasteCode.Description") %>' />
                </td>
                <td>
                    <asp:LinkButton ValidationGroup="UPDATE" ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Zapisz" />&nbsp;
                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                        CausesValidation="false" Text="Anuluj" />
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
                    <asp:TextBox CssClass="mediumTextBox" ID="numberTextBox" runat="server" Text='<%# Bind("Number") %>' />
                    <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="INSERT" runat="server" ControlToValidate="NumberTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:DropDownList CssClass="smallDropDownList" ID="wasteCodeDropDownList" runat="server" 
                        DataSourceID="wasteCodeDataSource" DataTextField="Name" DataValueField="Id" 
                        AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="wasteCodeDescriptionLabel" runat="server" 
                        Text="" />
                </td>
                <td>
                    <asp:Button CssClass="smallButton" ID="InsertButton" runat="server" CommandName="Insert" 
                        ValidationGroup="INSERT" Text="Dodaj" />
                    <asp:Button CssClass="smallButton" ID="CancelButton" runat="server" CommandName="Cancel" 
                        CausesValidation="false" Text="Anuluj" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="NumberLabel" runat="server" Text='<%# Eval("Number") %>' />
                </td>
                <td>
                    <asp:Label ID="WasteCodeLabel" runat="server" 
                        Text='<%# Eval("WasteCode.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="WasteDescriptionLabel" runat="server" 
                        Text='<%# Eval("WasteCode.Description") %>' />                    
                </td>
                <td>
                    <span style="display: inline-block; width: 30%;">
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />
                    &nbsp;
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Usuń" OnClientClick="javascript:return DeleteSurety();" />
                    </span>
                    <span style="display: inline-block; width: 65%; text-align: right;" runat="server" 
                        visible='<%# !String.IsNullOrEmpty(Request["Kind"]) %>'>
                    <img alt="" src="./Graphic/GoTo.png" style="vertical-align: middle;" />
                    <asp:HyperLink ID="wasteRecordCardElementLink" runat="server" Text="Przejdź do karty >>>"
                    NavigateUrl='<%# "./WasteRecordCardElement.aspx?Id=" + Eval("Id") + "&Kind=" + Request["Kind"] %>' />
                    </span>
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>    
            <table class="dataTable" ID="itemPlaceholderContainer" runat="server" border="0">
                <tr runat="server" style="">
                    <th runat="server">
                        Numer karty</th>
                    <th runat="server">
                        Kod odpadów</th>
                    <th runat="server">
                        Rodzaj odpadów                  
                    </th>
                    <th style="width: 350px;" id="Th1" runat="server">
                    &nbsp;
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
