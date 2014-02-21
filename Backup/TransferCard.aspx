<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="TransferCard.aspx.cs" Inherits="EVident.TransferCard" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
             Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <h3>Karty Przekazania odpadów</h3>
    <p>
        Karty wydawane przy <asp:DropDownList ID="IsCollectionDDL" runat="server" 
                                              CssClass="mediumDropDownList" AutoPostBack="True" 
                                              onselectedindexchanged="IsCollectionDDLSelectedIndexChanged">
                                <asp:ListItem Text="przyjęciu odpadów" Value="0"/>
                                <asp:ListItem Text="przekazaniu odpadów" Value="1"/>
                            </asp:DropDownList></p>
    <asp:MultiView ID="MultiView" runat="server">
        <asp:View ID="CollectionView" runat="server">
            <asp:ListView ID="CollectionListView" runat="server" DataKeyNames="Id" 
                onitemdatabound="CollectionListViewItemDataBound" 
                onitemcommand="CollectionListViewItemCommand">
                <EmptyDataTemplate>
                    <table id="Table1" runat="server" style="">
                        <tr>
                            <td>
                                Brak w bazie danych informacji o Kartach Przekazania Odpoadów.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <LayoutTemplate>
                    <table ID="itemPlaceholderContainer" runat="server" border="0" class="dataTable">
                        <tr id="Tr1" runat="server">
                            <th id="Th1" runat="server">Numer KPO</th>
                            <th id="Th2" runat="server">Kontrahent</th>
                            <th id="Th3" runat="server">Metoda transportu</th>
                            <th id="Th5" runat="server">Kod odpadu</th>
                            <th id="Th6" runat="server"></th>
                        </tr>
                        <tr ID="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="TransferCardNumberLabel" runat="server" 
                                       Text='<%# Eval("TransferCardNumber") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ContractorLabel" runat="server" 
                                       Text='<%# Eval("Contractor.FullName") %>' />
                        </td>
                        <td>
                            <asp:Literal ID="TransportWayLiteral" runat="server" Mode="PassThrough"/>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="WasteCodeNameLabel"/>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="print" OnClientClick="aspnetForm.target ='_blank';" CommandArgument='<%# Eval("Id") %>'>Podgląd</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                
            </asp:ListView>
        </asp:View>
        <asp:View ID="TransferView" runat="server">
            <asp:ListView ID="TransferListView" runat="server" 
                onitemdatabound="TransferListViewItemDataBound" 
                onitemcommand="TransferListViewItemCommand">
                <EmptyDataTemplate>
                    <table id="Table1" runat="server" style="">
                        <tr>
                            <td>
                                Brak w bazie danych informacji o Kartach Przekazania Odpoadów.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <LayoutTemplate>
                    <table ID="itemPlaceholderContainer" runat="server" border="0" class="dataTable">
                        <tr id="Tr1" runat="server">
                            <th id="Th1" runat="server">Numer KPO</th>
                            <th id="Th2" runat="server">Kontrahent</th>
                            <th id="Th3" runat="server">Metoda transportu</th>
                            <th id="Th5" runat="server">Kod odpadu</th>
                            <th id="Th6" runat="server"></th>
                        </tr>
                        <tr ID="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="TransferCardNumberLabel" runat="server" 
                                       Text='<%# Eval("TransferCardNumber") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ContractorLabel" runat="server" 
                                       Text='<%# Eval("Contractor.FullName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="TransportWayLabel" runat="server"/> <br/>
                            <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("TransportContractor.FullName") %>'/>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="WasteCodeNameLabel"/>
                        </td>
                        <td>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="print" OnClientClick="aspnetForm.target ='_blank';" CommandArgument='<%# Eval("Id") %>'>Podgląd</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </asp:View>
    </asp:MultiView>

    
    <br />


</asp:Content>