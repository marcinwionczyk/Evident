<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true"
    CodeBehind="Company.aspx.cs" Inherits="EVident.Company1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="toolkitScriptManager" runat="server" />
    <h3>
        Dane firmy</h3>
    <table class="groupingTable">
        <tr>
            <td colspan="2">
                <asp:Panel runat="server" GroupingText="Dane podstawowe">
                    <table class="layoutTable">
                        <tr>
                            <td>
                                Login:
                            </td>
                            <td>
                                <asp:TextBox ID="loginTextBox" CssClass="mediumTextBox" runat="server"></asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="loginTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Nr domu:
                            </td>
                            <td>
                                <asp:TextBox ID="buildingNumberTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" 
                                    ControlToValidate="buildingNumberTextBox" Display="Dynamic" 
                                    ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Nazwa pełna:
                            </td>
                            <td>
                                <asp:TextBox ID="fullNameTextBox" CssClass="mediumTextBox" runat="server"></asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="fullNameTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Nr lokalu:
                            </td>
                            <td>
                                <asp:TextBox ID="flatNumberTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" 
                                    ControlToValidate="flatNumberTextBox" Display="Dynamic" 
                                    ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Nazwa skrócona:
                            </td>
                            <td>
                                <asp:TextBox ID="shortNameTextBox" CssClass="mediumTextBox" runat="server"></asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="shortNameTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                NIP:
                            </td>
                            <td>
                                <asp:TextBox ID="nipTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="nipTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Numer rejestrowy:<br />
                            </td>
                            <td>
                                <asp:TextBox ID="registerNumberTextBox" CssClass="mediumTextBox" runat="server"></asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" 
                                    ControlToValidate="registerNumberTextBox" Display="Dynamic" 
                                    ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                REGON:
                            </td>
                            <td>
                                <asp:TextBox ID="regonTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Województwo:
                            </td>
                            <td>
                                <asp:DropDownList ID="provinceDropDownList" CssClass="mediumDropDownList" runat="server"
                                    OnSelectedIndexChanged="ProvinceDropDownListSelectedIndexChanged" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Telefon:
                            </td>
                            <td>
                                <asp:TextBox ID="phoneTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Powiat:
                            </td>
                            <td>
                                <asp:DropDownList ID="districtDropDownList" CssClass="mediumDropDownList" runat="server"
                                    AutoPostBack="True" OnSelectedIndexChanged="DistrictDropDownListSelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Fax:
                            </td>
                            <td>
                                <asp:TextBox ID="faxTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Gmina:
                            </td>
                            <td>
                                <asp:DropDownList ID="communeDropDownList" CssClass="mediumDropDownList" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td>
                                E-Mail:
                            </td>
                            <td>
                                <asp:TextBox ID="emailTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Miejscowość:
                            </td>
                            <td>
                                <asp:TextBox ID="placeTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="placeTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Rozpoczęcie działalności:
                            </td>
                            <td>
                                <asp:TextBox ID="startDateTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="startDateTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                                <asp:CalendarExtender ID="startDateCalendarExtender" TargetControlID="startDateTextBox"
                                    runat="server" DefaultView="Years" Format="yyyy-MM-dd">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Kod pocztowy:</td>
                            <td>
                                <asp:TextBox ID="postCodeTextBox" runat="server" CssClass="mediumTextBox"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="postCodeTextBox" Display="Dynamic" 
                                    ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                Zakończenie działalności:
                            </td>
                            <td>
                                <asp:TextBox ID="endDateTextBox" runat="server" CssClass="mediumTextBox"></asp:TextBox>
                                <asp:CalendarExtender ID="endDateTextBox_CalendarExtender" runat="server" 
                                    DefaultView="Years" Format="yyyy-MM-dd" TargetControlID="endDateTextBox">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Ulica:
                            </td>
                            <td>
                                <asp:TextBox ID="streetTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" ControlToValidate="streetTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel GroupingText="Dane osoby sporządzającej sprawozdanie" runat="server">
                    <table class="layoutTable">
                        <tr>
                            <td>
                                Imię:
                            </td>
                            <td>
                                <asp:TextBox ID="businessFirstNameTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Nazwisko:
                            </td>
                            <td>
                                <asp:TextBox ID="businessLastNameTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Telefon:
                            </td>
                            <td>
                                <asp:TextBox ID="businessPhoneTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Fax:
                            </td>
                            <td>
                                <asp:TextBox ID="businessFaxTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                E-Mail:
                            </td>
                            <td>
                                <asp:TextBox ID="businessEmailTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel GroupingText="PKD firmy" runat="server">
                    <table class="layoutTable">
                        <tr>
                            <td>Lista kodów PKD:</td>
                            <td>
                                <asp:ListBox ID="pkdListBox" CssClass="smallListBox" runat="server"></asp:ListBox>
                            </td>
                            <td>
                                <asp:Button ID="deletePkdButton" CssClass="mediumButton" runat="server" 
                                    Text="Usuń zaznaczony" onclick="DeletePkdButtonClick" />
                            </td>
                        </tr>
                        <tr>
                            <td>Wpisz kod:</td>
                            <td>
                                <asp:TextBox ID="pkdTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="ADD_PKD"></asp:TextBox>
                                <br /><asp:RequiredFieldValidator runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="pkdTextBox" 
                                    ValidationGroup="ADD_PKD"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Button ID="addPkdButton" CssClass="mediumButton" runat="server" 
                                    Text="Dodaj do listy" onclick="AddPkdButtonClick" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <asp:Panel ID="Panel1" runat="server" GroupingText="Numer rejestrowy ZSEiE">
                    <table class="layoutTable">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label1" runat="server" Text="Nr rejestrowy ZSEiE: " ToolTip="zgodnie z Dz. U. Nr 141 poz. 1156"/>
                                <asp:TextBox ID="TBRegisterNumber" runat="server" CssClass="mediumTextBox" MaxLength="7"/>
                                    <asp:FilteredTextBoxExtender ID="TBRegisterNumber_FilteredTextBoxExtender" runat="server"
                                        FilterType="Numbers" TargetControlID="TBRegisterNumber"/>
                                    <asp:TextBoxWatermarkExtender runat="server" TargetControlID="TBRegisterNumber" WatermarkText="7 cyfr z numeru rejestrowego ZSEiE" 
                                        ID="TBRegisterNumber_WaterMarkExtender" WatermarkCssClass="mediumTextBox"/>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                        ErrorMessage="Nieprawidłowy format numeru. Podaj 7 cyfr z numeru ZSEiE Wzór w Dz. U. Nr 141 poz. 1156"
                                        ControlToValidate="TBRegisterNumber" ValidationGroup="ValidateContractor" 
                                        ValidationExpression="^d{7}$">&nbsp;</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBoxList ID="EconomicActivityCheckBoxList1" runat="server">
                                        <asp:ListItem Text="W - wprowadzający sprzęt"/>
                                        <asp:ListItem Text="S - organizacja odzysku sprzętu elektrycznego i elektronicznego"/>
                                        <asp:ListItem Text="Z - działalność w zakresie zbierania"/>
                                        <asp:ListItem Text="P - działalność w zakresie przetwarzania"/>
                                    </asp:CheckBoxList>
                                    
                            </td>
                            <td>
                                <asp:CheckBoxList runat="server" ID="EconomicActivityCheckBoxList2">
                                    <asp:ListItem Text="R - działalność w zakresie recyklingu"/>
                                        <asp:ListItem Text="X - działalność obejmująca inne niż recykling procesy odzysku"/>
                                        <asp:ListItem Text="BW - wprowadzający do obrotu baterie i akumulatory"/>
                                        <asp:ListItem Text="BP - działalność w zakresie przetwarzania zużytych baterii lub akumulatorów"/>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <span class="smaller">Zaznaczenie opcji "BW" i "BP" da w rezultacie zakończenie numeru rejestrowego "BWP"</span>
                            </td>
                        </tr>
                    </table>
                                
                            
                                    
                </asp:Panel>
            </td>
        </tr>
    </table>

    <p style="text-align: right; margin-right: 3px;">
        <asp:Button ID="updateButton" CssClass="mediumButton" runat="server" Text="Aktualizuj"
            OnClick="UpdateButtonClick" />
    </p>
</asp:Content>
