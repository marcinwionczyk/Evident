<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AnnualReportSection7Table.ascx.cs" Inherits="EVident.UserControl.AnnualReportSection7Table" %>

<table id="section7Table" runat="server" class="miniDataTable">
    <tr>
        <th rowspan="3">Lp.</th>
        <th rowspan="3">Nazwa instalacji lub urządzenia</th>
        <th rowspan="3">Współrzędne geograficzne</th>
        <th rowspan="3">Rodzaj instalacji lub urządzenia</th>
        <th rowspan="3">Typ procesu przetwarzania odpadów</th>
        <th rowspan="3">Roczna ilość odpadów dopuszczona do odzysku lub unieszkodliwiania określona w decyzji [Mg/rok]</th>
        <th rowspan="3">Projektowana moc przerobowa [Mg/rok]</th>
        <th rowspan="3">Proces R lub D</th>
        <th colspan="4">Odpady poddane procesowi odzysku lub unieszkodliwiania w roku sprawozdawczym</th>
        <th colspan="4">Odpady powstające podczas procesu odzysku lub unieszkodliwiania</th>
    </tr>
    <tr>
        <th rowspan="2">kod odpadów</th>
        <th rowspan="2">rodzaj odpadów</th>
        <th colspan="2">masa odpadów [Mg]</th>
        <th rowspan="2">kod odpadów</th>
        <th rowspan="2">rodzaj odpadów</th>
        <th colspan="2">masa odpadów [Mg]</th>
    </tr>
    <tr>
        <th>masa odpadów</th>
        <th>sucha masa odpadów</th>
        <th>masa odpadów</th>
        <th>sucha masa odpadów</th>
    </tr>
</table>