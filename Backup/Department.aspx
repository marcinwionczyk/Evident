<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true"
    CodeBehind="Department.aspx.cs" Inherits="EVident.Department1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <style type="text/css">
        .style1
        {
            width: 171px;
        }
        .style2
        {
            width: 354px;
        }
        .style3
        {
            width: 651px;
        }
        .style4
        {
            height: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ToolkitScriptManager ID="toolkitScriptManager" runat="server" />
    <h3>
        Dane Oddziału</h3>
    <table class="groupingTable">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Panel ID="Panel2" GroupingText="Lista oddziałów" runat="server" 
                    Height="281px" Width="243px">
                    <br />
                    <asp:ListBox ID="oddzialyListBox" runat="server" AutoPostBack="True" 
                        CssClass="smallListBox" 
                        onselectedindexchanged="oddzialyListBox_SelectedIndexChanged"></asp:ListBox>
                    <br />
                    <br />
                    <asp:Button ID="Dodaj" runat="server" Text="Dodaj" onclick="Dodaj_Click" 
                        CssClass="mediumButton" />
                    <br />
                    <br />
                    <asp:Button ID="usunButton" runat="server" CssClass="mediumButton" 
                        onclick="usunButton_Click" Text="Usuń" />
                    <br />
                    <br />
                </asp:Panel>
            </td>
            <td class="style3">
                <asp:Panel ID="Panel3" GroupingText="Dane oddziału" runat="server">
                    <table class="layoutTable">
                        <tr>
                            <td>Nazwa:</td>

                            <td> 
                                <asp:TextBox ID="nazwaTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="AddOddzial" Width="156px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="nazwaTextBox" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                           </td>
                        
                        </tr>
                        <tr>
                            <td>Kod pocztowy</td>
                            <td>Miasto</td>
                            <td></td>
                            <td>Województwo</td>
                        </tr>
                        <tr>
                            <td> 
                                <asp:TextBox ID="kodPocztowyTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="AddOddzial" Width="112px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="kodPocztowyTextBox" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                           </td>

                           <td> 
                                <asp:TextBox ID="miastoTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="AddOddzial" Width="140px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="miastoTextBox" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                           </td>

                            <td>                        
                                                    
                            </td>

                            <td>
                                <asp:DropDownList ID="provinceDropDownList" runat="server" Height="22px" 
                                    Width="142px" AutoPostBack="True" CssClass="mediumDropDownList" 
                                    onselectedindexchanged="ProvinceDropDownListSelectedIndexChanged">
                                </asp:DropDownList>    
                            
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                    ControlToValidate="miastoTextBox" ErrorMessage="* pole nie może być puste" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                            
                            </td>
                        </tr>
                        <tr>
                            <td>Ulica</td>
                            <td>Nr domu</td>
                            <td>Nr lokalu</td>
                            <td>Powiat</td>
                        </tr>
                        <tr>
                            <td> 
                                <asp:TextBox ID="ulicaTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="AddOddzial" Width="158px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="ulicaTextBox" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                           </td>
                            <td> 
                                <asp:TextBox ID="nrDomuTextBox" CssClass="smallTextBox" runat="server" 
                                    ValidationGroup="AddOddzial" Width="73px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                    ErrorMessage="* pole nie może być puste" ControlToValidate="nrDomuTextBox" 
                                    ValidationGroup="AddOddzial"></asp:RequiredFieldValidator>
                           </td>
                            <td> 
                                <asp:TextBox ID="nrLokaluTextBox" CssClass="smallTextBox" runat="server" 
                                    Width="73px"></asp:TextBox>
                                <br />
                           </td>
                            <td>
                                <asp:DropDownList ID="districtDropDownList" runat="server" Height="22px" 
                                    Width="142px" AutoPostBack="True" CssClass="mediumDropDownList" 
                                    onselectedindexchanged="DistrictDropDownListSelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Telefon</td>
                            <td>Faks</td>
                            <td></td>
                            <td>Gmina</td>
                        </tr>
                        <tr>
                            <td> 
                                <asp:TextBox ID="telefonTextBox" CssClass="smallTextBox" runat="server" 
                                    Width="139px"></asp:TextBox>
                                <br />
                           </td>
                            <td> 
                                <asp:TextBox ID="faksTextBox" CssClass="mediumTextBox" runat="server" 
                                    Width="135px"></asp:TextBox>
                                <br />
                           </td>
                            <td></td>
                            <td>
                                <asp:DropDownList ID="communeDropDownList" runat="server" Height="22px" 
                                    Width="142px" AutoPostBack="True" CssClass="mediumDropDownList">
                                </asp:DropDownList>
                            </td>
                        </tr>                        
                    </table>

                    <table class="groupingTable">
                        <tr>
                            <td class="style2">
                            
                                <asp:Panel ID="Panel4" runat="server" GroupingText="Pojazdy">
                                    <table class="layoutTable">
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                <asp:ListBox ID="pojazdyListBox" runat="server" CssClass="smallListBox">
                                                </asp:ListBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="deletePojazdyButton" runat="server" CssClass="mediumButton" 
                                                    onclick="deletePojazdyButton_Click" Text="Usuń zaznaczony" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Wpisz numer:</td>
                                            <td>
                                                <asp:TextBox ID="pojazdyTextBox" runat="server" 
                                                    CssClass="smallTextBox" ValidationGroup="pojazd"></asp:TextBox>
                                                <br />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="pojazdyTextBox" 
                                                    ErrorMessage="* pole nie może być puste" ValidationGroup="pojazd" 
                                                    ID="pojazdy"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                <asp:Button ID="addPojazdyButton" runat="server" CssClass="mediumButton" 
                                                    onclick="AddPkdButtonClick" Text="Dodaj do listy" 
                                                    ValidationGroup="pojazd" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                Data rozpoczęcia<br />
                                <asp:TextBox ID="startDateTextBox" CssClass="mediumTextBox" runat="server">
                                </asp:TextBox>
                                <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="startDateTextBox" 
                                    Display="Dynamic" ErrorMessage="* pole nie może być puste"></asp:RequiredFieldValidator>
                                <asp:CalendarExtender ID="startDateCalendarExtender" TargetControlID="startDateTextBox"
                                    runat="server" DefaultView="Years" Format="yyyy-MM-dd">
                                </asp:CalendarExtender>
                                <br />
                                <br />
                                Data zakończenia<br />
                                <asp:TextBox ID="endDateTextBox" runat="server" CssClass="mediumTextBox" 
                                    ValidationGroup="data"></asp:TextBox>
                                <asp:CalendarExtender ID="endDateTextBox_CalendarExtender" runat="server" 
                                    DefaultView="Years" Format="yyyy-MM-dd" TargetControlID="endDateTextBox">
                                </asp:CalendarExtender>
                                <br />
                                <br />
                                <br />
                                <br />
                                <asp:CheckBox ID="oddzialGlownyCheckBox" runat="server" 
                                    Text="Oddział główny (ten sam adres co firma)" 
                                    oncheckedchanged="oddzialGlownyCheckBox_CheckedChanged" 
                                    AutoPostBack="True" /> <br/>
                                <asp:CheckBox runat="server" ID="IsZSEiECheckBox" Text="Punkt zbierania ZSEiE"/>
                            </td>
                        </tr>
                        <tr>
                        <td class="style4">
                            <asp:Button ID="zapiszButton" runat="server" CssClass="mediumButton" 
                                onclick="zapiszButton_Click" Text="Zapisz" ValidationGroup="AddOddzial" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="anulujButton" runat="server" CssClass="mediumButton" 
                                Text="Anuluj" onclick="anulujButton_Click" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>

    <p style="text-align: right; margin-right: 3px;">
      
        &nbsp;</p>
    <p style="text-align: right; margin-right: 3px;">
      
        &nbsp;</p>
</asp:Content>
