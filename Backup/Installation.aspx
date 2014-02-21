<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Installation.aspx.cs" Inherits="EVident.Installation1" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="System.Data" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
             Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script src="JavaScript.js" type="text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server"/>
    
    <h3>Instalacje</h3>
    
    <asp:EntityDataSource ID="InstallationKindDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="InstallationKinds" 
                          EntityTypeFilter="InstallationKind">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="InstallationProcessingMethodDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="InstallationProcessingMethods" 
                          EntityTypeFilter="InstallationProcessingMethod">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="IstallationsDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="Installations" 
                          EnableDelete="True" EnableInsert="True" EnableUpdate="True" 
                          Include="InstallationKind,Department,InstallationProcessingMethod,DecisionElements,DecisionElements1,DecisionElements2,InstallationWasteCodes" 
                          Where="it.Department.Id == @DepartmentId" Select="">
        <WhereParameters>
            <asp:SessionParameter DbType="Int64" Name="DepartmentId" 
                                  SessionField="DepartmentId" />
        </WhereParameters>
    </asp:EntityDataSource>
    
    <asp:ListView ID="InstallationListView" runat="server" DataKeyNames="Id" 
                  DataSourceID="IstallationsDataSource" EnableModelValidation="True" 
                  InsertItemPosition="FirstItem" 
                  oniteminserting="InstallationListView_ItemInserting" 
                  onitemdatabound="InstallationListView_ItemDataBound" 
        ondatabound="InstallationListView_DataBound" >
        <EditItemTemplate>
            <tr>
                <td class="aligntop">
                    <asp:TextBox ID="NameTextBox" runat="server" CssClass="smallTextBox" Text='<%# Bind("Name") %>'/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="EditValidation"
                                                ControlToValidate="NameTextBox" Display="Dynamic"
                                                ErrorMessage="<br />* proszę podać nazwę"/>
                </td>
                <td class="aligntop">
                    <asp:TextBox ID="ProcessingCapacityEditTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ProcessingCapacity", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ProcessingCapacityEditTextBox" ID="F1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="REV1" runat="server" Display="Dynamic"
                                                    ErrorMessage="<br />* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ProcessingCapacityEditTextBox" ValidationGroup="EditValidation"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="EditValidation"
                                                ControlToValidate="ProcessingCapacityEditTextBox" Display="Dynamic"
                                                ErrorMessage="<br />* proszę podać liczbę"/>
                </td>
                <td class="aligntop">
                    <asp:TextBox ID="ProcessingLimitEditTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ProcessingLimit", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ProcessingLimitEditTextBox" ID="FilteredTextBoxExtender1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic"
                                                    ErrorMessage="<br />* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$"
                                                    ControlToValidate="ProcessingLimitEditTextBox" ValidationGroup="EditValidation"/>
                </td>
                <td class="aligntop">
                    <asp:DropDownList runat="server" DataValueField="Id" 
                                      DataTextField="Name" ID="InstallationKindDropDownList" 
                                      OnSelectedIndexChanged="InstallationKindDropDownListSelectedIndexChanged" 
                                      DataSourceID="InstallationKindDataSource" CssClass="smallDropDownList" 
                                      SelectedValue='<%# Bind("InstallationKind.Id") %>'>
                    </asp:DropDownList>
                </td>
                <td class="aligntop">
                    <asp:Literal ID="InstallationKindDescriptionLiteral" runat="server" 
                                 Text='<%# Eval("InstallationKind.Description") %>' />
                </td>
                <td class="aligntop">
                    <asp:DropDownList runat="server" ID="InstallationProcessingMethodsDropDownList"
                                      DataSourceID="InstallationProcessingMethodDataSource" DataTextField="Name" DataValueField="Id" 
                                      SelectedValue='<%# Bind("InstallationProcessingMethod.Id") %>'>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                                    Text="Zapisz" ValidationGroup="EditValidation"/> <br/>
                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                    Text="Anuluj" />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>
                        Brak danych.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr>
                <td class="aligntop">
                    <asp:TextBox ID="NameTextBox" runat="server" CssClass="smallTextBox" Text='<%# Bind("Name") %>'/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic"
                                                ControlToValidate="NameTextBox"
                                                ValidationGroup="InsertValidation"
                                                ErrorMessage="<br />* proszę podać nazwę"/>
                </td>
                <td class="aligntop">
                    <asp:TextBox ID="ProcessingCapacityInsertTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ProcessingCapacity", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ProcessingCapacityInsertTextBox" ID="F1"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="REV1" runat="server" Display="Dynamic"
                                                    ErrorMessage="<br />* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ProcessingCapacityInsertTextBox" ValidationGroup="InsertValidation"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"  ValidationGroup="InsertValidation"
                                                ControlToValidate="ProcessingCapacityInsertTextBox" Display="Dynamic"
                                                ErrorMessage="<br />* proszę podać liczbę"/>
                </td>
                <td class="aligntop">
                    <asp:TextBox ID="ProcessingLimitInsertTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ProcessingLimit", "{0:F4}") %>'/>
                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="ProcessingLimitInsertTextBox" ID="FilteredTextBoxExtender2"
                                                 FilterType="Numbers,Custom" ValidChars=","/>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic"
                                                    ErrorMessage="<br />* podano błędną liczbę" ValidationExpression="^\d+([,]\d+)?$" 
                                                    ControlToValidate="ProcessingLimitInsertTextBox" ValidationGroup="InsertValidation"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="InsertValidation" 
                                                ControlToValidate="ProcessingLimitInsertTextBox" Display="Dynamic"
                                                ErrorMessage="<br />* proszę podać liczbę"/>
                </td>
                <td class="aligntop">
                    <asp:DropDownList ID="InstallationKindDropDownList" runat="server" DataSourceID="InstallationKindDataSource"
                                      DataValueField="Id" DataTextField="Name" 
                                      OnSelectedIndexChanged="InstallationKindDropDownListSelectedIndexChanged" AutoPostBack="true"
                                      CssClass="smallDropDownList"/>
                </td>
                <td class="aligntop">
                    <asp:Literal ID="InstallationKindDescriptionLiteral" runat="server"/>
                </td>
                <td class="aligntop">
                    <asp:DropDownList runat="server" ID="InstallationProcessingMethodsDropDownList" 
                                      DataSourceID="InstallationProcessingMethodDataSource" DataTextField="Name" 
                                      DataValueField="Id" CssClass="smallDropDownList"/>
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" ValidationGroup="InsertValidation" 
                                Text="Dodaj" CssClass="smallButton"/> <br />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("Id") %>'
                                CssClass="smallButton" Text="Anuluj" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                </td>
                <td class="alignright">
                    <asp:Label ID="ProcessingCapacityLabel" runat="server" 
                               Text='<%# Eval("ProcessingCapacity", "{0:F4}") %>' />

                </td>
                <td class="alignright">
                    <asp:Label ID="ProcessingLimitLabel" runat="server" 
                               Text='<%# Eval("ProcessingLimit", "{0:F4}") %>' />
                </td>
                <td>
                    <asp:Label ID="InstallationKindLabel" runat="server" 
                               Text='<%# Eval("InstallationKind") != null ? Eval("InstallationKind.Name") : "---" %>' />
                </td>
                <td>
                    <asp:Label ID="InstallationKindDescriptionLabel" runat="server" 
                               Text='<%# Eval("InstallationKind") != null ? Eval("InstallationKind.Description") : "---" %>' />
                </td>
                <td>
                    <asp:Label runat="server" ID="InstallationProcessingMethodLabel" Text='<%# Eval("InstallationProcessingMethod") != null
                                  ? Eval("InstallationProcessingMethod.Name")
                                  : "---" %>'/>
                </td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edytuj"/> <br />
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" OnClientClick="javascript: return DeleteSurety();"
                                    Text="Usuń" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table ID="itemPlaceholderContainer" runat="server" class="dataTable" >
                <tr id="Tr1" runat="server">
                    <th id="Th1" runat="server">
                        Nazwa</th>
                    <th id="Th2" runat="server">
                        Projektowana moc przerobowa <br /> [Mg/rok]</th>
                    <th id="Th3" runat="server">
                        Roczna ilość dopuszczona w decyzji <br /> [Mg]</th>
                    <th id="Th4" runat="server">
                        Rodzaj instalacji</th>
                    <th id="Th5" runat="server">
                        Opis instalacji</th>
                    <th id="Th6" runat="server">
                        Typ procesu <br /> przetwarzania <br /> odpadów</th>
                    <th id="Th7" runat="server">
                    </th>
                </tr>
                <tr runat="server" ID="itemPlaceholder">
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>   
</asp:Content>