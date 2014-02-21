<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DpoPrintViewControl.ascx.cs" Inherits="EVident.UserControl.DpoPrintViewControl" %>

<table class="dataTable">
    <tr>
        <th colspan="3">
            DOKUMENT POTWIERDZAJĄCY ODZYSK<br />
            za
            <asp:Literal ID="yearLiteralA" runat="server" />
            rok
        </th>
    </tr>
    <tr>
        <td style="width: 20%;">
            <span style="font-weight: bold;"><asp:Literal ID="customLetterLiteral" runat="server" /></span><br />
            <asp:Literal ID="customTitleLiteral" runat="server" />
        </td>
        <td style="width: 30%;">
            Nr dokumentu<br />
            <br />
            <asp:Literal ID="dpoNumberLiteralA" runat="server" />
        </td>
        <td>
            Zezwolenie na odzysk<br />
            <br />
            <asp:Literal ID="decisionNumberLiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Przedsiębiorca (organizacja odzysku) przekazujący odpad<br />
            <br />
            <asp:Literal ID="transferorLiteralA" runat="server" />
        </td>
        <td>
            Prowadzący odzysk<br />
            <br />
            <asp:Literal ID="receiverLiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Adres<br />
            <br />
            <asp:Literal ID="transferorAddressLiteralA" runat="server" />
        </td>
        <td>
            Adres<br />
            <br />
            <asp:Literal ID="receiverAddressLiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Telefon/faks<br />
            <asp:Literal ID="transferorPhoneFaxLiteralA" runat="server" />
        </td>
        <td>
            Telefon/faks<br />
            <asp:Literal ID="receiverPhoneFaxLiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            NIP<br />
            <asp:Literal ID="transferorNipLiteralA" runat="server" />
        </td>
        <td>
            NIP<br />
            <asp:Literal ID="receiverNipLiteralA" runat="server" />
        </td>
    </tr>
</table>
<br />
<br />
<span>Dział 1. Rodzaj oraz masa lub ilość odpadów opakowaniowych lub poużytkowych przyjętych
    do odzysku.</span>
<br />
<br />
<table class="dataTable">
    <tr>
        <td>
            Lp.
        </td>
        <td>
            Kod odpadu
        </td>
        <td>
            Rodzaj odpadu
        </td>
        <td>
            Jednostka
        </td>
        <td>
            Masa lub ilość przyjętych do odzysku odpadów opakowaniowych lub poużytkowych
        </td>
        <td>
            Proces odzysku
        </td>
    </tr>
    <asp:Literal ID="firstTableLiteralA" runat="server" />
</table>
<br />
<br />
<span>Dział 2. Rodzaj oraz masa odpadów opakowaniowych poddanych odzyskowi, w tym termicznemu przekształceniu w spalarniach i współspalarniach odpadów z odzyskiem energii.</span>
<br />
<br />
<table class="dataTable">
    <tr>
        <td colspan="2" rowspan="2">
            Rodzaj opakowania, z którego powstał odpad
        </td>
        <td rowspan="2">
            Przyjęte do odzysku odpady
        </td>
        <td colspan="7">
            Odpady poddane odzyskowi, w tym termicznemu przekształcaniu z odzyskiem energii, w wyniku
        </td>
    </tr>
    <tr>
        <td>
            recyklingu materiału
        </td>
        <td>
            innych form recyklingu
        </td>
        <td>
            łącznego recyklingu
        </td>
        <td>
            termicznego przekształcania odpadów we współspalarniach odpadów z odzyskiem energii
        </td>
        <td>
            termicznego przekształcania odpadów w spalarniach odpadów z odzyskiem energii
        </td>
        <td>
            innych sposobów odzysku
        </td>
        <td>
            łącznego odzysku lub termicznego przekształcania odpadów w spalarniach i współspalarniach odpadów z odzyskiem energii
        </td>
    </tr>
    <tr>
        <td colspan="2">
            1
        </td>
        <td>
            2
        </td>
        <td>
            3
        </td>
        <td>
            4
        </td>
        <td>
            5
        </td>
        <td>
            6
        </td>
        <td>
            7
        </td>
        <td>
            8
        </td>
        <td>
            9
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Opakowania ze szkła gospodarczego, poza ampułkami
        </td>
        <td>
            <asp:Literal ID="_00LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_01LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_02LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_03LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_04LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_05LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_06LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_07LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Opakowania z tworzyw sztucznych
        </td>
        <td>
            <asp:Literal ID="_10LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_11LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_12LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_13LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_14LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_15LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_16LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_17LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Opakowania z papieru i tektury
        </td>
        <td>
            <asp:Literal ID="_20LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_21LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_22LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_23LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_24LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_25LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_26LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_27LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td rowspan="3">
            Opakowania z metali
        </td>
        <td>
            Opakowania z aluminium
        </td>
        <td>
            <asp:Literal ID="_30LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_31LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_32LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_33LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_34LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_35LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_36LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_37LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            Opakowania ze stali, w tym blachy stalowej
        </td>
        <td>
            <asp:Literal ID="_40LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_41LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_42LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_43LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_44LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_45LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_46LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_47LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            razem
        </td>
        <td>
            <asp:Literal ID="_50LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_51LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_52LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_53LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_54LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_55LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_56LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_57LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Opakowania z drewna
        </td>
        <td>
            <asp:Literal ID="_60LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_61LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_62LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_63LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_64LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_65LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_66LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_67LiteralA" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Razem
        </td>
        <td>
            <asp:Literal ID="_70LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_71LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_72LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_73LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_74LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_75LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_76LiteralA" runat="server" />
        </td>
        <td>
            <asp:Literal ID="_77LiteralA" runat="server" />
        </td>
    </tr>
</table>
<br />
<br />
Potwierdzam przyjęcie odpadu, zobowiązując się jednocześnie do jego recyklingu.
<br />
<br />
<br />
.............................................<br />
(data, pieczęć i podpis)
