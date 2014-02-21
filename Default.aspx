<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EVident.Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    
    <table class="style1">
        <tr>
            <td>
                <h3>Strona główna</h3></td>
        </tr>
        <tr>
            <td>
                <br />
                <br />
                <br />
                <br />
                <asp:Button ID="Button1" runat="server" CssClass="mediumButton" 
                    PostBackUrl="~/LogIn.aspx" Text="Logowanie" Visible="false" />
            </td>
        </tr>
    </table>
    
</asp:Content>
