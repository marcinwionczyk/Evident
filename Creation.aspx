<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Creation.aspx.cs" Inherits="EVident.Creation" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register src="UserControl/CommuneSelector.ascx" tagname="CommuneSelector" tagprefix="uc1" %>
<%@ Register TagPrefix="usr" Namespace="EVident.UserControl" Assembly="EVident" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script type="text/javascript" src="./JavaScript.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server" 
        EnableScriptLocalization="True" EnableScriptGlobalization="True" />
    <h3>Wytworzenie</h3>
    <h4>Kod odpadu:  <asp:Label runat="server" ID="wasteCodeLiteral"/></h4><br />
    <asp:EntityDataSource ID="creationDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="WasteRecordCardElements" 
        Where="it.WasteRecordCard.Id == @WasteRecordCardId &amp;&amp;
it.Kind == 1" Include="PgoCommune,PgoContractor">
        <WhereParameters>
            <asp:QueryStringParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="WasteRecordCardId" QueryStringField="WasteRecordCardId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="partNumberDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="WasteRecordCardElements" 
        OrderBy="it.PartNumber" Select="it.[PartNumber]" 
        Where="it.PartNumber IS NOT NULL &amp;&amp; it.WasteRecordCard.Department.Id == @DepartmentId &amp;&amp;
(it.Kind == 6 || it.Kind == -7)" EntityTypeFilter="">
        <WhereParameters>
            <asp:SessionParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="DepartmentId" SessionField="DepartmentId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="contractorDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="Contractors" 
        EntityTypeFilter="Contractor" OrderBy="it.ShortName" 
        Select="it.[Id], it.[ShortName]" 
        Where="it.Company.Id == @CompanyId">
        <WhereParameters>
            <asp:SessionParameter ConvertEmptyStringToNull="False" DbType="Int64" 
                Name="CompanyId" SessionField="CompanyId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="provinceDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="Provinces" 
        EntityTypeFilter="Province" OrderBy="it.Name" Select="it.[Id], it.[Name]">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="districtDataSource" runat="server">
    </asp:EntityDataSource>
    <asp:ListView ID="listView" runat="server" DataKeyNames="Id" 
        DataSourceID="creationDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" onprerender="ListViewPreRender" 
        oniteminserting="ListViewItemInserting" 
        onitemupdating="ListViewItemUpdating">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:TextBox ID="DateTextBox" runat="server" 
                        Text='<%# Bind("Date") %>' CssClass="verySmallTextBox" />
                    <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="CreatedMassTextBox" runat="server" 
                        Text='<%# Bind("CreatedMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CreatedMassTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="UPDATE" ControlToValidate="CreatedMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="CreatedDryMassTextBox" runat="server" 
                         Text='<%# Bind("CreatedDryMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ID="CreatedDryMassRequiredFieldValidator"
                        ControlToValidate="CreatedDryMassTextBox" 
                        ValidationGroup="UPDATE" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="CreatedDryMassRegularExpressionValidator" 
                        Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="UPDATE" ControlToValidate="CreatedDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromRecyclingOrDestructionCheckBox" Checked='<%# Eval("PartNumber") != null  %>' AutoPostBack="true" />
                </td>
                <td>
                    <usr:DropDownListExtended ID="PartNumberDropDownList" runat="server"
                        CssClass="smallTextBox" DataSourceID="partNumberDataSource" DataValueField="PartNumber" 
                            SelectedValue='<%# Eval("PartNumber") %>' DataTextField="PartNumber" />
                    <asp:RequiredFieldValidator ID="PartNumberRequiredFieldValidator" runat="server" Display="Dynamic"
                        ValidationGroup="UPDATE" ControlToValidate="PartNumberDropDownList" ErrorMessage="* nie wybrano wartości" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromPgoCheckBox" Checked='<%# Eval("PgoCommune") != null %>' AutoPostBack="true" />
                </td>
                <td>
                    <uc1:CommuneSelector ID="PgoCommuneSelector" runat="server" InsertEmptyCommune="true"
                        CommuneId='<%# Eval("PgoCommune") != null ? Eval("PgoCommune.Id") : 0L %>' ValidationGroup="UPDATE" />
                </td>
                <td>
                    <usr:DropDownListExtended ID="PgoContractorDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="contractorDataSource" DataTextField="ShortName" DataValueField="Id"
                        SelectedValue='<%# Eval("PgoContractor") != null ? Eval("PgoContractor.Id") : 0L %>' />
                    <asp:RequiredFieldValidator ID="PgoContractorRequiredFieldValidator" runat="server" ErrorMessage="* nie wybrano wartości" 
                        ControlToValidate="PgoContractorDropDownList" ValidationGroup="UPDATE" />
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
                    <asp:TextBox ID="DateTextBox" runat="server" 
                        Text='<%# Bind("Date") %>' CssClass="verySmallTextBox" />
                    <asp:CalendarExtender TargetControlID="DateTextBox" runat="server" DefaultView="Days" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                </td>
                <td>
                    <asp:TextBox ID="CreatedMassTextBox" runat="server" 
                        Text='<%# Bind("CreatedMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CreatedMassTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="INSERT" ControlToValidate="CreatedMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td>
                    <asp:TextBox ID="CreatedDryMassTextBox" runat="server" 
                         Text='<%# Bind("CreatedDryMass") %>' CssClass="verySmallTextBox" />
                    <asp:RequiredFieldValidator runat="server" ID="CreatedDryMassRequiredFieldValidator" 
                        ControlToValidate="CreatedDryMassTextBox" 
                        ValidationGroup="INSERT" ErrorMessage="* nie podano wartości" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="CreatedDryMassRegularExpressionValidator" 
                        Display="Dynamic" ErrorMessage="* podano błędną liczbę" 
	                    ValidationGroup="INSERT" ControlToValidate="CreatedDryMassTextBox" ValidationExpression="^\d+(,\d+)?$" runat="server" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromRecyclingOrDestructionCheckBox" AutoPostBack="true" />
                </td>
                <td>
                    <asp:DropDownList ID="PartNumberDropDownList" runat="server"
                        CssClass="smallTextBox" DataSourceID="partNumberDataSource" DataTextField="PartNumber" />
                    <asp:RequiredFieldValidator ID="PartNumberRequiredFieldValidator" runat="server" Display="Dynamic"
                        ValidationGroup="INSERT" ControlToValidate="PartNumberDropDownList" ErrorMessage="* nie wybrano wartości" />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromPgoCheckBox" AutoPostBack="true" />
                </td>
                <td>
                    <uc1:CommuneSelector ID="PgoCommuneSelector" runat="server" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:DropDownList ID="PgoContractorDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="contractorDataSource" DataTextField="ShortName" DataValueField="Id" />
                    <asp:RequiredFieldValidator ID="PgoContractorRequiredFieldValidator" runat="server" ErrorMessage="* nie wybrano wartości" 
                        ControlToValidate="PgoContractorDropDownList" ValidationGroup="INSERT" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" CssClass="smallButton"
                        Text="Dodaj" ValidationGroup="INSERT" />&nbsp;
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="smallButton"
                        Text="Anuluj" CausesValidation="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date", "{0:d}") %>' />
                </td>
                <td>
                    <asp:Label ID="CreatedMassLabel" runat="server" Text='<%# Eval("CreatedMass") %>' />
                </td>
                <td>
                    <asp:Label ID="CreatedDryMassLabel" runat="server" Text='<%# Double.Parse(Eval("CreatedDryMass") + "") != 0 ? Eval("CreatedDryMass") : "---" %>' />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromRecyclingOrDestructionCheckBox" Enabled="false" Checked='<%# Eval("PartNumber") != null  %>' />
                </td>
                <td>
                    <asp:Label ID="PartNumberDropDownList" runat="server" Text='<%# Eval("PartNumber") != null ? Eval("PartNumber") : "---" %>' />
                </td>
                <td style="text-align: center;">
                    <asp:CheckBox runat="server" ID="IsFromPgoCheckBox" Enabled="false" Checked='<%# Eval("PgoCommune") != null %>' />
                </td>
                <td>
                    <asp:Label ID="PgoCommuneLabel" runat="server" Text='<%# Eval("PgoCommune") != null ? Eval("PgoCommune.Name") : "---" %>' />
                </td>
                <td>
                    <asp:Label ID="PgoContractorLabel" runat="server" Text='<%# Eval("PgoContractor") != null ? Eval("PgoContractor.ShortName") : "---" %>' />
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Usuń" OnClientClick="javascript: return DeleteSurety();" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" class="dataTable" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Data</th>
                    <th runat="server">
                        Masa całkowita [Mg]</th>
                    <th runat="server">
                        Masa sucha [Mg]</th>
                    <th>
                        Pochodzi z odzysku lub unieszkodliwiania?</th>
                    <th runat="server">
                        Numer partii</th>
                    <th>
                        Pochodzi z PGO?
                        </th>
                    <th runat="server">
                        Gmina</th>
                    <th runat="server">
                        Kontrahent</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>

