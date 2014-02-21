<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="EVident.LogIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>
        Logowanie</h3>
    <table class="style1" align="center">
        <tr>
            <td class="grayLabel">
                Login:</td>
            <td class="style3">
                <asp:TextBox ID="loginTextBox" runat="server" CssClass="mediumTextBox"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="loginTextBox" ErrorMessage="RequiredFieldValidator" 
                    ValidationGroup="logowanie">Wprowadz login</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="grayLabel">
                Hasło:</td>
            <td class="style3">
                <asp:TextBox ID="hasloTextBox" runat="server" CssClass="mediumTextBox" 
                    TextMode="Password"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="hasloTextBox" ErrorMessage="RequiredFieldValidator" 
                    ValidationGroup="logowanie">Wprowadz hasło</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td class="style3">
                <asp:Label ID="komunikatLabel" runat="server" Text="Label" Visible="False" 
                    CssClass="error"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td class="style3">
                <asp:Button ID="zalogujButton" runat="server" CssClass="mediumButton" 
                    onclick="zalogujButton_Click" Text="Zaloguj" ValidationGroup="logowanie" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
