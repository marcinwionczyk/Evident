<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Destruction.aspx.cs" Inherits="EVident.Destruction" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
             Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server" 
                              EnableScriptLocalization="True" EnableScriptGlobalization="True"/>
    <h3>Unieszkodliwianie</h3>
    <h4>Kod odpadu:  <asp:Label runat="server" ID="WasteCodeLabel"/></h4>
    <asp:EntityDataSource ID="ProcessingMethodDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
                          EntityTypeFilter="ProcessingMethod" 
                          Select="it.[Name], it.[Description], it.[Id]" Where="it.[Kind] = 1">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="InstallationsDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="Installations" 
                          Select="it.[Name], it.[Id]" EntityTypeFilter="" 
                          Where="it.Department.Id = @DepartmentId">
        <WhereParameters>
            <asp:SessionParameter DbType="Int64" Name="DepartmentId" 
                                  SessionField="DepartmentId" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:ListView ID="DestructionListView" runat="server" ConvertEmptyStringToNull="True"
                  InsertItemPosition="FirstItem" DataKeyNames="Id" 
                  onitemcanceling="DestructionListViewItemCanceling" 
                  onitemdatabound="DestructionListViewItemDataBound" 
                  onitemdeleting="DestructionListViewItemDeleting" 
                  onitemediting="DestructionListViewItemEditing" 
                  oniteminserting="DestructionListViewItemInserting" 
                  onitemupdating="DestructionListViewItemUpdating" 
                  ondatabound="DestructionListViewDataBound">
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" runat="server" class="dataTable">
                <tr id="Tr1" runat="server">
                    <th id="Th1" runat="server">Data</th>
                    <th id="Th2" runat="server">Masa całkowita [Mg]</th>
                    <th id="Th3" runat="server">Masa sucha [Mg]</th>
                    <th id="Th4" runat="server">Metoda unieszko-<br/>dliwiania</th>
                    <th id="Th5" runat="server">Instalacja</th>
                    <th id="Th6" runat="server">Nr partii</th>
                    <th id="Th10" runat="server"></th>
                </tr>
                <tr runat="server" ID="itemPlaceholder"></tr>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label runat="server" Text='<%# Eval("Date", "{0:d MMMM yyyy}") %>'/>
                </td>
                <td>
                    <asp:Label runat="server" Text='<%# Eval("ManageMass", "{0:F4}") %>'/>
                </td>
                <td>
                    <asp:Label runat="server" ID="ManageDryMassLabel" Text='<%# Eval("ManageDryMass", "{0:F4}") %>'/>
                </td>
                <td>
                    <asp:Label runat="server" Text='<%# Eval("ProcessingMethod.Name") %>' 
                               ToolTip='<%# Eval("ProcessingMethod.Description") %>'/>
                </td>
                <td>
                    <asp:Label runat="server" Text='<%# Eval("Installation") != null ? Eval("Installation.Name") : "---" %>'/>
                </td>
                <td>
                    <asp:Label runat="server" Text='<%# Eval("PartNumber") %>'/>
                </td>
                <td>
                    <asp:LinkButton runat="server" ID="EditButton" CommandName="Edit" Text="Edytuj"/>
                    <asp:LinkButton runat="server" ID="DeleteButton" CommandName="Delete" Text="Usuń"/>
                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Czy na pewno chcesz usunąć?" 
                                               TargetControlID="DeleteButton"/>
                </td>
            </tr>
        </ItemTemplate>
        <InsertItemTemplate>
            <tr>
                <td class="aligntop">
                    <asp:TextBox runat="server" ID="DateTB" CssClass="verySmallTextBox" />
                    <asp:CalendarExtender ID="DateInsertCalendarExtender" runat="server"
                                          TargetControlID="DateTB" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="* nie podano wartości" ControlToValidate="DateTB" ValidationGroup="Group" Display="Dynamic"/>
                </td>
                <td class="aligntop">
                    <asp:TextBox runat="server" ID="ManageMassTB" CssClass="verySmallTextBox"/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ManageMassTB" ID="F1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="REV1" runat="server" Display="Dynamic"
                                                    ErrorMessage="* podano błędną liczbę" ValidationExpression="^\d+(,\d+)?$" 
                                                    ControlToValidate="ManageMassTB" ValidationGroup="Group" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                                ErrorMessage="* nie podano wartości" ValidationGroup="Group" 
                                                ControlToValidate="ManageMassTB"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="ManageDryMassTB" CssClass="verySmallTextBox"/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ManageDryMassTB" ID="FilteredTextBoxExtender1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic"
                                                    ErrorMessage="* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ManageDryMassTB" ValidationGroup="Group"/>
                    <asp:RequiredFieldValidator ID="DryMassRequiredValidator" runat="server" Display="Dynamic"
                                                ErrorMessage="* nie podano wartości" ValidationGroup="Group" 
                                                ControlToValidate="ManageDryMassTB"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="DestructionMethodDDL" CssClass="verySmallDropDownList"
                                      DataSourceID="ProcessingMethodDataSource" DataTextField="Name" DataValueField="Id"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="InstallationsDDL" AppendDataBoundItems="True" CssClass="smallDropDownList"
                                      DataSourceID="InstallationsDataSource" DataTextField="Name" DataValueField="Id">
                        <asp:ListItem Text="[Brak]" Value="-1"/>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="PartNumberTB" CssClass="verySmallTextBox"/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="PartNumberTB" FilterType="Numbers"/>
                </td>
                <td>
                    <asp:Button runat="server" ID="InsertButton" CommandName="Insert" Text="Wstaw" CssClass="smallButton" ValidationGroup="Group"/>
                    <asp:Button runat="server" ID="CancelInsertButton" CommandName="Cancel" CssClass="smallButton" Text="Anuluj" />
                </td>
            </tr>
        </InsertItemTemplate>
        <EditItemTemplate>
            <tr>
                <td>
                    <asp:TextBox runat="server" ID="DateTB" CssClass="verySmallTextBox" Text='<%# Eval("Date", "{0:yyyy-MM-dd}") %>'/>
                    <asp:CalendarExtender ID="DateInsertCalendarExtender" runat="server"
                                          TargetControlID="DateTB" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                                                ErrorMessage="* nie podano wartości" ControlToValidate="DateTB" ValidationGroup="Group"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="ManageMassTB" CssClass="verySmallTextBox" Text='<%# Eval("ManageMass", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ManageMassTB" ID="F1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="REV1" runat="server" Display="Dynamic"
                                                    ErrorMessage="* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ManageMassTB" ValidationGroup="Group"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                                ErrorMessage="* nie podano wartości" ValidationGroup="Group" 
                                                ControlToValidate="ManageMassTB"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="ManageDryMassTB" CssClass="smallTextBox" Text='<%# Eval("ManageDryMass", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ManageDryMassTB" ID="FilteredTextBoxExtender1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic"
                                                    ErrorMessage="* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ManageDryMassTB" ValidationGroup="Group"/>
                    <asp:RequiredFieldValidator ID="DryMassRequiredValidator" runat="server" Display="Dynamic"
                                                ErrorMessage="* nie podano wartości" ValidationGroup="Group" 
                                                ControlToValidate="ManageDryMassTB"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="DestructionMethodDDL" SelectedValue='<%# Eval("ProcessingMethod.Id") %>' 
                                      DataSourceID="ProcessingMethodDataSource" DataTextField="Name" DataValueField="Id"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="InstallationsDDL" AppendDataBoundItems="True" SelectedValue='<%# Bind("Installation.Id") %>'
                                      DataSourceID="InstallationsDataSource" DataTextField="Name" DataValueField="Id" CssClass="smallDropDownList">
                        <asp:ListItem Text="[Brak]" Value=""/>   
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="PartNumberTB" Text='<%# Eval("PartNumber") %>' CssClass="verySmallTextBox"/>
                    <asp:FilteredTextBoxExtender runat="server" FilterType="Numbers" TargetControlID="PartNumberTB"/>
                </td>
                <td>
                    <asp:Button runat="server" ID="EditButton" CommandName="Update" Text="Aktualizuj" CssClass="smallButton" ValidationGroup="Group"/>
                    <asp:Button runat="server" ID="CancelInsertButton" CommandName="Cancel" CssClass="smallButton" Text="Anuluj" />
                </td>
            </tr>
        </EditItemTemplate>
    </asp:ListView>
</asp:Content>