<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Recycling.aspx.cs" Inherits="EVident.Recycling" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register TagPrefix="usr" Namespace="EVident.UserControl" Assembly="EVident" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server" 
        EnableScriptLocalization="True" EnableScriptGlobalization="True"/>
    <h3>Odzysk</h3>
    <h4>Kod odpadu:  <asp:Label runat="server" ID="wasteCodeLiteral"/></h4><br />
    <asp:EntityDataSource ID="recyclingDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteRecordCardElements" 
        Where="it.WasteRecordCard.Id == @WasteRecordCardId &amp;&amp;
it.Kind == 6" Include="ProcessingMethod,Installation">
        <WhereParameters>
            <asp:QueryStringParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="WasteRecordCardId" QueryStringField="WasteRecordCardId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="processingMethodDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
        EntityTypeFilter="ProcessingMethod" Where="it.Kind = 0" 
        OrderBy="Length(it.Name), Right(it.Name, Length(it.Name) - 1)" Select="">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="installationDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="Installations" 
        EntityTypeFilter="Installation" OrderBy="it.Name" Select="it.[Name], it.[Id]" 
        Where="it.Department.Id == @DepartmentId">
        <WhereParameters>
            <asp:SessionParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="DepartmentId" SessionField="DepartmentId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="listView" runat="server" DataKeyNames="Id" 
        DataSourceID="recyclingDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" onprerender="ListViewPreRender" 
        oniteminserting="ListViewItemInserting" 
        onitemupdating="ListViewItemUpdating">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' CssClass="verySmallTextBox" />
                    <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="ManageMassTextBox" runat="server" 
                        Text='<%# Bind("ManageMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ManageMassTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="UPDATE" ControlToValidate="ManageMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="ManageDryMassTextBox" runat="server"
                        Text='<%# Bind("ManageDryMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ID="ManageDryMassRequiredFieldValidator" 
                        ControlToValidate="ManageDryMassTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="ManageDryMassRegularExpressionValidator" 
                        Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="UPDATE" ControlToValidate="ManageDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <usr:DropDownListExtended ID="ProcessingMethodDropDownList" runat="server" 
                       DataSourceID="processingMethodDataSource" DataTextField="Name" DataValueField="Id" 
                       CssClass="verySmallDropDownList" SelectedValue='<%# Eval("ProcessingMethod.Id") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ManageLpTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Eval("ManageLp") %>' />
                    <asp:RequiredFieldValidator ID="ManageLpRequiredFieldValidator" runat="server" ControlToValidate="ManageLpTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox ID="InInstallationCheckBox" runat="server" Checked='<%# Eval("Installation") != null %>' AutoPostBack="true" />
                </td>
                <td>
                    <usr:DropDownListExtended ID="InstallationDropDownList" runat="server" CssClass="mediumDropDownList"
                        DataSourceID="installationDataSource" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Eval("Installation.Id") %>' />
                    <asp:RequiredFieldValidator ID="InstallationRequiredFieldValidator" runat="server" 
                        ControlToValidate="InstallationDropDownList" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie wybrano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="PartNumberTextBox" runat="server" CssClass="verySmallTextBox" />
                     <asp:RequiredFieldValidator ID="PartNumberRequiredFieldValidator" runat="server" 
                        ControlToValidate="PartNumberTextBox"
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Zapisz" ValidationGroup="UPDATE" />&nbsp;
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
                    <asp:TextBox ID="ManageMassTextBox" runat="server" 
                        Text='<%# Bind("ManageMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ManageMassTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="INSERT" ControlToValidate="ManageMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="ManageDryMassTextBox" runat="server"
                        Text='<%# Bind("ManageDryMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ID="ManageDryMassRequiredFieldValidator" 
                        ControlToValidate="ManageDryMassTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="ManageDryMassRegularExpressionValidator" 
                        Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="INSERT" ControlToValidate="ManageDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:DropDownList ID="ProcessingMethodDropDownList" runat="server" 
                       DataSourceID="processingMethodDataSource" DataTextField="Name" DataValueField="Id" 
                       CssClass="verySmallDropDownList" />
                </td>
                <td>
                    <asp:TextBox ID="ManageLpTextBox" runat="server" CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator ID="ManageLpRequiredFieldValidator" runat="server" ControlToValidate="ManageLpTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox ID="InInstallationCheckBox" runat="server" AutoPostBack="true" />
                </td>
                <td>
                    <asp:DropDownList ID="InstallationDropDownList" runat="server" CssClass="mediumDropDownList"
                        DataSourceID="installationDataSource" DataTextField="Name" DataValueField="Id" />
                    <asp:RequiredFieldValidator ID="InstallationRequiredFieldValidator" runat="server" 
                        ControlToValidate="InstallationDropDownList" 
                        ValidationGroup="INSERT" ErrorMessage="* nie wybrano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="PartNumberTextBox" runat="server" CssClass="verySmallTextBox" />
                     <asp:RequiredFieldValidator ID="PartNumberRequiredFieldValidator" runat="server" 
                        ControlToValidate="PartNumberTextBox"
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Dodaj" ValidationGroup="INSERT" CssClass="smallButton" />&nbsp;
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
                    <asp:Label ID="ManageMassLabel" runat="server" 
                        Text='<%# Eval("ManageMass") %>' />
                </td>
                <td>
                    <asp:Label ID="ManageDryMassLabel" runat="server" 
                        Text='<%# Double.Parse(Eval("ManageDryMass") + "") != 0 ? Eval("ManageDryMass") : "---" %>' />
                </td>
                <td>
                    <asp:Label ID="ProcessingMethodLabel" runat="server" 
                        Text='<%# Eval("ProcessingMethod.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="ManageLpLabel" runat="server" Text='<%# Eval("ManageLp") != null ? Eval("ManageLp") : "---" %>' />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox ID="inInstallationCheckBox" runat="server" Checked='<%# Eval("Installation") != null %>' Enabled="false" />
                </td>
                <td>
                    <asp:Label ID="InstallationLabel" runat="server" 
                        Text='<%# Eval("Installation") != null ? Eval("Installation.Name") : "---" %>' />
                </td>
                <td>
                    <asp:Label ID="PartNumberLabel" runat="server" 
                        Text='<%# Eval("PartNumber") != null ? Eval("PartNumber") : "---" %>' />
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
                        Metoda odzysku</th>
                    <th>
                        Lp.</th>
                    <th>
                        Odzysk w instalacji?</th>
                    <th runat="server">
                        Instalacja</th>
                    <th runat="server">
                        Nr partii</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
