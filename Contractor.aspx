<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true"
         CodeBehind="Contractor.aspx.cs" Inherits="EVident.Contractor1" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
             Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.60501.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <script src="JavaScript.js" type="text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="toolkitScriptManager" runat="server" 
                              EnableScriptGlobalization="True" EnableScriptLocalization="True"/>
    <asp:TextBoxWatermarkExtender ID="TBSelectedVehicleNumber_TextBoxWatermarkExtender"
                                  runat="server" TargetControlID="TBSelectedVehicleNumber" WatermarkText="n.p. DW 12345, WRC 1234"
                                  WatermarkCssClass="largeTextBox">
    </asp:TextBoxWatermarkExtender>
    <h3>
        Kontrahenci</h3>
    <table class="groupingTable">
        <tr>
            <td>
                <asp:Panel ID="ContractorsListPanel" runat="server" Visible="true" GroupingText="Lista kontrahentów firmy">
                    <asp:GridView ID="GridViewContractors" runat="server" 
                                  EnableModelValidation="True" DataKeyNames="Id"
                                  AutoGenerateColumns="False" CssClass="dataTable" 
                                  onrowdatabound="GridViewContractors_RowDataBound" 
                                  onrowediting="GridViewContractors_RowEditing" 
                                  onrowcancelingedit="GridViewContractors_RowCancelingEdit" 
                                  onrowdeleting="GridViewContractors_RowDeleting" 
                                  onrowupdating="GridViewContractors_RowUpdating" 
                                  onselectedindexchanging="GridViewContractors_SelectedIndexChanging">
                        <SelectedRowStyle CssClass="selected"/>
                        <EditRowStyle CssClass="selected"/>
                        <Columns>
                            <asp:TemplateField HeaderText="Nazwa skrócona firmy" SortExpression="ShortName">
                                <ItemTemplate>
                                    <%-- <asp:HiddenField ID="GridViewIdHiddenLabel" runat="server" Value='<%# Eval("Id") %>' /> --%>
                                    <asp:Label Text='<%# Eval("ShortName") %>' runat="server" ID="GridViewShortNameLabel"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="SelectButton" runat="server" CausesValidation="False" 
                                                    CommandName="Select" Text="Szczegóły"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                                    CommandName="Edit" Text="Edytuj"/>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                                    CommandName="Update" Text="Aktualizuj"/>
                                    &nbsp;<asp:LinkButton ID="CancelUpdateButton" runat="server" CausesValidation="False" 
                                                          CommandName="Cancel" Text="Anuluj"/>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                                    CommandName="Delete" Text="Usuń" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Label ID="ContractorsListViewErrorLabel" runat="server" CssClass="error"/>

                    <br />
                    <asp:Button ID="ButtonNewContractor" runat="server" Text="Dodaj nowego kontrahenta"
                                OnClick="ButtonNewContractorClick" CssClass="largeButton" />
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="ContractorEditPanel" runat="server" Visible="false" GroupingText="Edycja danych kontrahenta" EnableViewState="True">
                    <asp:HiddenField ID="ContractorIdHiddenField" runat="server" />
                    <table class="layoutTable">
                        <tbody>
                            <tr>
                                <td>
                                    Nazwa:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBFullName" runat="server" TextMode="MultiLine"
                                                 CssClass="textarea" Width="400px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                                ControlToValidate="TBFullName" ValidationGroup="ContractorValidator" 
                                                                ErrorMessage="* proszę podać pełną nazwę firmy" Display="Dynamic"/>
                                </td>
                                <td>
                                    Nazwa
                                    <br />
                                    skrócona:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBShortName" runat="server" CssClass="largeTextBox" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                                ControlToValidate="TBShortName" ErrorMessage="* proszę podać skróconą nazwę firmy"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div style="width: inherit; margin-right: 215px">
                                        <div style="width: 37%; float: left">
                                            Województwo:&nbsp;&nbsp;&nbsp; 
                                            <asp:DropDownList ID="ProvinceList" DataValueField="Id"
                                                              DataTextField="Name" runat="server" AutoPostBack="true" 
                                                              CssClass="mediumDropDownList" 
                                                              onselectedindexchanged="ProvinceList_SelectedIndexChanged" />
                                        </div>     
                                        <div style="width: 31%; float: left; text-align: center">
                                            Powiat: 
                                            <asp:DropDownList ID="DistrictList" runat="server" AutoPostBack="true" CssClass="mediumDropDownList"
                                                              DataTextField="Name" DataValueField="Id" 
                                                              onselectedindexchanged="DistrictList_SelectedIndexChanged" />
                                        </div>
                                        <div style="width: 32%; float: right">
                                            <div style="float: right">
                                                Gmina: 
                                                <asp:DropDownList ID="CommuneList" runat="server" CssClass="mediumDropDownList"
                                                                  DataTextField="Name" DataValueField="Id" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Kod pocztowy:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBPostCode" runat="server" CssClass="largeTextBox" 
                                                 MaxLength="6"/>
                                    <asp:FilteredTextBoxExtender ID="TBPostCode_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="Numbers, Custom" TargetControlID="TBPostCode" 
                                                                 ValidChars="-">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:RegularExpressionValidator ID="PostCodeValidator" runat="server" 
                                                                    ControlToValidate="TBPostCode" ErrorMessage="<br /> * zły kod pocztowy" Display="Dynamic"
                                                                    ValidationExpression="^\d{2}-\d{3}$" ValidationGroup="ValidateContractor"/>
                                    <asp:RequiredFieldValidator ID="PostCodeRequiredValidator" runat="server" Display="Dynamic"
                                                                ControlToValidate="TBPostCode" ErrorMessage="<br /> * podaj numer pocztowy" 
                                                                ValidationGroup="ValidateContractor"/>
                                </td>
                                <td>
                                    Miejscowość:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBPlace" runat="server" CssClass="largeTextBox"/>
                                    <asp:FilteredTextBoxExtender ID="TBPlace_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="LowercaseLetters, UppercaseLetters, Custom" 
                                                                 TargetControlID="TBPlace" ValidChars="ąćęłńóśźżĄĆĘŁŃÓŚŻŹ- ">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:RequiredFieldValidator ID="PlaceRequiredFieldValidator" runat="server" Display="Dynamic"
                                                                ControlToValidate="TBPlace" ErrorMessage="<br /> * podaj nazwę miejscowości" 
                                                                ValidationGroup="ValidateContractor"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ulica:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBStreet" runat="server" CssClass="largeTextBox"/>
                                    <asp:FilteredTextBoxExtender ID="TBStreet_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="LowercaseLetters, UppercaseLetters, Custom" 
                                                                 TargetControlID="TBStreet" ValidChars="ąćęłńóśźżĄĆĘŁŃÓŚŻŹ- ">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:RequiredFieldValidator ID="StreetRequiredValidator" runat="server" Display="Dynamic"
                                                                ControlToValidate="TBStreet" ErrorMessage="<br /> * podaj nazwę ulicy" 
                                                                ValidationGroup="ValidateContractor"/>
                                </td>
                                <td>
                                    Nr budynku:
                                </td>
                                <td><div style="float: left">
                                        <asp:TextBox ID="TBBuildingNumber" runat="server"
                                                     CssClass="verySmallTextBox uppercase" />
                                    </div>
                                    <div style="float: right; margin-right: 215px;">
                                        Nr lokalu:
                                        <asp:TextBox ID="TBFlatNumber" runat="server" CssClass="verySmallTextBox" MaxLength="4" />
                                        <asp:FilteredTextBoxExtender ID="TBFlatNumber_FilteredTextBoxExtender" 
                                                                     runat="server" FilterType="Numbers" TargetControlID="TBFlatNumber">
                                        </asp:FilteredTextBoxExtender>
                                    </div>
                                    <div style="float: none">
                                        <asp:FilteredTextBoxExtender ID="TBBuildingNumber_FilteredTextBoxExtender" 
                                                                     runat="server" FilterType="Numbers, UppercaseLetters, LowercaseLetters" 
                                                                     TargetControlID="TBBuildingNumber">
                                        </asp:FilteredTextBoxExtender>
                                        <asp:RegularExpressionValidator ID="BuildingNumberValidator" runat="server" 
                                                                        ControlToValidate="TBBuildingNumber" Display="Dynamic"
                                                                        ErrorMessage=" * podano błedny numer budynku" 
                                                                        ValidationExpression="^\d+[a-zA-Z]?$" ValidationGroup="ValidateContractor"/>
                                        <asp:RequiredFieldValidator ID="BuildingNumberRequiredValidator" runat="server"
                                                                    ControlToValidate="TBBuildingNumber" ErrorMessage=" * podaj numer budunku" 
                                                                    Display="Dynamic" ValidationGroup="ValidateContractor"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    NIP:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBNIP" runat="server" CssClass="largeTextBox" MaxLength="13" />
                                    <asp:FilteredTextBoxExtender ID="TBNIP_FilteredTextBoxExtender" runat="server" 
                                                                 FilterType="Numbers, Custom" ValidChars="-" TargetControlID="TBNIP">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:CustomValidator ID="NipCustomValidator" runat="server" Display="Dynamic" SetFocusOnError="True"
                                                         ErrorMessage="<br /> * podano błędny numer NIP" ValidationGroup="ValidateContractor"
                                                         ControlToValidate="TBNIP" OnServerValidate="ValidateNip"/>
                                    <asp:RequiredFieldValidator ID="NIPRequiredValidator" runat="server" Display="Dynamic" 
                                                                ControlToValidate="TBNIP" ErrorMessage="<br /> * podaj numer NIP" 
                                                                ValidationGroup="ValidateContractor"/>
                                </td>
                                <td>
                                    REGON:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBREGON" runat="server" CssClass="largeTextBox"/>
                                    <asp:FilteredTextBoxExtender ID="TBREGON_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="Numbers, Custom" ValidChars="-" TargetControlID="TBREGON"/>
                                    <asp:CustomValidator ID="REGONCustomValidator" runat="server" ErrorMessage="<br /> * podano błędny numer REGON"
                                                         Display="Dynamic" ControlToValidate="TBREGON" ValidationGroup="ValidateContractor" SetFocusOnError="True"
                                                         OnServerValidate="ValidateREGON"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Telefon:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBPhone" runat="server" CssClass="largeTextBox"/>
                                    <asp:FilteredTextBoxExtender ID="TBPhone_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="Numbers, Custom" ValidChars="-" TargetControlID="TBPhone">
                                    </asp:FilteredTextBoxExtender>
                                </td>
                                <td>
                                    Fax:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBFax" runat="server" CssClass="largeTextBox"/>
                                    <asp:FilteredTextBoxExtender ID="TBFax_FilteredTextBoxExtender" runat="server" 
                                                                 FilterType="Numbers, Custom" ValidChars="-" TargetControlID="TBFax">
                                    </asp:FilteredTextBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="2">
                                    Numery rejestracyjne
                                    <br />
                                    pojazdów:
                                </td>
                                <td>
                                    <asp:TextBox ID="TBSelectedVehicleNumber" runat="server" 
                                                 CssClass="largeTextBox uppercase" MaxLength="9"/>
                                    <asp:FilteredTextBoxExtender ID="TBSelectedVehicleNumber_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="Custom, Numbers, UppercaseLetters, LowercaseLetters" 
                                                                 TargetControlID="TBSelectedVehicleNumber" ValidChars=" ">
                                    </asp:FilteredTextBoxExtender>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                                    ErrorMessage="* nieprawidłowy format numeru rejestracyjnego" ValidationExpression="^\w+[ ]\w+$"
                                                                    ValidationGroup="ValidateContractor" Display="Dynamic" ControlToValidate="TBSelectedVehicleNumber"/>
                                    <br />
                                </td>
                                <td>
                                    <asp:Label runat="server" Text="Nr rejestrowy ZSEiE:" 
                                               ToolTip="zgodnie z Dz. U. Nr 141 poz. 1156" />
                                </td>
                                <td>
                                    <asp:TextBox ID="TBRegisterNumber" runat="server" CssClass="largeTextBox" 
                                                 MaxLength="7" />
                                    <asp:FilteredTextBoxExtender ID="TBRegisterNumber_FilteredTextBoxExtender" 
                                                                 runat="server" FilterType="Numbers" TargetControlID="TBRegisterNumber" />
                                    <asp:TextBoxWatermarkExtender ID="TBRegisterNumber_WaterMarkExtender" 
                                                                  runat="server" TargetControlID="TBRegisterNumber" 
                                                                  WatermarkCssClass="largeTextBox" 
                                                                  WatermarkText="7 cyfr z numeru rejestrowego ZSEiE" />
                                    
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TBRegisterNumber" OnServerValidate="ValidateZSEiE"
                                                         ErrorMessage="<br /> * proszę podać siedmiocyfrową część numeru rejestrowego ZSEiE i jednocześnie zaznaczyć poniżej typ prowadzonej działalności kontrahenta. Wzór numeru znajduje się w Dz. U. Nr 141 poz. 1156"
                                                         ValidationGroup="ValidateContractor"/>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="float: left; margin-right: 30px">
                                        <asp:ListBox ID="ListBoxVehicleNumbers" runat="server" AutoPostBack="True" 
                                                     CssClass="smallListBox" 
                                                     OnSelectedIndexChanged="ListBoxVehicleNumbersSelectedIndexChanged" />
                                    </div>
                                    <div>
                                        <asp:Button ID="BtnChangeVehicleNumber" runat="server" CssClass="mediumButton" 
                                                    OnClick="BtnChangeVehicleNumberClick" Text="Zmień numer" 
                                                    ValidationGroup="ValidateVehicleNumber" />
                                        <br />
                                        <br />
                                        <asp:Button ID="BtnAddVehicleNumber" runat="server" CssClass="mediumButton" 
                                                    OnClick="BtnAddVehicleNumberClick" Text="Dodaj numer" 
                                                    ValidationGroup="ValidateVehicleNumber" />
                                        <br />
                                        <br />
                                        <asp:Button ID="BtnRemoveVehicleNumber" runat="server" CssClass="mediumButton" 
                                                    OnClick="BtnRemoveVehicleNumberClick" Text="Usuń numer" />
                                    </div>
                                    <p>
                                        <asp:Label ID="VehicleNumberErrors" runat="server" CssClass="error"/>
                                    </p>
                                </td>
                                <td colspan="2" rowspan="1">
                                    <asp:CheckBoxList ID="EconomicActivityCheckBoxList" runat="server" >
                                        <asp:ListItem Text="W - wprowadzający sprzęt" />
                                        <asp:ListItem Text="S - organizacja odzysku sprzętu elektrycznego i elektronicznego" />
                                        <asp:ListItem Text="Z - działalność w zakresie zbierania" />
                                        <asp:ListItem Text="P - działalność w zakresie przetwarzania" />
                                        <asp:ListItem Text="R - działalność w zakresie recyklingu" />
                                        <asp:ListItem Text="X - działalność obejmująca inne niż recykling procesy odzysku" />
                                        <asp:ListItem Text="BW - wprowadzający do obrotu baterie i akumulatory" />
                                        <asp:ListItem Text="BP - działalność w zakresie przetwarzania zużytych baterii lub akumulatorów" />
                                    </asp:CheckBoxList>
                                    <p class="smaller">
                                        Zaznaczenie opcji &quot;BW&quot; i &quot;BP&quot; da w rezultacie zakończenie numeru rejestrowego 
                                        &quot;BWP&quot;</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <p style="font-size: large">
                        Wybierz kody odpadów, które ten kontrahent może przyjmować:</p>
                    <p>
                        Dostępne kody odpadów:</p>
                    <div>
                        <asp:ListBox ID="ListBoxWasteCodes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ListBoxWasteCodesSelectedIndexChanged"
                                     Rows="10" CssClass="twoColumnListBox"/>
                        <asp:ListSearchExtender ID="ListBoxWasteCodes_ListSearchExtender" runat="server"
                                                TargetControlID="ListBoxWasteCodes" PromptText="Pisz aby wyszukac">
                        </asp:ListSearchExtender>
                    </div>
                    <p>
                        Wybrane kody odpadów:
                    </p>
                    <asp:ListBox ID="ListBoxSelectedWasteCodes" runat="server" SelectionMode="Multiple"
                                 CssClass="twoColumnListBox" Height="246" AutoPostBack="True" />
                    <br />
                    <br />
                    <asp:Button ID="BtnRemoveWasteCode" runat="server" OnClick="BtnRemoveWasteCodeClick"
                                Text="Usuń kod" CssClass="smallButton" />
                    <br />
                    <br />
                    <div style="float: right; width: 250px;">
                        <asp:Button ID="SaveContractorButton" runat="server" OnClick="SaveContractorButtonClick"
                                    Text="Zapisz" ValidationGroup="ValidateContractor" CssClass="smallButton" />
                        &nbsp; &nbsp;
                        <asp:Button ID="CancelButton" runat="server" Text="Anuluj" CssClass="smallButton"
                                    OnClick="CancelButtonClick" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="ContractorDetailsPanel" runat="server" Visible="false" GroupingText="Szczegółowe dane kontrahenta">
                    <a id="#select"></a>
                    <asp:DetailsView ID="ContractorDetailsView" runat="server" Height="50px" EnableModelValidation="True"
                                     AutoGenerateRows="False" CssClass="dataTable">
                        <Fields>
                            <asp:BoundField DataField="fullname" HeaderText="Nazwa:" />
                            <asp:BoundField DataField="shortname" HeaderText="Nazwa skrócona:" ReadOnly="true" />
                            <asp:BoundField DataField="province" HeaderText="Województwo:" ReadOnly="true" />
                            <asp:BoundField DataField="district" ReadOnly="true" HeaderText="Powiat:" />
                            <asp:BoundField DataField="commune" ReadOnly="true" HeaderText="Gmina:" />
                            <asp:BoundField DataField="adres" ReadOnly="true" HeaderText="Adres:" />
                            <asp:BoundField DataField="nip" ReadOnly="true" HeaderText="NIP:" />
                            <asp:BoundField DataField="regon" ReadOnly="true" HeaderText="REGON:" />
                            <asp:BoundField DataField="phone" ReadOnly="true" HeaderText="Telefon:" />
                            <asp:BoundField DataField="fax" ReadOnly="true" HeaderText="Fax:" />
                            <asp:BoundField DataField="registernumber" ReadOnly="True" HeaderText="Numer rejestrowy ZSEiE:"/>
                            <asp:BoundField DataField="vehiclenumbers" ReadOnly="true" HeaderText="Numery rejestracyjne pojazdów:" />
                            <asp:BoundField DataField="wastecodes" ReadOnly="true" HeaderText="Kontrahent może przyjmować odpady:"
                                            HtmlEncode="false" />
                        </Fields>
                    </asp:DetailsView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>