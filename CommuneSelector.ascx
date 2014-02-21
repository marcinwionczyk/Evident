<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommuneSelector.ascx.cs" Inherits="EVident.UserControl.CommuneSelector" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<asp:EntityDataSource ID="provinceDataSource" runat="server" 
    ConnectionString="name=EVidentDataModel" 
    DefaultContainerName="EVidentDataModel" EntitySetName="Provinces" 
    OrderBy="it.Name" Select="it.[Id], it.[Name]">
</asp:EntityDataSource>
<asp:EntityDataSource ID="districtDataSource" runat="server" 
    ConnectionString="name=EVidentDataModel" 
    DefaultContainerName="EVidentDataModel" EntitySetName="Districts" 
    EntityTypeFilter="District" OrderBy="it.Name" Select="it.[Name], it.[Id]" 
    Where="it.Province.Id == @ProvinceId">
    <WhereParameters>
        <asp:ControlParameter ControlID="provinceDropDownList" 
            ConvertEmptyStringToNull="False" DbType="Int64" Name="ProvinceId" 
            PropertyName="SelectedValue" />
    </WhereParameters>
</asp:EntityDataSource>
<asp:EntityDataSource ID="communeDataSource" runat="server" 
    ConnectionString="name=EVidentDataModel" 
    DefaultContainerName="EVidentDataModel" EntitySetName="Communes" 
    EntityTypeFilter="Commune"
    OrderBy="it.Name" Select="it.[Id], it.[Name]" 
    Where="it.District.Id == @DistrictId">
    <WhereParameters>
        <asp:ControlParameter ControlID="districtDropDownList" 
            ConvertEmptyStringToNull="False" DbType="Int64" Name="DistrictId" 
            PropertyName="SelectedValue" />
    </WhereParameters>
</asp:EntityDataSource>
<asp:DropDownList ID="provinceDropDownList" AutoPostBack="True" runat="server" 
    CssClass="smallDropDownList"
    DataTextField="Name" DataValueField="Id" 
    onselectedindexchanged="ProvinceDropDownListSelectedIndexChanged" /><br />
<asp:DropDownList ID="districtDropDownList" AutoPostBack="True" runat="server" 
    CssClass="smallDropDownList"
    DataTextField="Name" DataValueField="Id" 
    onselectedindexchanged="DistrictDropDownListSelectedIndexChanged" /><br />
<asp:DropDownList ID="communeDropDownList" runat="server" 
    CssClass="smallDropDownList"
    DataTextField="Name" DataValueField="Id" />