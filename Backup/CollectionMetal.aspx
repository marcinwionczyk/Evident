<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="CollectionMetal.aspx.cs" Inherits="EVident.CollectionMetal" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
             Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="bodyPlaceHolder" ID="Content2">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server" 
        EnableScriptGlobalization="True" EnableScriptLocalization="True"/>
    <h3>Przyjęcie metali</h3>
    <h4>Kod odpadu:  <asp:Literal runat="server" ID="wasteCodeLiteral" /></h4><br />
    <asp:EntityDataSource ID="collectionMetalDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteRecordCardElements" 
        Where="it.WasteRecordCard.Id == @WasteRecordCardId &amp;&amp;
it.Kind == 5">
        <WhereParameters>
            <asp:QueryStringParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="WasteRecordCardId" QueryStringField="WasteRecordCardId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="listView" runat="server" DataKeyNames="Id" 
        DataSourceID="collectionMetalDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" oniteminserting="ListViewItemInserting" 
        onitemcreated="ListViewItemCreated">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' CssClass="verySmallTextBox" />
                    <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="ReceivedMassTextBox" runat="server" 
                        Text='<%# Bind("ReceivedMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ReceivedMassTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="UPDATE" ControlToValidate="receivedMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="ReceivedCardNumberTextBox" runat="server" 
                        Text='<%# Bind("ReceivedCardNumber") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ReceivedCardNumberTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NameTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="PESELTextBox" runat="server" Text='<%# Bind("PESEL") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="PESELTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="DocIDTextBox" runat="server" Text='<%# Bind("DocID") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DocIDTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox TextMode="MultiLine" Width="215px" Height="50px" ID="CompanyNameTextBox" runat="server" 
                        Text='<%# Bind("CompanyName") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CompanyNameTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="SourceTextBox" runat="server" Text='<%# Bind("Source") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="SourceTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="SourceKindTextBox" runat="server" Text='<%# Bind("SourceKind") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="SourceKindTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="AddrLineATextBox" runat="server" 
                        Text='<%# Bind("AddrLineA") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="AddrLineATextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="AddrLineBTextBox" runat="server" 
                        Text='<%# Bind("AddrLineB") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="AddrLineBTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Zapisz" ValidationGroup="UPDATE" />
                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" CausesValidation="false" />
                </td>
            </tr>
        </EditItemTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' CssClass="verySmallTextBox" />
                    <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="ReceivedMassTextBox" runat="server" 
                        Text='<%# Bind("ReceivedMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ReceivedMassTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="INSERT" ControlToValidate="receivedMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="ReceivedCardNumberTextBox" runat="server" 
                        Text='<%# Bind("ReceivedCardNumber") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ReceivedCardNumberTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NameTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="PESELTextBox" runat="server" Text='<%# Bind("PESEL") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="PESELTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="DocIDTextBox" runat="server" Text='<%# Bind("DocID") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DocIDTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox TextMode="MultiLine" Width="215px" Height="50px" ID="CompanyNameTextBox" runat="server" 
                        Text='<%# Bind("CompanyName") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CompanyNameTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="SourceTextBox" runat="server" Text='<%# Bind("Source") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="SourceTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="SourceKindTextBox" runat="server" Text='<%# Bind("SourceKind") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="SourceKindTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="AddrLineATextBox" runat="server" 
                        Text='<%# Bind("AddrLineA") %>' CssClass="smallTextBox" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="AddrLineATextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:TextBox ID="AddrLineBTextBox" runat="server" 
                        Text='<%# Bind("AddrLineB") %>' CssClass="smallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="AddrLineBTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Dodaj" CssClass="smallButton" ValidationGroup="INSERT" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Anuluj" CssClass="smallButton" CausesValidation="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date", "{0:d}") %>' />
                </td>
                <td>
                    <asp:Label ID="ReceivedMassLabel" runat="server" 
                        Text='<%# Eval("ReceivedMass") %>' />
                </td>
                <td>
                    <asp:Label ID="ReceivedCardNumberLabel" runat="server" 
                        Text='<%# Eval("ReceivedCardNumber") %>' />
                </td>
                <td>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />/<br />
                    <asp:Label ID="PESELLabel" runat="server" Text='<%# Eval("PESEL") %>' />/<br />
                    <asp:Label ID="DocIDLabel" runat="server" Text='<%# Eval("DocID") %>' />
                </td>
                <td>
                    <asp:Label ID="CompanyNameLabel" runat="server" 
                        Text='<%# (Eval("CompanyName") + "").Replace("\n", "<br />") %>' />
                </td>
                <td>
                    <asp:Label ID="SourceLabel" runat="server" Text='<%# Eval("Source") %>' />/<br />
                    <asp:Label ID="SourceKindLabel" runat="server" Text='<%# Eval("SourceKind") %>' />
                </td>
                <td>
                    <asp:Label ID="AddrLineALabel" runat="server" Text='<%# Eval("AddrLineA") %>' />/<br />
                    <asp:Label ID="AddrLineBLabel" runat="server" Text='<%# Eval("AddrLineB") %>' />
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Usuń" OnClientClick="javascript: return DeleteSurety();" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" runat="server" border="0" style="" class="dataTable">
                <tr runat="server" style="">
                    <th runat="server">
                        Data</th>
                    <th runat="server">
                        Masa [Mg]</th>
                    <th runat="server">
                        Nr formularza</th>
                    <th runat="server">
                        Imię i nazwisko/<br />PESEL/<br />Nr dok. tożsamości</th>
                    <th runat="server">
                        Nazwa i adres firmy przekazującej</th>
                    <th runat="server">
                        Źródło pochodzenia/<br />Rodzaj produktu źródłowego</th>
                    <th runat="server">
                        Ulica i nr/<br />Kod pocztowy i miasto</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>