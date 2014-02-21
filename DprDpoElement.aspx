<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="DprDpoElement.aspx.cs" Inherits="EVident.DprDpoElement1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="toolkitScriptManager" runat="server">
    </asp:ToolkitScriptManager>
    <asp:EntityDataSource ID="dprDpoElementDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
        EnableUpdate="True" EntitySetName="DprDpoElements" 
        EntityTypeFilter="DprDpoElement" Where="it.DprDpo.Id == @Id" 
        Include="WasteCode,ProcessingMethod,PackageKind,RecyclingKind">
            <InsertParameters>
                <asp:QueryStringParameter DbType="Int64" Name="DprDpo.Id" QueryStringField="Id" />
            </InsertParameters>
            <WhereParameters>
                <asp:QueryStringParameter DbType="Int64" Name="Id" QueryStringField="Id" />
            </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="wasteCodeDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="WasteCodes" 
        EntityTypeFilter="WasteCode" OrderBy="it.Name" Select="" 
        Where="it.Level == 2">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="processingMethodDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
        EntityTypeFilter="ProcessingMethod" 
        OrderBy="Length(it.Name), Right(it.Name, Length(it.Name) - 1)" 
        Where="it.Kind == 0">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="packageKindDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="PackageKinds" 
        EntityTypeFilter="PackageKind" OrderBy="it.Name">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="recyclingKindDataSource" runat="server" 
        ConnectionString="name=EVidentDataModel" 
        DefaultContainerName="EVidentDataModel" EntitySetName="RecyclingKinds" 
        EntityTypeFilter="RecyclingKind" OrderBy="it.Name">
    </asp:EntityDataSource>
    <h3>DPR/DPO (szczegóły)</h3>
    <h4>KONTRAHENT: <asp:Literal ID="contractorLiteral" runat="server"></asp:Literal></h4>
    <h4>DPR: <asp:Literal ID="dprLiteral" runat="server"></asp:Literal>&nbsp;<asp:HyperLink 
            ID="dprHyperLink" Text="Podgląd dokumentu DPR >>>" runat="server" 
            Target="_blank" /></h4>
    <h4>DPO: <asp:Literal ID="dpoLiteral" runat="server"></asp:Literal>&nbsp;<asp:HyperLink 
            ID="dpoHyperLink" Text="Podgląd dokumentu DPO >>>" runat="server" 
            Target="_blank" /></h4>
    <br />
    <asp:ListView ID="dprDpoElementListView" runat="server" DataKeyNames="Id" 
        DataSourceID="dprDpoElementDataSource" EnableModelValidation="True" 
        InsertItemPosition="FirstItem" 
        oniteminserting="DprDpoElementListViewItemInserting" 
        onitemupdating="DprDpoElementListViewItemUpdating">
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:DropDownList ID="wasteCodeDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="wasteCodeDataSource" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Eval("WasteCode.Id") %>' />
                    <asp:ListSearchExtender  runat="server" TargetControlID="wasteCodeDropDownList" PromptText="Pisz aby wyszukać">
                    </asp:ListSearchExtender>
                </td>
                <td>
                    <asp:TextBox ID="ReceivedMassTextBox" runat="server" CssClass="smallTextBox"
                        Text='<%# Bind("ReceivedMass") %>' />
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="ReceivedMassTextBox" ValidationGroup="UPDATE" 
                        runat="server" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator Display="Dynamic" runat="server" ErrorMessage="* podano błędną liczbę" 
                    ValidationGroup="UPDATE" ControlToValidate="ReceivedMassTextBox" ValidationExpression="^\d+(,\d+)?$"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:TextBox ID="RecycledMassTextBox" runat="server" CssClass="smallTextBox"
                        Text='<%# Bind("RecycledMass") %>' />
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="RecycledMassTextBox" ValidationGroup="UPDATE" 
                        runat="server" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator Display="Dynamic" runat="server" ErrorMessage="* podano błędną liczbę" 
                    ValidationGroup="UPDATE" ControlToValidate="RecycledMassTextBox" ValidationExpression="^\d+(,\d+)?$"></asp:RegularExpressionValidator>
                    <asp:CompareValidator runat="server" ErrorMessage="* za duża wartość" ValidationGroup="UPDATE" Display="Dynamic"
                    Type="Double" ControlToValidate="RecycledMassTextBox" ControlToCompare="ReceivedMassTextBox" Operator="LessThanEqual"></asp:CompareValidator>
                </td>
                <td>
                    <asp:DropDownList ID="processingMethodDropDownList" runat="server" CssClass="verySmallDropDownList" 
                        DataSourceID="processingMethodDataSource" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Eval("ProcessingMethod.Id") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="packageKindDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="packageKindDataSource" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Eval("PackageKind.Id") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="recyclingKindDropDownList" runat="server" CssClass="mediumDropDownList" 
                        DataSourceID="recyclingKindDataSource" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Eval("RecyclingKind.Id") %>' />
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" ValidationGroup="UPDATE"
                        Text="Zapisz" />
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
                    <asp:DropDownList ID="wasteCodeDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="wasteCodeDataSource" DataTextField="Name" DataValueField="Id" />
                    <asp:ListSearchExtender runat="server" TargetControlID="wasteCodeDropDownList" PromptText="Pisz aby wyszukać">
                    </asp:ListSearchExtender>
                </td>
                <td>
                    <asp:TextBox ID="ReceivedMassTextBox" runat="server" CssClass="smallTextBox"
                        Text='<%# Bind("ReceivedMass") %>' />
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="ReceivedMassTextBox" ValidationGroup="INSERT" 
                        runat="server" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator Display="Dynamic" runat="server" ErrorMessage="* podano błędną liczbę" 
                    ValidationGroup="INSERT" ControlToValidate="ReceivedMassTextBox" ValidationExpression="^\d+(,\d+)?$"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:TextBox ID="RecycledMassTextBox" runat="server" CssClass="smallTextBox"
                        Text='<%# Bind("RecycledMass") %>' />
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="RecycledMassTextBox" ValidationGroup="INSERT" 
                        runat="server" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator Display="Dynamic" runat="server" ErrorMessage="* podano błędną liczbę" 
                    ValidationGroup="INSERT" ControlToValidate="RecycledMassTextBox" ValidationExpression="^\d+(,\d+)?$"></asp:RegularExpressionValidator>
                    <asp:CompareValidator runat="server" ErrorMessage="* za duża wartość" ValidationGroup="INSERT" Display="Dynamic"
                    Type="Double" ControlToValidate="RecycledMassTextBox" ControlToCompare="ReceivedMassTextBox" Operator="LessThanEqual"></asp:CompareValidator>
                </td>
                <td>
                    <asp:DropDownList ID="processingMethodDropDownList" runat="server" CssClass="verySmallDropDownList" 
                        DataSourceID="processingMethodDataSource" DataTextField="Name" DataValueField="Id" />
                </td>
                <td>
                    <asp:DropDownList ID="packageKindDropDownList" runat="server" CssClass="smallDropDownList" 
                        DataSourceID="packageKindDataSource" DataTextField="Name" DataValueField="Id" />
                </td>
                <td>
                    <asp:DropDownList ID="recyclingKindDropDownList" runat="server" CssClass="mediumDropDownList" 
                        DataSourceID="recyclingKindDataSource" DataTextField="Name" DataValueField="Id" />
                </td>
                <td>
                    <asp:Button ID="InsertButton" ValidationGroup="INSERT" CssClass="smallButton" runat="server" CommandName="Insert" 
                        Text="Dodaj" />
                    <asp:Button ID="CancelButton" CssClass="smallButton" runat="server" CommandName="Cancel" CausesValidation="false"
                        Text="Anuluj" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="WasteCodeLabel" runat="server" Text='<%# Eval("WasteCode.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="ReceivedMassLabel" runat="server" 
                        Text='<%# Eval("ReceivedMass") %>' />
                </td>
                <td>
                    <asp:Label ID="RecycledMassLabel" runat="server" 
                        Text='<%# Eval("RecycledMass") %>' />
                </td>
                <td>
                    <asp:Label ID="ProcessingMethodLabel" runat="server" 
                        Text='<%# Eval("ProcessingMethod.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="PackageKindLabel" runat="server" 
                        Text='<%# Eval("PackageKind.Name") %>' />
                </td>
                <td>
                    <asp:Label ID="RecyclingKindLabel" runat="server" 
                        Text='<%# Eval("RecyclingKind.Name") %>' />
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj" />&nbsp;
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Usuń" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" class="dataTable" runat="server" border="0" style="">
                <tr runat="server" style="">
                    <th runat="server">
                        Kod odpadu</th>
                    <th runat="server">
                        Przyjęto [kg]</th>
                    <th runat="server">
                        Poddano odzyskowi [kg]</th>
                    <th runat="server">
                        Metoda odzysku</th>
                    <th runat="server">
                        Rodzaj opakowania</th>
                    <th runat="server">
                        Poddany odzyskowi w procesie</th>
                    <th runat="server">
                    </th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>
