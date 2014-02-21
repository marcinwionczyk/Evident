<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Transfer.aspx.cs" Inherits="EVident.Transfer" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register TagPrefix="usr" Namespace="EVident.UserControl" Assembly="EVident" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager" runat="server" 
        EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </asp:ToolkitScriptManager>
    <asp:HiddenField ID="wasteTransferCardIdHiddenField" runat="server" />
    <h3>Przekazanie odpadu</h3>
    <h4>Kod odpadu:  <asp:Literal runat="server" ID="wasteCodeLiteral" /></h4><br />
    <asp:EntityDataSource ID="kpoDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteTransferCards" 
        EntityTypeFilter="WasteTransferCard" OrderBy="" 
        Where="!it.IsCollection &amp;&amp; 
it.WasteRecordCard.Id == @WasteRecordCardId 
&amp;&amp; it.Kind == -8" 
        Include="Contractor,TransportContractor,WasteRecordCardElements" Select="">
        <WhereParameters>
            <asp:QueryStringParameter DbType="Int64" Name="WasteRecordCardId" 
                QueryStringField="WasteRecordCardId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="contractorDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="Contractors" 
        OrderBy="it.ShortName" Select="it.[ShortName], it.[Id]" 
        Where="it.Company.Id == @CompanyId" EntityTypeFilter="">
        <WhereParameters>
            <asp:SessionParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="CompanyId" SessionField="CompanyId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="wasteRecordCardElementDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteRecordCardElements" 
        EntityTypeFilter="WasteRecordCardElement" Select="" 
        Where="it.WasteTransferCard.Id == @WasteTransferCardId">
        <WhereParameters>
            <asp:ControlParameter ControlID="wasteTransferCardIdHiddenField" 
                Name="WasteTransferCardId" DbType="Int64" PropertyName="Value" />
        </WhereParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="wasteTransferCardIdHiddenField" 
                Name="WasteTransferCard.Id" DbType="Int64" PropertyName="Value" />
            <asp:QueryStringParameter DbType="Int64" Name="WasteRecordCard.Id" 
                QueryStringField="WasteRecordCardId" />
        </InsertParameters>
    </asp:EntityDataSource>
    <asp:Panel ID="kpoPanel" CssClass="panel" GroupingText="Karty przekazania odpadów" runat="server">
        <asp:ListView ID="kpoListView" runat="server" DataKeyNames="Id" 
            DataSourceID="kpoDataSource" EnableModelValidation="True" 
            InsertItemPosition="FirstItem" oniteminserting="KpoListViewItemInserting" 
            onprerender="KpoListViewPreRender" 
            onselectedindexchanged="KpoListViewSelectedIndexChanged" 
            onitemupdating="KPOListViewItemUpdating">
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <usr:DropDownListExtended ID="ContractorDropDownList" runat="server" 
                            CssClass="smallDropDownList" DataSourceID="contractorDataSource"
                            DataTextField="ShortName" DataValueField="Id" SelectedValue='<%# Bind("Contractor.Id") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ContractorDropDownList" 
                            ErrorMessage="* nie wybrano wartości" ValidationGroup="UPDATE" Display="Dynamic" />
                    </td>
                    <td>
                        <usr:DropDownListExtended ID="TransportKindDropDownList" runat="server" 
                            CssClass="smallDropDownList" AutoPostBack="true" SelectedValue='<%# Bind("TransportKind") %>'>
                            <asp:ListItem Value="0">własny</asp:ListItem>
                            <asp:ListItem Value="1">odbiorcy</asp:ListItem>
                            <asp:ListItem Value="2">firma zewnętrzna</asp:ListItem>
                        </usr:DropDownListExtended>
                    </td>
                    <td>
                        <usr:DropDownListExtended ID="TransportContractorDropDownList" runat="server" 
                            CssClass="smallDropDownList" DataSourceID="contractorDataSource"
                            DataTextField="ShortName" DataValueField="Id" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransportContractorDropDownList" 
                            ErrorMessage="* nie wybrano wartości" ValidationGroup="UPDATE" Display="Dynamic" /> 
                    </td>
                    <td>
                        <asp:TextBox ID="TransportVehicleNumberTextBox" runat="server" CssClass="smallTextBox"
                            Text='<%# Bind("TransportVehicleNumber") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransportVehicleNumberTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="UPDATE" Display="Dynamic" />
                    </td>
                    <td style="text-align: center;">
                        <asp:CheckBox ID="DPOrequiredCheckBox" runat="server" Checked='<%# Bind("DPOrequired") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferCardNumberTextBox" runat="server" 
                            Text='<%# Bind("TransferCardNumber") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransferCardNumberTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="UPDATE" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:TextBox ID="WasteDestinationTextBox" runat="server" 
                            Text='<%# Bind("WasteDestination") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="WasteDestinationTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="UPDATE" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="Zapisz" ValidationGroup="UPDATE" />
                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Anuluj" CausesValidation="false"  />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:DropDownList ID="ContractorDropDownList" runat="server" 
                            CssClass="smallDropDownList" DataSourceID="contractorDataSource"
                            DataTextField="ShortName" DataValueField="Id" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ContractorDropDownList" 
                            ErrorMessage="* nie wybrano wartości" ValidationGroup="INSERT" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:DropDownList ID="TransportKindDropDownList" runat="server" 
                            CssClass="smallDropDownList" AutoPostBack="true">
                            <asp:ListItem Value="0">własny</asp:ListItem>
                            <asp:ListItem Value="1">odbiorcy</asp:ListItem>
                            <asp:ListItem Value="2">firma zewnętrzna</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="TransportContractorDropDownList" runat="server" 
                            CssClass="smallDropDownList" DataSourceID="contractorDataSource"
                            DataTextField="ShortName" DataValueField="Id" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransportContractorDropDownList" 
                            ErrorMessage="* nie wybrano wartości" ValidationGroup="INSERT" Display="Dynamic" /> 
                    </td>
                    <td>
                        <asp:TextBox ID="TransportVehicleNumberTextBox" runat="server" CssClass="smallTextBox"
                            Text='<%# Bind("TransportVehicleNumber") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransportVehicleNumberTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="INSERT" Display="Dynamic" />
                    </td>
                    <td style="text-align: center;">
                        <asp:CheckBox ID="DPOrequiredCheckBox" runat="server" Checked='<%# Bind("DPOrequired") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferCardNumberTextBox" runat="server" 
                            Text='<%# Bind("TransferCardNumber") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransferCardNumberTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="INSERT" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:TextBox ID="WasteDestinationTextBox" runat="server" 
                            Text='<%# Bind("WasteDestination") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="WasteDestinationTextBox" 
                            ErrorMessage="* nie podano wartości" ValidationGroup="INSERT" Display="Dynamic" />
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
                        <asp:Label ID="ContractorLabel" runat="server" 
                            Text='<%# Eval("Contractor.ShortName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportKindLabel" runat="server" 
                            Text='<%# (Eval("TransportKind") + "") == "0" ? "własny" : ((Eval("TransportKind") + "") == "1" ? "odbierającego" : "firma zewnętrzna") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportContractorLabel" runat="server" 
                            Text='<%# Eval("TransportContractor") != null ? Eval("TransportContractor.ShortName") : "---" %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportVehicleNumber" runat="server" 
                            Text='<%# Eval("TransportVehicleNumber") %>' />
                    </td>
                    <td style="text-align: center;">
                        <asp:CheckBox ID="DPOrequiredCheckBox" runat="server" 
                            Checked='<%# Eval("DPOrequired") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="TransferCardNumberLabel" runat="server" 
                            Text='<%# Eval("TransferCardNumber") %>' />
                    </td>
                    <td>
                        <asp:Label ID="WasteDestinationLabel" runat="server" 
                            Text='<%# Eval("WasteDestination") %>' />
                    </td>
                    <td>
                        <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" Text="Wybierz" />&nbsp;
                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Usuń" OnClientClick="javascript: return DeleteSurety();" />
                    </td>
                </tr>
            </ItemTemplate>
            <SelectedItemTemplate>
                <tr class="selected">
                    <td>
                        <asp:Label ID="ContractorLabel" runat="server" 
                            Text='<%# Eval("Contractor.ShortName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportKindLabel" runat="server" 
                            Text='<%# (Eval("TransportKind") + "") == "0" ? "własny" : ((Eval("TransportKind") + "") == "1" ? "odbierającego" : "firma zewnętrzna") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportContractorLabel" runat="server" 
                            Text='<%# Eval("TransportContractor") != null ? Eval("TransportContractor.ShortName") : "---" %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransportVehicleNumber" runat="server" 
                            Text='<%# Eval("TransportVehicleNumber") %>' />
                    </td>
                    <td style="text-align: center;">
                        <asp:CheckBox ID="DPOrequiredCheckBox" runat="server" 
                            Checked='<%# Eval("DPOrequired") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="TransferCardNumberLabel" runat="server" 
                            Text='<%# Eval("TransferCardNumber") %>' />
                    </td>
                    <td>
                        <asp:Label ID="WasteDestinationLabel" runat="server" 
                            Text='<%# Eval("WasteDestination") %>' />
                    </td>
                    <td>
                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Usuń" OnClientClick="javascript: return DeleteSurety();" />
                    </td>
                </tr>
            </SelectedItemTemplate>
            <LayoutTemplate>
                <table ID="itemPlaceholderContainer" runat="server" border="0" style="" class="dataTable">
                    <tr runat="server" style="">
                        <th runat="server">
                            Kontrahent</th>
                        <th runat="server">
                            Sposób transportu</th>
                        <th runat="server">
                            Firma transportowa</th>
                        <th>
                            Nr rejestracyjny pojazdu</th>
                        <th runat="server">
                            Wnioskuję o wydanie DPR/DPO?</th>
                        <th runat="server">
                            Nr karty</th>
                        <th runat="server">
                            Miejsce przeznaczenia</th>
                        <th runat="server">
                        </th>
                    </tr>
                    <tr runat="server" ID="itemPlaceholder"></tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </asp:Panel>
    <asp:Panel ID="transferPanel" CssClass="panel" GroupingText="Przekazane odpady" runat="server">
        <asp:ListView ID="wasteRecordCardElementListView" runat="server" DataKeyNames="Id" 
            DataSourceID="wasteRecordCardElementDataSource" EnableModelValidation="True" 
            InsertItemPosition="FirstItem" 
            onprerender="WasteRecordCardElementListViewPreRender" 
            oniteminserting="WasteRecordCardElementListViewItemInserting">
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date", "{0:d}") %>' CssClass="smallTextBox" />
                        <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                            ValidationGroup="UPDATE_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferMassTextBox" runat="server" 
                            Text='<%# Bind("TransferMass") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransferMassTextBox" 
                            ValidationGroup="UPDATE_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                        <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                        ValidationGroup="UPDATE_2ND" ControlToValidate="TransferMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferDryMassTextBox" runat="server" 
                            Text='<%# Bind("TransferDryMass") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ID="TransferDryMassRequiredFieldValidator"
                            ControlToValidate="TransferDryMassTextBox" 
                            ValidationGroup="UPDATE_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="TransferDryMassRegularExpressionValidator" 
                            Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                        ValidationGroup="UPDATE_2ND" ControlToValidate="TransferDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                    </td>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="Zapisz" ValidationGroup="UPDATE_2ND" />&nbsp;
                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Anuluj" CausesValidation="false" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date", "{0:d}") %>' CssClass="smallTextBox" />
                        <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                            ValidationGroup="INSERT_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferMassTextBox" runat="server" 
                            Text='<%# Bind("TransferMass") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TransferMassTextBox" 
                            ValidationGroup="INSERT_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                        <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                        ValidationGroup="INSERT_2ND" ControlToValidate="TransferMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="TransferDryMassTextBox" runat="server" 
                            Text='<%# Bind("TransferDryMass") %>' CssClass="smallTextBox" />
                        <asp:RequiredFieldValidator runat="server" ID="TransferDryMassRequiredFieldValidator"
                            ControlToValidate="TransferDryMassTextBox" 
                            ValidationGroup="INSERT_2ND" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="TransferDryMassRegularExpressionValidator" 
                            Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                        ValidationGroup="INSERT_2ND" ControlToValidate="TransferDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                    </td>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert"
                            Text="Dodaj" ValidationGroup="INSERT_2ND" CssClass="smallButton" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Anuluj" CausesValidation="false" CssClass="smallButton" />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date", "{0:d}") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransferMassLabel" runat="server" 
                            Text='<%# Eval("TransferMass") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TransferDryMassLabel" runat="server" 
                            Text='<%# Double.Parse(Eval("TransferDryMass") + "") != 0 ? Eval("TransferDryMass") : "---" %>' />
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
                            Masa całkowita</th>
                        <th runat="server">
                            Masa sucha</th>
                        <th runat="server">
                        </th>
                    </tr>
                    <tr ID="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </asp:Panel>
</asp:Content>
