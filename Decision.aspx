<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Decision.aspx.cs" Inherits="EVident.Decision1" Culture="pl-PL" UICulture="pl-PL" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script src="JavaScript.js" type="text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="ScriptManager" runat="server" 
                              EnableScriptLocalization="True" EnableScriptGlobalization="True"/>
    
    <asp:EntityDataSource ID="WasteCodesDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="WasteCodes" 
                          Select="it.[Id], it.[Name], it.[Description], it.[Level]" 
                          Where="it.Level &gt; 1">
    </asp:EntityDataSource>    

    
    <asp:EntityDataSource ID="RecyclingMethodDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
                          EntityTypeFilter="ProcessingMethod" 
                          Select="it.[Id], it.[Name]" Where="it.Kind = 0" OrderBy="it.Name">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="DestructionMethodDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="ProcessingMethods" 
                          Select="it.[Id], it.[Name]" Where="it.Kind = 1">
    </asp:EntityDataSource>


    
    <asp:EntityDataSource ID="InstallationsDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EntitySetName="Installations" 
                          EntityTypeFilter="Installation" 
                          Where="it.Department.Id = @DepartmentId">
        <WhereParameters>
            <asp:SessionParameter Name="DepartmentId" SessionField="DepartmentId" 
                                  DbType="Int64" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:HiddenField ID="DecisionIdHiddenField" runat="server" />
    <asp:EntityDataSource ID="DecisionsDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
                          EnableUpdate="True" EntitySetName="Decisions" EntityTypeFilter="Decision">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="DecisionElementsDataSource" runat="server" 
                          ConnectionString="name=EVidentDataModel" 
                          Include="WasteCode,Installation,Installation1,Installation2,ProcessingMethod,ProcessingMethod1,Decision"
                          DefaultContainerName="EVidentDataModel" EnableDelete="True" EnableInsert="True" 
                          EnableUpdate="True" EntitySetName="DecisionElements" 
                          EntityTypeFilter="DecisionElement" Where="it.Decision.Id == @DecisionId">
        <WhereParameters>
            <asp:ControlParameter ControlID="DecisionIdHiddenField" DbType="Int64" 
                                  Name="DecisionId" PropertyName="Value" />
        </WhereParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="DecisionIdHiddenField" DbType="Int64" 
                                  Name="Decision.Id" PropertyName="Value" />
        </InsertParameters>
    </asp:EntityDataSource>


    
    <h3>Decyzje</h3>    
    <table class="groupingTable">
        <tr>
            <td>
                <asp:Panel ID="DecisionListPanel" runat="server" GroupingText="Lista decyzji">
                   
                    <asp:ListView ID="DecisionsListView" runat="server" DataKeyNames="Id" 
                                  DataSourceID="DecisionsDataSource" EnableModelValidation="True" 
                                  InsertItemPosition="FirstItem" 
                                  onselectedindexchanged="DecisionsListView_SelectedIndexChanged" 
                                  onitemdeleting="DecisionsListViewItemDeleting" 
                        oniteminserting="DecisionsListViewItemInserting">
                        <EditItemTemplate>
                            <tr>
                                <td>
                                    <asp:TextBox ID="NumberTextBox" runat="server" Text='<%# Bind("Number") %>' CssClass="smallTextBox" />
                                </td>
                                <td>
                                    <asp:TextBox ID="ReleaseDateTextBox" runat="server" 
                                                 Text='<%# Bind("ReleaseDate", "{0:d}") %>' CssClass="verySmallTextBox"/>
                                    <asp:CalendarExtender ID="ReleaseDateEditCalendarExtender" runat="server" 
                                                          TargetControlID="ReleaseDateTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                    
                                </td>
                                <td>
                                    <asp:TextBox ID="ReleaseAuthorityTextBox" runat="server" 
                                                 Text='<%# Bind("ReleaseAuthority") %>' CssClass="smallTextBox" />
                                </td>
                                <td>
                                    <asp:TextBox ID="ValidFromEditTextBox" runat="server" CssClass="verySmallTextBox"
                                                 Text='<%# Bind("ValidFrom", "{0:d}") %>'/>
                                    <asp:CalendarExtender ID="ValidFromEditCalendarExtender" runat="server" 
                                                          TargetControlID="ValidFromEditTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                </td>
                                <td>
                                    <asp:TextBox ID="ValidToEditTextBox" runat="server" Text='<%# Bind("ValidTo", "{0:d}") %>' CssClass="verySmallTextBox"/>
                                    <asp:CalendarExtender ID="ValidToEditCalendarExtender" runat="server" 
                                                          TargetControlID="ValidToEditTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                </td>
                                <td>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                                                    Text="Aktualizuj"/>
                                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                                    Text="Anuluj" />
                                </td>
                            </tr>
                        </EditItemTemplate>
                        
                        <InsertItemTemplate>
                            <tr>
                                <td>
                                    <asp:TextBox ID="NumberTextBox" runat="server" CssClass="smallTextBox" Text='<%# Bind("Number") %>'/>
                                </td>
                                <td>
                                    <asp:TextBox ID="ReleaseDateTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ReleaseDate", "{0:d}") %>'/>
                                    <asp:CalendarExtender ID="ReleaseDateInsertCalendarExtender" runat="server"
                                                          TargetControlID="ReleaseDateTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                
                                </td>
                                <td>
                                    <asp:TextBox ID="ReleaseAuthorityTextBox" runat="server"  CssClass="smallTextBox" Text='<%# Bind("ReleaseAuthority") %>'>Minister środowiska</asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="ValidFromInsertTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ValidFrom", "{0:d}") %>'/>
                                    <asp:CalendarExtender ID="ValidFromInsertCalendarExtender" runat="server"
                                                          TargetControlID="ValidFromInsertTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                </td>
                                <td>
                                    <asp:TextBox ID="ValidToInsertTextBox" runat="server" CssClass="verySmallTextBox" Text='<%# Bind("ValidTo", "{0:d}") %>'/>
                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server"
                                                          TargetControlID="ValidToInsertTextBox" DefaultView="Years" Format="yyyy-MM-dd" TodaysDateFormat="dd MMMM yyyy" />
                                </td>
                                <td>
                                    <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" 
                                                    Text="Dodaj" />
                                    <asp:LinkButton CommandName="Cancel" ID="CancelButton2" runat="server" Text="Anuluj" />
                                </td>
                            </tr>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="NumberLabel" runat="server" Text='<%# Eval("Number") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ReleaseDateLabel" runat="server" 
                                               Text='<%# Eval("ReleaseDate", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ReleaseAuthorityLabel" runat="server" 
                                               Text='<%# Eval("ReleaseAuthority") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ValidFromLabel" runat="server" Text='<%# Eval("ValidFrom", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ValidToLabel" runat="server" Text='<%# Eval("ValidTo", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="SelectButton" 
                                                    Text="Wybierz" CommandName="Select"/>
                                    <asp:LinkButton runat="server" ID="EditButton"
                                                    CommandName="Edit" Text="Edytuj"/>
                                    <asp:LinkButton runat="server" ID="DeleteButton" OnClientClick="javascript: return DeleteSurety();"
                                                    CommandName="Delete" Text="Usuń"/>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <SelectedItemTemplate>
                            <tr class="selected">
                                <td>
                                    <asp:Label ID="NumberLabel" runat="server" Text='<%# Eval("Number") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ReleaseDateLabel" runat="server" 
                                               Text='<%# Eval("ReleaseDate", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ReleaseAuthorityLabel" runat="server" 
                                               Text='<%# Eval("ReleaseAuthority") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ValidFromLabel" runat="server" Text='<%# Eval("ValidFrom", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ValidToLabel" runat="server" Text='<%# Eval("ValidTo", "{0:d MMMM yyyy}") %>' />
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="EditButton"
                                                    CommandName="Edit" Text="Edytuj"/>
                                    <asp:LinkButton runat="server" ID="DeleteButton"
                                                    CommandName="Delete" Text="Usuń"/>
                                </td>
                            </tr>
                        </SelectedItemTemplate>
                        <LayoutTemplate>
                            <table ID="itemPlaceholderContainer" runat="server" class="dataTable">
                                <tr id="Tr1" runat="server">
                                    <th id="Th13" runat="server">Numer decyzji</th>
                                    <th id="Th14" runat="server">Data wydania</th>
                                    <th id="Th15" runat="server">Organ wydający</th>
                                    <th id="Th16" runat="server">Ważna od</th>
                                    <th id="Th17" runat="server">Ważna do</th>
                                    <th></th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </LayoutTemplate>     
                    </asp:ListView>
                </asp:Panel>
            </td>
        </tr>
    
        <tr>
            <td>
                <asp:Panel ID="DecisionElementPanel" runat="server" GroupingText="Dane decyzji">
                    
                    <asp:ListView runat="server" ID="DecisionElementListView"
                                  DataKeyNames="Id" EnableModelValidation="True" 
                                  InsertItemPosition="FirstItem"
                                  ConvertEmptyStringToNull="True"
                                  DataSourceID="DecisionElementsDataSource" 
                                  oniteminserting="DecisionElementListView_ItemInserting">
                        <EditItemTemplate>
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="WasteCodesDropDownList"
                                                      DataSourceID="WasteCodesDataSource" CssClass="verySmallDropDownList"
                                                      DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("WasteCode.Id") %>'/>
                                </td>
                                <td>
                                    <asp:TextBox ID="CreatedLimitTextBox" runat="server" 
                                                 Text='<%# Bind("CreatedLimit", "{0:F4}") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="CreatedLimitTextBox" ID="F1"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="REV1" runat="server" 
                                                                    ErrorMessage="* podano błędną liczbę" Display="Dynamic"
                                                                    ValidationExpression="^\d+([,]\d+)?$" ControlToValidate="CreatedLimitTextBox" ValidationGroup="EditGroup"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CreatedPgoCheckBox" runat="server" 
                                                  Checked='<%# Bind("CreatedPgo") %>' CssClass="defaultCheckBox" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="InstallationDropDownList" SelectedValue='<%# Bind("Installation.Id") %>'
                                                      DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True"
                                                      CssClass="verySmallDropDownList">
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="RecycledLimitTextBox" runat="server" 
                                                 Text='<%# Bind("RecycledLimit", "{0:F4}") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="RecycledLimitTextBox" ID="FilteredTextBoxExtender1"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                                    ErrorMessage="* podano błędną liczbę" Display="Dynamic" ValidationExpression="^\d+([,]\d+)?$" 
                                                                    ControlToValidate="RecycledLimitTextBox" ValidationGroup="EditGroup"/>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProcessingMethodDropDownList" 
                                                      DataSourceID="RecyclingMethodDataSource" DataTextField="Name" 
                                                      DataValueField="Id" CssClass="verySmallDropDownList"
                                                      AppendDataBoundItems="True" SelectedValue='<%# Bind("ProcessingMethod.Id") %>'>
                                        <asp:ListItem Text="Brak" Value=""></asp:ListItem>    
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="Installation1DropDownList" DataSourceID="InstallationsDataSource" DataTextField="Name" 
                                                      DataValueField="Id" AppendDataBoundItems="True" CssClass="verySmallDropDownList"
                                                      SelectedValue='<%# Bind("Installation1.Id") %>'>
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="DestroyedLimitTextBox" runat="server" 
                                                 Text='<%# Bind("DestroyedLimit", "{0:F4}") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="DestroyedLimitTextBox" ID="FilteredTextBoxExtender2"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic"
                                                                    ErrorMessage="* podano błedną liczbę" ValidationExpression="^\d+([,]\d+)?$" ControlToValidate="DestroyedLimitTextBox" ValidationGroup="EditGroup"/>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProcessingMethod1DropDownList" 
                                                      DataSourceID="DestructionMethodDataSource" 
                                                      DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("ProcessingMethod1.Id") %>'
                                                      CssClass="verySmallDropDownList" AppendDataBoundItems="True">
                                        <asp:ListItem Text="Brak" Value=""/>  
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="Installation2DropDownList" 
                                                      DataSourceID="InstallationsDataSource" DataTextField="Name" 
                                                      SelectedValue='<%# Bind("Installation2.Id") %>'
                                                      DataValueField="Id" AppendDataBoundItems="True" CssClass="verySmallDropDownList">
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanTransportCheckBox" runat="server" 
                                                  Checked='<%# Bind("CanTransport") %>' CssClass="defaultCheckBox"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanCollectCheckBox" runat="server" 
                                                  Checked='<%# Bind("CanCollect") %>' CssClass="defaultCheckBox" />
                                </td>
                                <td>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                                                    Text="Zapisz" ValidationGroup="EditGroup" />
                                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                                    Text="Anuluj" />
                                </td>
                            </tr>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <tr>
                                <td>
                                    <asp:DropDownList runat="server" ID="WasteCodesDropDownList2"
                                                      DataSourceID="WasteCodesDataSource" CssClass="verySmallDropDownList"
                                                      DataTextField="Name" DataValueField="Id"/>
                                </td>
                                <td>
                                    <asp:TextBox ID="CreatedLimitTextBox2" runat="server" 
                                                 Text='<%# Bind("CreatedLimit") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="CreatedLimitTextBox2" ID="F12"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="REV12" runat="server" 
                                                                    ErrorMessage="* podano błędną liczbę" Display="Dynamic"
                                                                    ValidationExpression="^\d+([,]\d+)?$" ControlToValidate="CreatedLimitTextBox2" ValidationGroup="INSERTGroup"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CreatedPgoCheckBox2" runat="server" 
                                                  Checked='<%# Bind("CreatedPgo") %>' CssClass="defaultCheckBox" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="InstallationDropDownList2" DataSourceID="InstallationsDataSource"
                                                      DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True"
                                                      CssClass="verySmallDropDownList">
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="RecycledLimitTextBox2" runat="server" 
                                                 Text='<%# Bind("RecycledLimit", "{0:F4}") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="RecycledLimitTextBox2" ID="FilteredTextBoxExtender12"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" 
                                                                    ErrorMessage="* podano błędną liczbę" Display="Dynamic" ValidationExpression="^\d+([,]\d+)?$" 
                                                                    ControlToValidate="RecycledLimitTextBox2" ValidationGroup="INSERTGroup"/>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProcessingMethodDropDownList2" 
                                                      DataSourceID="RecyclingMethodDataSource" DataTextField="Name" 
                                                      DataValueField="Id" CssClass="verySmallDropDownList"
                                                      AppendDataBoundItems="True">
                                        <asp:ListItem Text="Brak" Value=""></asp:ListItem>    
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="Installation1DropDownList2" DataSourceID="InstallationsDataSource" DataTextField="Name" 
                                                      DataValueField="Id" AppendDataBoundItems="True" CssClass="verySmallDropDownList">
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="DestroyedLimitTextBox2" runat="server" 
                                                 Text='<%# Bind("DestroyedLimit") %>' CssClass="verySmallTextBox"/>
                                    <asp:FilteredTextBoxExtender runat="server" TargetControlID="DestroyedLimitTextBox2" ID="FilteredTextBoxExtender22"
                                                                 FilterType="Numbers,Custom" ValidChars=","/>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server" Display="Dynamic"
                                                                    ErrorMessage="* podano błedną liczbę" ValidationExpression="^\d+([,]\d+)?$" ControlToValidate="DestroyedLimitTextBox2" ValidationGroup="INSERTGroup"/>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProcessingMethod1DropDownList2" 
                                                      DataSourceID="DestructionMethodDataSource" 
                                                      DataTextField="Name" DataValueField="Id"
                                                      CssClass="verySmallDropDownList" AppendDataBoundItems="True">
                                        <asp:ListItem Text="Brak" Value=""/>  
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="Installation2DropDownList2" 
                                                      DataSourceID="InstallationsDataSource" DataTextField="Name" 
                                                      DataValueField="Id" AppendDataBoundItems="True" CssClass="verySmallDropDownList">
                                        <asp:ListItem Text="Brak" Value=""/>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanTransportCheckBox2" runat="server" 
                                                  Checked='<%# Bind("CanTransport") %>' CssClass="defaultCheckBox"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanCollectCheckBox2" runat="server" 
                                                  Checked='<%# Bind("CanCollect") %>' CssClass="defaultCheckBox" />
                                </td>
                                <td>
                                    <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" 
                                                    Text="Dodaj" ValidationGroup="INSERTGroup"/>
                                    <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                                    Text="Anuluj"/>
                                </td>
                            </tr>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="WasteCodeLabel" runat="server" Text='<%# Eval("WasteCode.Name") %>'/>
                                </td>
                                <td class="alignright">
                                    <asp:Label ID="CreatedLimitLabel" runat="server" 
                                               Text='<%# Eval("CreatedLimit", "{0:F4}") %>' />
                                </td>
                                <td>
                                    <asp:CheckBox ID="CreatedPgoCheckBox" runat="server" 
                                                  Checked='<%# Eval("CreatedPgo") %>' Enabled="false" />
                                </td>
                                <td>
                                    <asp:Label ID="InstallationLabel" runat="server" 
                                               Text='<%# Eval("Installation") != null ? Eval("Installation.Name") : "---" %>' />
                                </td>
                                <td class="alignright">
                                    <asp:Label ID="RecycledLimitLabel" runat="server" 
                                               Text='<%# Eval("RecycledLimit", "{0:F4}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" 
                                               Text='<%# Eval("ProcessingMethod") != null ? Eval("ProcessingMethod.Name") : "---" %>'/>
                                </td>
                                <td>
                                    <asp:Label ID="Installation1Label" runat="server" 
                                               Text='<%# Eval("Installation1") != null ? Eval("Installation1.Name") : "---" %>' />
                                </td>
                                <td class="alignright">
                                    <asp:Label ID="DestroyedLimitLabel" runat="server" 
                                               Text='<%# Eval("DestroyedLimit", "{0:F4}") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="ProcessingMethod1Label" runat="server" 
                                               Text='<%# Eval("ProcessingMethod1") != null ? Eval("ProcessingMethod1.Name") : "---" %>'/>
                                </td>
                                <td>
                                    <asp:Label ID="Installation2Label" runat="server" 
                                               Text='<%# Eval("Installation2") != null ? Eval("Installation2.Name") : "---" %>' />
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanTransportCheckBox" runat="server" 
                                                  Checked='<%# Eval("CanTransport") %>' Enabled="false" CssClass="defaultCheckBox" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="CanCollectCheckBox" runat="server" 
                                                  Checked='<%# Eval("CanCollect") %>' Enabled="false" CssClass="defaultCheckBox"/>
                                </td>
                                <td>
                                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" 
                                                    Text="Edytuj" />
                                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                                                    Text="Usuń" OnClientClick="javascript: return DeleteSurety();"/>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table ID="itemPlaceholderContainer" runat="server" class="dataTable">
                                <tr runat="server">
                                    <th rowspan="2" id="Th1" runat="server">Kod odpadu: </th>
                                    <th colspan="3">Wytwarzanie</th>
                                    <th colspan="3">Odzysk</th>
                                    <th colspan="3">Unieszkodliwianie</th>
                                    <th rowspan="2" runat="server" id="Th11">Trans- <br />port</th>
                                    <th rowspan="2" runat="server" id="Th12">Zbie- <br />ranie</th>
                                    <th rowspan="2" runat="server"></th>
                                </tr>
                                <tr>
                                    <th id="Th2">Masa [Mg]</th>
                                    <th id="Th3">PGO</th>
                                    <th id="Th4">Instalacja</th>
                                    <th id="Th5">Masa [Mg]</th>
                                    <th id="Th6">Metoda</th>
                                    <th id="Th7">Instalacja</th>
                                    <th id="Th8">Masa [Mg]</th>
                                    <th id="Th9">Metoda</th>
                                    <th id="Th10">Instalacja</th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server"></tr>
                            </table>
                        </LayoutTemplate>
                    </asp:ListView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>