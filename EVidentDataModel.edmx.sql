
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/21/2014 00:12:58
-- Generated from EDMX file: C:\Users\wiono_000\Desktop\Evident\Nowy folder\EVidentDataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [EVident];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Commune_District]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Commune] DROP CONSTRAINT [FK_Commune_District];
GO
IF OBJECT_ID(N'[dbo].[FK_Company_Commune]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Company] DROP CONSTRAINT [FK_Company_Commune];
GO
IF OBJECT_ID(N'[dbo].[FK_CompanyPkd_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CompanyPkd] DROP CONSTRAINT [FK_CompanyPkd_Company];
GO
IF OBJECT_ID(N'[dbo].[FK_CompanyRight_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CompanyRight] DROP CONSTRAINT [FK_CompanyRight_Company];
GO
IF OBJECT_ID(N'[dbo].[FK_Contractor_Commune]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contractor] DROP CONSTRAINT [FK_Contractor_Commune];
GO
IF OBJECT_ID(N'[dbo].[FK_Contractor_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contractor] DROP CONSTRAINT [FK_Contractor_Company];
GO
IF OBJECT_ID(N'[dbo].[FK_ContractorVehicleNumber_Contractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContractorVehicleNumber] DROP CONSTRAINT [FK_ContractorVehicleNumber_Contractor];
GO
IF OBJECT_ID(N'[dbo].[FK_ContractorWasteCode_Contractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContractorWasteCode] DROP CONSTRAINT [FK_ContractorWasteCode_Contractor];
GO
IF OBJECT_ID(N'[dbo].[FK_ContractorWasteCode_WasteCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContractorWasteCode] DROP CONSTRAINT [FK_ContractorWasteCode_WasteCode];
GO
IF OBJECT_ID(N'[dbo].[FK_Decision_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Decision] DROP CONSTRAINT [FK_Decision_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_Decision]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_Decision];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_Installation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_Installation];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_Installation1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_Installation1];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_Installation2]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_Installation2];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_ProcessingMethod]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_ProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_ProcessingMethod1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_ProcessingMethod1];
GO
IF OBJECT_ID(N'[dbo].[FK_DecisionElement_WasteCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DecisionElement] DROP CONSTRAINT [FK_DecisionElement_WasteCode];
GO
IF OBJECT_ID(N'[dbo].[FK_Department_Commune]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Department] DROP CONSTRAINT [FK_Department_Commune];
GO
IF OBJECT_ID(N'[dbo].[FK_Department_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Department] DROP CONSTRAINT [FK_Department_Company];
GO
IF OBJECT_ID(N'[dbo].[FK_DepartmentVehicleNumber_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DepartmentVehicleNumber] DROP CONSTRAINT [FK_DepartmentVehicleNumber_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_District_Province]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[District] DROP CONSTRAINT [FK_District_Province];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpo_Contractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpo] DROP CONSTRAINT [FK_DprDpo_Contractor];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpo_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpo] DROP CONSTRAINT [FK_DprDpo_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpo_Period]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpo] DROP CONSTRAINT [FK_DprDpo_Period];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpoElement_DprDpo]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpoElement] DROP CONSTRAINT [FK_DprDpoElement_DprDpo];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpoElement_PackageKind]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpoElement] DROP CONSTRAINT [FK_DprDpoElement_PackageKind];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpoElement_ProcessingMethod]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpoElement] DROP CONSTRAINT [FK_DprDpoElement_ProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpoElement_RecyclingKind]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpoElement] DROP CONSTRAINT [FK_DprDpoElement_RecyclingKind];
GO
IF OBJECT_ID(N'[dbo].[FK_DprDpoElement_WasteCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DprDpoElement] DROP CONSTRAINT [FK_DprDpoElement_WasteCode];
GO
IF OBJECT_ID(N'[dbo].[FK_Installation_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Installation] DROP CONSTRAINT [FK_Installation_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_Installation_InstallationKind]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Installation] DROP CONSTRAINT [FK_Installation_InstallationKind];
GO
IF OBJECT_ID(N'[dbo].[FK_Installation_InstallationProcessingMethod]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Installation] DROP CONSTRAINT [FK_Installation_InstallationProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[FK_InstallationWasteCode_Installation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[InstallationWasteCode] DROP CONSTRAINT [FK_InstallationWasteCode_Installation];
GO
IF OBJECT_ID(N'[dbo].[FK_InstallationWasteCode_WasteCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[InstallationWasteCode] DROP CONSTRAINT [FK_InstallationWasteCode_WasteCode];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCard_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCard] DROP CONSTRAINT [FK_WasteRecordCard_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCard_Period]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCard] DROP CONSTRAINT [FK_WasteRecordCard_Period];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCard_WasteCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCard] DROP CONSTRAINT [FK_WasteRecordCard_WasteCode];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_Commune]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_Commune];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_Contractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_Contractor];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_ContractorVehicleNumber]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_ContractorVehicleNumber];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_DepartmentVehicleNumber]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_DepartmentVehicleNumber];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_Installation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_Installation];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_ProcessingMethod]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_ProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_ProcessingMethod1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_ProcessingMethod1];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_WasteRecordCard]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_WasteRecordCard];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_WasteTransferCard]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_WasteTransferCard];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_ZseieCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_ZseieCode];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteRecordCardElement_ZseieCodeKind]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteRecordCardElement] DROP CONSTRAINT [FK_WasteRecordCardElement_ZseieCodeKind];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteTransferCard_Contractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteTransferCard] DROP CONSTRAINT [FK_WasteTransferCard_Contractor];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteTransferCard_ProcessingMethod]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteTransferCard] DROP CONSTRAINT [FK_WasteTransferCard_ProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteTransferCard_TransportContractor]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteTransferCard] DROP CONSTRAINT [FK_WasteTransferCard_TransportContractor];
GO
IF OBJECT_ID(N'[dbo].[FK_WasteTransferCard_WasteRecordCard]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WasteTransferCard] DROP CONSTRAINT [FK_WasteTransferCard_WasteRecordCard];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[AddressBook]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AddressBook];
GO
IF OBJECT_ID(N'[dbo].[Commune]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Commune];
GO
IF OBJECT_ID(N'[dbo].[Company]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Company];
GO
IF OBJECT_ID(N'[dbo].[CompanyPkd]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CompanyPkd];
GO
IF OBJECT_ID(N'[dbo].[CompanyRight]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CompanyRight];
GO
IF OBJECT_ID(N'[dbo].[Configuration]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Configuration];
GO
IF OBJECT_ID(N'[dbo].[Contractor]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contractor];
GO
IF OBJECT_ID(N'[dbo].[ContractorVehicleNumber]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ContractorVehicleNumber];
GO
IF OBJECT_ID(N'[dbo].[ContractorWasteCode]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ContractorWasteCode];
GO
IF OBJECT_ID(N'[dbo].[Decision]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Decision];
GO
IF OBJECT_ID(N'[dbo].[DecisionElement]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DecisionElement];
GO
IF OBJECT_ID(N'[dbo].[Department]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Department];
GO
IF OBJECT_ID(N'[dbo].[DepartmentVehicleNumber]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DepartmentVehicleNumber];
GO
IF OBJECT_ID(N'[dbo].[District]', 'U') IS NOT NULL
    DROP TABLE [dbo].[District];
GO
IF OBJECT_ID(N'[dbo].[DprDpo]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DprDpo];
GO
IF OBJECT_ID(N'[dbo].[DprDpoElement]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DprDpoElement];
GO
IF OBJECT_ID(N'[dbo].[Error]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Error];
GO
IF OBJECT_ID(N'[dbo].[Installation]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Installation];
GO
IF OBJECT_ID(N'[dbo].[InstallationKind]', 'U') IS NOT NULL
    DROP TABLE [dbo].[InstallationKind];
GO
IF OBJECT_ID(N'[dbo].[InstallationProcessingMethod]', 'U') IS NOT NULL
    DROP TABLE [dbo].[InstallationProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[InstallationWasteCode]', 'U') IS NOT NULL
    DROP TABLE [dbo].[InstallationWasteCode];
GO
IF OBJECT_ID(N'[dbo].[PackageKind]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PackageKind];
GO
IF OBJECT_ID(N'[dbo].[Period]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Period];
GO
IF OBJECT_ID(N'[dbo].[ProcessingMethod]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProcessingMethod];
GO
IF OBJECT_ID(N'[dbo].[Province]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Province];
GO
IF OBJECT_ID(N'[dbo].[RecyclingKind]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RecyclingKind];
GO
IF OBJECT_ID(N'[dbo].[WasteCode]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WasteCode];
GO
IF OBJECT_ID(N'[dbo].[WasteRecordCard]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WasteRecordCard];
GO
IF OBJECT_ID(N'[dbo].[WasteRecordCardElement]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WasteRecordCardElement];
GO
IF OBJECT_ID(N'[dbo].[WasteTransferCard]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WasteTransferCard];
GO
IF OBJECT_ID(N'[dbo].[ZseieCode]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ZseieCode];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'AddressBooks'
CREATE TABLE [dbo].[AddressBooks] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Street] nvarchar(max)  NOT NULL,
    [PostCode] nvarchar(max)  NOT NULL,
    [City] nvarchar(max)  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Fax] nvarchar(max)  NOT NULL,
    [Phone] nvarchar(max)  NOT NULL,
    [HomeSite] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Kind] int  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'Communes'
CREATE TABLE [dbo].[Communes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [District_Id] bigint  NOT NULL
);
GO

-- Creating table 'Companies'
CREATE TABLE [dbo].[Companies] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Login] nvarchar(max)  NOT NULL,
    [PasswordHash] varbinary(8000)  NOT NULL,
    [FullName] nvarchar(max)  NOT NULL,
    [ShortName] nvarchar(max)  NOT NULL,
    [RegisterNumber] nvarchar(max)  NOT NULL,
    [Place] nvarchar(max)  NOT NULL,
    [Street] nvarchar(max)  NOT NULL,
    [BuildingNumber] nvarchar(max)  NOT NULL,
    [FlatNumber] nvarchar(max)  NOT NULL,
    [PostCode] nvarchar(max)  NOT NULL,
    [Nip] nvarchar(max)  NOT NULL,
    [Regon] nvarchar(max)  NOT NULL,
    [Phone] nvarchar(max)  NOT NULL,
    [Fax] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [StartDate] datetime  NOT NULL,
    [EndDate] datetime  NULL,
    [BusinessFirstName] nvarchar(max)  NOT NULL,
    [BusinessLastName] nvarchar(max)  NOT NULL,
    [BusinessPhone] nvarchar(max)  NOT NULL,
    [BusinessFax] nvarchar(max)  NOT NULL,
    [BusinessEmail] nvarchar(max)  NOT NULL,
    [GIOSRegisterNumber] nchar(7)  NULL,
    [IsSellingElectronics] bit  NOT NULL,
    [IsRecoveringElectronics] bit  NOT NULL,
    [IsCollectingElectronics] bit  NOT NULL,
    [IsProcessingElectronics] bit  NOT NULL,
    [IsRecyclingElectronics] bit  NOT NULL,
    [IsSomeElseElectronics] bit  NOT NULL,
    [IsSellingBattery] bit  NOT NULL,
    [IsProcessingBattery] bit  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Commune_Id] bigint  NOT NULL
);
GO

-- Creating table 'CompanyPkds'
CREATE TABLE [dbo].[CompanyPkds] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Value] varchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Company_Id] bigint  NOT NULL
);
GO

-- Creating table 'CompanyRights'
CREATE TABLE [dbo].[CompanyRights] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [VirtualPath] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Company_Id] bigint  NOT NULL
);
GO

-- Creating table 'Configurations'
CREATE TABLE [dbo].[Configurations] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Key] nvarchar(max)  NOT NULL,
    [Value] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'Contractors'
CREATE TABLE [dbo].[Contractors] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [FullName] nvarchar(max)  NOT NULL,
    [ShortName] nvarchar(max)  NOT NULL,
    [PostCode] nvarchar(max)  NOT NULL,
    [Place] nvarchar(max)  NOT NULL,
    [Street] nvarchar(max)  NOT NULL,
    [BuildingNumber] nvarchar(max)  NULL,
    [FlatNumber] nvarchar(max)  NOT NULL,
    [Nip] nvarchar(max)  NOT NULL,
    [Regon] nvarchar(max)  NOT NULL,
    [Phone] nvarchar(max)  NOT NULL,
    [Fax] nvarchar(max)  NOT NULL,
    [RegisterNumber] nchar(7)  NULL,
    [IsSellingElectronics] bit  NOT NULL,
    [IsRecoveringElectronics] bit  NOT NULL,
    [IsCollectingElectronics] bit  NOT NULL,
    [IsProcessingElectronics] bit  NOT NULL,
    [IsRecyclingElectronics] bit  NOT NULL,
    [IsSomeElseElectronics] bit  NOT NULL,
    [IsSellingBattery] bit  NOT NULL,
    [IsProcessingBattery] bit  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Commune_Id] bigint  NOT NULL,
    [Company_Id] bigint  NOT NULL
);
GO

-- Creating table 'ContractorVehicleNumbers'
CREATE TABLE [dbo].[ContractorVehicleNumbers] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Value] varchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Contractor_Id] bigint  NOT NULL
);
GO

-- Creating table 'ContractorWasteCodes'
CREATE TABLE [dbo].[ContractorWasteCodes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [TimeStamp] datetime  NULL,
    [Contractor_Id] bigint  NOT NULL,
    [WasteCode_Id] bigint  NOT NULL
);
GO

-- Creating table 'Decisions'
CREATE TABLE [dbo].[Decisions] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Number] nvarchar(max)  NOT NULL,
    [ReleaseDate] datetime  NOT NULL,
    [ReleaseAuthority] nvarchar(max)  NOT NULL,
    [ValidFrom] datetime  NOT NULL,
    [ValidTo] datetime  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Department_Id] bigint  NOT NULL
);
GO

-- Creating table 'DecisionElements'
CREATE TABLE [dbo].[DecisionElements] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [CreatedLimit] float  NOT NULL,
    [CreatedPgo] bit  NOT NULL,
    [RecycledLimit] float  NOT NULL,
    [DestroyedLimit] float  NOT NULL,
    [CanCollect] bit  NOT NULL,
    [CanTransport] bit  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Decision_Id] bigint  NOT NULL,
    [Installation_Id] bigint  NULL,
    [Installation1_Id] bigint  NULL,
    [Installation2_Id] bigint  NULL,
    [ProcessingMethod_Id] bigint  NULL,
    [ProcessingMethod1_Id] bigint  NULL,
    [WasteCode_Id] bigint  NOT NULL
);
GO

-- Creating table 'Departments'
CREATE TABLE [dbo].[Departments] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [FullName] nvarchar(max)  NOT NULL,
    [PostCode] nvarchar(max)  NOT NULL,
    [Place] nvarchar(max)  NOT NULL,
    [Street] nvarchar(max)  NOT NULL,
    [BuildingNumber] nvarchar(max)  NOT NULL,
    [FlatNumber] nvarchar(max)  NOT NULL,
    [Phone] nvarchar(max)  NOT NULL,
    [Fax] nvarchar(max)  NOT NULL,
    [StartDate] datetime  NOT NULL,
    [EndDate] datetime  NULL,
    [IsMain] bit  NOT NULL,
    [IsZSEiE] bit  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Commune_Id] bigint  NOT NULL,
    [Company_Id] bigint  NOT NULL
);
GO

-- Creating table 'DepartmentVehicleNumbers'
CREATE TABLE [dbo].[DepartmentVehicleNumbers] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Value] varchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Department_Id] bigint  NOT NULL
);
GO

-- Creating table 'Districts'
CREATE TABLE [dbo].[Districts] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Province_Id] bigint  NOT NULL
);
GO

-- Creating table 'DprDpoes'
CREATE TABLE [dbo].[DprDpoes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [DprNumber] nvarchar(max)  NOT NULL,
    [DpoNumber] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Contractor_Id] bigint  NOT NULL,
    [Department_Id] bigint  NOT NULL,
    [Period_Id] bigint  NOT NULL
);
GO

-- Creating table 'DprDpoElements'
CREATE TABLE [dbo].[DprDpoElements] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [ReceivedMass] float  NOT NULL,
    [RecycledMass] float  NOT NULL,
    [TimeStamp] datetime  NULL,
    [DprDpo_Id] bigint  NOT NULL,
    [PackageKind_Id] bigint  NOT NULL,
    [ProcessingMethod_Id] bigint  NOT NULL,
    [RecyclingKind_Id] bigint  NOT NULL,
    [WasteCode_Id] bigint  NOT NULL
);
GO

-- Creating table 'Errors'
CREATE TABLE [dbo].[Errors] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Text] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'Installations'
CREATE TABLE [dbo].[Installations] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [ProcessingCapacity] float  NOT NULL,
    [ProcessingLimit] float  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Department_Id] bigint  NOT NULL,
    [InstallationKind_Id] bigint  NOT NULL,
    [InstallationProcessingMethod_Id] bigint  NULL
);
GO

-- Creating table 'InstallationKinds'
CREATE TABLE [dbo].[InstallationKinds] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'InstallationProcessingMethods'
CREATE TABLE [dbo].[InstallationProcessingMethods] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'InstallationWasteCodes'
CREATE TABLE [dbo].[InstallationWasteCodes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [TimeStamp] datetime  NULL,
    [Installation_Id] bigint  NOT NULL,
    [WasteCode_Id] bigint  NOT NULL
);
GO

-- Creating table 'PackageKinds'
CREATE TABLE [dbo].[PackageKinds] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Index] int  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'Periods'
CREATE TABLE [dbo].[Periods] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] varchar(max)  NOT NULL,
    [DateFrom] datetime  NOT NULL,
    [DateTo] datetime  NOT NULL,
    [IsMain] bit  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'ProcessingMethods'
CREATE TABLE [dbo].[ProcessingMethods] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Kind] int  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'Provinces'
CREATE TABLE [dbo].[Provinces] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'RecyclingKinds'
CREATE TABLE [dbo].[RecyclingKinds] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Kind] int  NOT NULL,
    [Index] int  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'WasteCodes'
CREATE TABLE [dbo].[WasteCodes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Level] int  NOT NULL,
    [RequireDryMass] bit  NOT NULL,
    [IsBattery] bit  NOT NULL,
    [IsZseie] bit  NOT NULL,
    [IsDangerous] bit  NOT NULL,
    [IsRemovable] bit  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- Creating table 'WasteRecordCards'
CREATE TABLE [dbo].[WasteRecordCards] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Number] nvarchar(max)  NOT NULL,
    [TimeStamp] datetime  NULL,
    [Department_Id] bigint  NOT NULL,
    [Period_Id] bigint  NOT NULL,
    [WasteCode_Id] bigint  NOT NULL
);
GO

-- Creating table 'WasteRecordCardElements'
CREATE TABLE [dbo].[WasteRecordCardElements] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Date] datetime  NOT NULL,
    [CreatedMass] float  NOT NULL,
    [CreatedDryMass] float  NOT NULL,
    [ReceivedMass] float  NOT NULL,
    [ReceivedDryMass] float  NOT NULL,
    [ReceivedCardNumber] nvarchar(max)  NULL,
    [ReceivedForRecyclingOrDestruction] bit  NOT NULL,
    [ManageMass] float  NOT NULL,
    [ManageDryMass] float  NOT NULL,
    [ManageLp] nvarchar(max)  NULL,
    [TransferMass] float  NOT NULL,
    [TransferDryMass] float  NOT NULL,
    [IsBatteryFromCar] bit  NOT NULL,
    [IsPositive] bit  NOT NULL,
    [Kind] int  NOT NULL,
    [IsFromHome] bit  NOT NULL,
    [Name] nvarchar(max)  NULL,
    [PESEL] nvarchar(max)  NULL,
    [DocID] nvarchar(max)  NULL,
    [CompanyName] nvarchar(max)  NULL,
    [Source] nvarchar(max)  NULL,
    [SourceKind] nvarchar(max)  NULL,
    [AddrLineA] nvarchar(max)  NULL,
    [AddrLineB] nvarchar(max)  NULL,
    [PartNumber] int  NULL,
    [TimeStamp] datetime  NULL,
    [PgoCommune_Id] bigint  NULL,
    [PgoContractor_Id] bigint  NULL,
    [ContractorVehicleNumber_Id] bigint  NULL,
    [DepartmentVehicleNumber_Id] bigint  NULL,
    [Installation_Id] bigint  NULL,
    [ProcessingMethod_Id] bigint  NULL,
    [ProcessingMethod1_Id] bigint  NULL,
    [WasteRecordCard_Id] bigint  NOT NULL,
    [WasteTransferCard_Id] bigint  NULL,
    [ZseieCode_Id] bigint  NULL,
    [ZseieCode1_Id] bigint  NULL
);
GO

-- Creating table 'WasteTransferCards'
CREATE TABLE [dbo].[WasteTransferCards] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [WasteDestination] nvarchar(max)  NOT NULL,
    [IsCollection] bit  NOT NULL,
    [DPOrequired] bit  NOT NULL,
    [TransportKind] int  NOT NULL,
    [TransportVehicleNumber] nvarchar(max)  NOT NULL,
    [TransferCardNumber] nvarchar(max)  NULL,
    [TimeStamp] datetime  NULL,
    [Kind] int  NOT NULL,
    [Contractor_Id] bigint  NOT NULL,
    [TransportContractor_Id] bigint  NULL,
    [ProcessingMethod_Id] bigint  NULL,
    [WasteRecordCard_Id] bigint  NOT NULL
);
GO

-- Creating table 'ZseieCodes'
CREATE TABLE [dbo].[ZseieCodes] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Level] int  NOT NULL,
    [TimeStamp] datetime  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'AddressBooks'
ALTER TABLE [dbo].[AddressBooks]
ADD CONSTRAINT [PK_AddressBooks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Communes'
ALTER TABLE [dbo].[Communes]
ADD CONSTRAINT [PK_Communes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Companies'
ALTER TABLE [dbo].[Companies]
ADD CONSTRAINT [PK_Companies]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CompanyPkds'
ALTER TABLE [dbo].[CompanyPkds]
ADD CONSTRAINT [PK_CompanyPkds]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CompanyRights'
ALTER TABLE [dbo].[CompanyRights]
ADD CONSTRAINT [PK_CompanyRights]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Configurations'
ALTER TABLE [dbo].[Configurations]
ADD CONSTRAINT [PK_Configurations]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Contractors'
ALTER TABLE [dbo].[Contractors]
ADD CONSTRAINT [PK_Contractors]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ContractorVehicleNumbers'
ALTER TABLE [dbo].[ContractorVehicleNumbers]
ADD CONSTRAINT [PK_ContractorVehicleNumbers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ContractorWasteCodes'
ALTER TABLE [dbo].[ContractorWasteCodes]
ADD CONSTRAINT [PK_ContractorWasteCodes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Decisions'
ALTER TABLE [dbo].[Decisions]
ADD CONSTRAINT [PK_Decisions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [PK_DecisionElements]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Departments'
ALTER TABLE [dbo].[Departments]
ADD CONSTRAINT [PK_Departments]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DepartmentVehicleNumbers'
ALTER TABLE [dbo].[DepartmentVehicleNumbers]
ADD CONSTRAINT [PK_DepartmentVehicleNumbers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Districts'
ALTER TABLE [dbo].[Districts]
ADD CONSTRAINT [PK_Districts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DprDpoes'
ALTER TABLE [dbo].[DprDpoes]
ADD CONSTRAINT [PK_DprDpoes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [PK_DprDpoElements]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Errors'
ALTER TABLE [dbo].[Errors]
ADD CONSTRAINT [PK_Errors]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Installations'
ALTER TABLE [dbo].[Installations]
ADD CONSTRAINT [PK_Installations]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'InstallationKinds'
ALTER TABLE [dbo].[InstallationKinds]
ADD CONSTRAINT [PK_InstallationKinds]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'InstallationProcessingMethods'
ALTER TABLE [dbo].[InstallationProcessingMethods]
ADD CONSTRAINT [PK_InstallationProcessingMethods]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'InstallationWasteCodes'
ALTER TABLE [dbo].[InstallationWasteCodes]
ADD CONSTRAINT [PK_InstallationWasteCodes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'PackageKinds'
ALTER TABLE [dbo].[PackageKinds]
ADD CONSTRAINT [PK_PackageKinds]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Periods'
ALTER TABLE [dbo].[Periods]
ADD CONSTRAINT [PK_Periods]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProcessingMethods'
ALTER TABLE [dbo].[ProcessingMethods]
ADD CONSTRAINT [PK_ProcessingMethods]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Provinces'
ALTER TABLE [dbo].[Provinces]
ADD CONSTRAINT [PK_Provinces]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'RecyclingKinds'
ALTER TABLE [dbo].[RecyclingKinds]
ADD CONSTRAINT [PK_RecyclingKinds]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'WasteCodes'
ALTER TABLE [dbo].[WasteCodes]
ADD CONSTRAINT [PK_WasteCodes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'WasteRecordCards'
ALTER TABLE [dbo].[WasteRecordCards]
ADD CONSTRAINT [PK_WasteRecordCards]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [PK_WasteRecordCardElements]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'WasteTransferCards'
ALTER TABLE [dbo].[WasteTransferCards]
ADD CONSTRAINT [PK_WasteTransferCards]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ZseieCodes'
ALTER TABLE [dbo].[ZseieCodes]
ADD CONSTRAINT [PK_ZseieCodes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [District_Id] in table 'Communes'
ALTER TABLE [dbo].[Communes]
ADD CONSTRAINT [FK_Commune_District]
    FOREIGN KEY ([District_Id])
    REFERENCES [dbo].[Districts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Commune_District'
CREATE INDEX [IX_FK_Commune_District]
ON [dbo].[Communes]
    ([District_Id]);
GO

-- Creating foreign key on [Commune_Id] in table 'Companies'
ALTER TABLE [dbo].[Companies]
ADD CONSTRAINT [FK_Company_Commune]
    FOREIGN KEY ([Commune_Id])
    REFERENCES [dbo].[Communes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Company_Commune'
CREATE INDEX [IX_FK_Company_Commune]
ON [dbo].[Companies]
    ([Commune_Id]);
GO

-- Creating foreign key on [Commune_Id] in table 'Contractors'
ALTER TABLE [dbo].[Contractors]
ADD CONSTRAINT [FK_Contractor_Commune]
    FOREIGN KEY ([Commune_Id])
    REFERENCES [dbo].[Communes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Contractor_Commune'
CREATE INDEX [IX_FK_Contractor_Commune]
ON [dbo].[Contractors]
    ([Commune_Id]);
GO

-- Creating foreign key on [Commune_Id] in table 'Departments'
ALTER TABLE [dbo].[Departments]
ADD CONSTRAINT [FK_Department_Commune]
    FOREIGN KEY ([Commune_Id])
    REFERENCES [dbo].[Communes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Department_Commune'
CREATE INDEX [IX_FK_Department_Commune]
ON [dbo].[Departments]
    ([Commune_Id]);
GO

-- Creating foreign key on [PgoCommune_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_Commune]
    FOREIGN KEY ([PgoCommune_Id])
    REFERENCES [dbo].[Communes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_Commune'
CREATE INDEX [IX_FK_WasteRecordCardElement_Commune]
ON [dbo].[WasteRecordCardElements]
    ([PgoCommune_Id]);
GO

-- Creating foreign key on [Company_Id] in table 'CompanyPkds'
ALTER TABLE [dbo].[CompanyPkds]
ADD CONSTRAINT [FK_CompanyPkd_Company]
    FOREIGN KEY ([Company_Id])
    REFERENCES [dbo].[Companies]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompanyPkd_Company'
CREATE INDEX [IX_FK_CompanyPkd_Company]
ON [dbo].[CompanyPkds]
    ([Company_Id]);
GO

-- Creating foreign key on [Company_Id] in table 'CompanyRights'
ALTER TABLE [dbo].[CompanyRights]
ADD CONSTRAINT [FK_CompanyRight_Company]
    FOREIGN KEY ([Company_Id])
    REFERENCES [dbo].[Companies]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CompanyRight_Company'
CREATE INDEX [IX_FK_CompanyRight_Company]
ON [dbo].[CompanyRights]
    ([Company_Id]);
GO

-- Creating foreign key on [Company_Id] in table 'Contractors'
ALTER TABLE [dbo].[Contractors]
ADD CONSTRAINT [FK_Contractor_Company]
    FOREIGN KEY ([Company_Id])
    REFERENCES [dbo].[Companies]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Contractor_Company'
CREATE INDEX [IX_FK_Contractor_Company]
ON [dbo].[Contractors]
    ([Company_Id]);
GO

-- Creating foreign key on [Company_Id] in table 'Departments'
ALTER TABLE [dbo].[Departments]
ADD CONSTRAINT [FK_Department_Company]
    FOREIGN KEY ([Company_Id])
    REFERENCES [dbo].[Companies]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Department_Company'
CREATE INDEX [IX_FK_Department_Company]
ON [dbo].[Departments]
    ([Company_Id]);
GO

-- Creating foreign key on [Contractor_Id] in table 'ContractorVehicleNumbers'
ALTER TABLE [dbo].[ContractorVehicleNumbers]
ADD CONSTRAINT [FK_ContractorVehicleNumber_Contractor]
    FOREIGN KEY ([Contractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ContractorVehicleNumber_Contractor'
CREATE INDEX [IX_FK_ContractorVehicleNumber_Contractor]
ON [dbo].[ContractorVehicleNumbers]
    ([Contractor_Id]);
GO

-- Creating foreign key on [Contractor_Id] in table 'ContractorWasteCodes'
ALTER TABLE [dbo].[ContractorWasteCodes]
ADD CONSTRAINT [FK_ContractorWasteCode_Contractor]
    FOREIGN KEY ([Contractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ContractorWasteCode_Contractor'
CREATE INDEX [IX_FK_ContractorWasteCode_Contractor]
ON [dbo].[ContractorWasteCodes]
    ([Contractor_Id]);
GO

-- Creating foreign key on [Contractor_Id] in table 'DprDpoes'
ALTER TABLE [dbo].[DprDpoes]
ADD CONSTRAINT [FK_DprDpo_Contractor]
    FOREIGN KEY ([Contractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpo_Contractor'
CREATE INDEX [IX_FK_DprDpo_Contractor]
ON [dbo].[DprDpoes]
    ([Contractor_Id]);
GO

-- Creating foreign key on [PgoContractor_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_Contractor]
    FOREIGN KEY ([PgoContractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_Contractor'
CREATE INDEX [IX_FK_WasteRecordCardElement_Contractor]
ON [dbo].[WasteRecordCardElements]
    ([PgoContractor_Id]);
GO

-- Creating foreign key on [Contractor_Id] in table 'WasteTransferCards'
ALTER TABLE [dbo].[WasteTransferCards]
ADD CONSTRAINT [FK_WasteTransferCard_Contractor]
    FOREIGN KEY ([Contractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteTransferCard_Contractor'
CREATE INDEX [IX_FK_WasteTransferCard_Contractor]
ON [dbo].[WasteTransferCards]
    ([Contractor_Id]);
GO

-- Creating foreign key on [TransportContractor_Id] in table 'WasteTransferCards'
ALTER TABLE [dbo].[WasteTransferCards]
ADD CONSTRAINT [FK_WasteTransferCard_TransportContractor]
    FOREIGN KEY ([TransportContractor_Id])
    REFERENCES [dbo].[Contractors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteTransferCard_TransportContractor'
CREATE INDEX [IX_FK_WasteTransferCard_TransportContractor]
ON [dbo].[WasteTransferCards]
    ([TransportContractor_Id]);
GO

-- Creating foreign key on [ContractorVehicleNumber_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_ContractorVehicleNumber]
    FOREIGN KEY ([ContractorVehicleNumber_Id])
    REFERENCES [dbo].[ContractorVehicleNumbers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_ContractorVehicleNumber'
CREATE INDEX [IX_FK_WasteRecordCardElement_ContractorVehicleNumber]
ON [dbo].[WasteRecordCardElements]
    ([ContractorVehicleNumber_Id]);
GO

-- Creating foreign key on [WasteCode_Id] in table 'ContractorWasteCodes'
ALTER TABLE [dbo].[ContractorWasteCodes]
ADD CONSTRAINT [FK_ContractorWasteCode_WasteCode]
    FOREIGN KEY ([WasteCode_Id])
    REFERENCES [dbo].[WasteCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ContractorWasteCode_WasteCode'
CREATE INDEX [IX_FK_ContractorWasteCode_WasteCode]
ON [dbo].[ContractorWasteCodes]
    ([WasteCode_Id]);
GO

-- Creating foreign key on [Department_Id] in table 'Decisions'
ALTER TABLE [dbo].[Decisions]
ADD CONSTRAINT [FK_Decision_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Departments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Decision_Department'
CREATE INDEX [IX_FK_Decision_Department]
ON [dbo].[Decisions]
    ([Department_Id]);
GO

-- Creating foreign key on [Decision_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_Decision]
    FOREIGN KEY ([Decision_Id])
    REFERENCES [dbo].[Decisions]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_Decision'
CREATE INDEX [IX_FK_DecisionElement_Decision]
ON [dbo].[DecisionElements]
    ([Decision_Id]);
GO

-- Creating foreign key on [Installation_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_Installation]
    FOREIGN KEY ([Installation_Id])
    REFERENCES [dbo].[Installations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_Installation'
CREATE INDEX [IX_FK_DecisionElement_Installation]
ON [dbo].[DecisionElements]
    ([Installation_Id]);
GO

-- Creating foreign key on [Installation1_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_Installation1]
    FOREIGN KEY ([Installation1_Id])
    REFERENCES [dbo].[Installations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_Installation1'
CREATE INDEX [IX_FK_DecisionElement_Installation1]
ON [dbo].[DecisionElements]
    ([Installation1_Id]);
GO

-- Creating foreign key on [Installation2_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_Installation2]
    FOREIGN KEY ([Installation2_Id])
    REFERENCES [dbo].[Installations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_Installation2'
CREATE INDEX [IX_FK_DecisionElement_Installation2]
ON [dbo].[DecisionElements]
    ([Installation2_Id]);
GO

-- Creating foreign key on [ProcessingMethod_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_ProcessingMethod]
    FOREIGN KEY ([ProcessingMethod_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_ProcessingMethod'
CREATE INDEX [IX_FK_DecisionElement_ProcessingMethod]
ON [dbo].[DecisionElements]
    ([ProcessingMethod_Id]);
GO

-- Creating foreign key on [ProcessingMethod1_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_ProcessingMethod1]
    FOREIGN KEY ([ProcessingMethod1_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_ProcessingMethod1'
CREATE INDEX [IX_FK_DecisionElement_ProcessingMethod1]
ON [dbo].[DecisionElements]
    ([ProcessingMethod1_Id]);
GO

-- Creating foreign key on [WasteCode_Id] in table 'DecisionElements'
ALTER TABLE [dbo].[DecisionElements]
ADD CONSTRAINT [FK_DecisionElement_WasteCode]
    FOREIGN KEY ([WasteCode_Id])
    REFERENCES [dbo].[WasteCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DecisionElement_WasteCode'
CREATE INDEX [IX_FK_DecisionElement_WasteCode]
ON [dbo].[DecisionElements]
    ([WasteCode_Id]);
GO

-- Creating foreign key on [Department_Id] in table 'DepartmentVehicleNumbers'
ALTER TABLE [dbo].[DepartmentVehicleNumbers]
ADD CONSTRAINT [FK_DepartmentVehicleNumber_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Departments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DepartmentVehicleNumber_Department'
CREATE INDEX [IX_FK_DepartmentVehicleNumber_Department]
ON [dbo].[DepartmentVehicleNumbers]
    ([Department_Id]);
GO

-- Creating foreign key on [Department_Id] in table 'DprDpoes'
ALTER TABLE [dbo].[DprDpoes]
ADD CONSTRAINT [FK_DprDpo_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Departments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpo_Department'
CREATE INDEX [IX_FK_DprDpo_Department]
ON [dbo].[DprDpoes]
    ([Department_Id]);
GO

-- Creating foreign key on [Department_Id] in table 'Installations'
ALTER TABLE [dbo].[Installations]
ADD CONSTRAINT [FK_Installation_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Departments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Installation_Department'
CREATE INDEX [IX_FK_Installation_Department]
ON [dbo].[Installations]
    ([Department_Id]);
GO

-- Creating foreign key on [Department_Id] in table 'WasteRecordCards'
ALTER TABLE [dbo].[WasteRecordCards]
ADD CONSTRAINT [FK_WasteRecordCard_Department]
    FOREIGN KEY ([Department_Id])
    REFERENCES [dbo].[Departments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCard_Department'
CREATE INDEX [IX_FK_WasteRecordCard_Department]
ON [dbo].[WasteRecordCards]
    ([Department_Id]);
GO

-- Creating foreign key on [DepartmentVehicleNumber_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_DepartmentVehicleNumber]
    FOREIGN KEY ([DepartmentVehicleNumber_Id])
    REFERENCES [dbo].[DepartmentVehicleNumbers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_DepartmentVehicleNumber'
CREATE INDEX [IX_FK_WasteRecordCardElement_DepartmentVehicleNumber]
ON [dbo].[WasteRecordCardElements]
    ([DepartmentVehicleNumber_Id]);
GO

-- Creating foreign key on [Province_Id] in table 'Districts'
ALTER TABLE [dbo].[Districts]
ADD CONSTRAINT [FK_District_Province]
    FOREIGN KEY ([Province_Id])
    REFERENCES [dbo].[Provinces]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_District_Province'
CREATE INDEX [IX_FK_District_Province]
ON [dbo].[Districts]
    ([Province_Id]);
GO

-- Creating foreign key on [Period_Id] in table 'DprDpoes'
ALTER TABLE [dbo].[DprDpoes]
ADD CONSTRAINT [FK_DprDpo_Period]
    FOREIGN KEY ([Period_Id])
    REFERENCES [dbo].[Periods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpo_Period'
CREATE INDEX [IX_FK_DprDpo_Period]
ON [dbo].[DprDpoes]
    ([Period_Id]);
GO

-- Creating foreign key on [DprDpo_Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [FK_DprDpoElement_DprDpo]
    FOREIGN KEY ([DprDpo_Id])
    REFERENCES [dbo].[DprDpoes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpoElement_DprDpo'
CREATE INDEX [IX_FK_DprDpoElement_DprDpo]
ON [dbo].[DprDpoElements]
    ([DprDpo_Id]);
GO

-- Creating foreign key on [PackageKind_Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [FK_DprDpoElement_PackageKind]
    FOREIGN KEY ([PackageKind_Id])
    REFERENCES [dbo].[PackageKinds]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpoElement_PackageKind'
CREATE INDEX [IX_FK_DprDpoElement_PackageKind]
ON [dbo].[DprDpoElements]
    ([PackageKind_Id]);
GO

-- Creating foreign key on [ProcessingMethod_Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [FK_DprDpoElement_ProcessingMethod]
    FOREIGN KEY ([ProcessingMethod_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpoElement_ProcessingMethod'
CREATE INDEX [IX_FK_DprDpoElement_ProcessingMethod]
ON [dbo].[DprDpoElements]
    ([ProcessingMethod_Id]);
GO

-- Creating foreign key on [RecyclingKind_Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [FK_DprDpoElement_RecyclingKind]
    FOREIGN KEY ([RecyclingKind_Id])
    REFERENCES [dbo].[RecyclingKinds]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpoElement_RecyclingKind'
CREATE INDEX [IX_FK_DprDpoElement_RecyclingKind]
ON [dbo].[DprDpoElements]
    ([RecyclingKind_Id]);
GO

-- Creating foreign key on [WasteCode_Id] in table 'DprDpoElements'
ALTER TABLE [dbo].[DprDpoElements]
ADD CONSTRAINT [FK_DprDpoElement_WasteCode]
    FOREIGN KEY ([WasteCode_Id])
    REFERENCES [dbo].[WasteCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DprDpoElement_WasteCode'
CREATE INDEX [IX_FK_DprDpoElement_WasteCode]
ON [dbo].[DprDpoElements]
    ([WasteCode_Id]);
GO

-- Creating foreign key on [InstallationKind_Id] in table 'Installations'
ALTER TABLE [dbo].[Installations]
ADD CONSTRAINT [FK_Installation_InstallationKind]
    FOREIGN KEY ([InstallationKind_Id])
    REFERENCES [dbo].[InstallationKinds]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Installation_InstallationKind'
CREATE INDEX [IX_FK_Installation_InstallationKind]
ON [dbo].[Installations]
    ([InstallationKind_Id]);
GO

-- Creating foreign key on [InstallationProcessingMethod_Id] in table 'Installations'
ALTER TABLE [dbo].[Installations]
ADD CONSTRAINT [FK_Installation_InstallationProcessingMethod]
    FOREIGN KEY ([InstallationProcessingMethod_Id])
    REFERENCES [dbo].[InstallationProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Installation_InstallationProcessingMethod'
CREATE INDEX [IX_FK_Installation_InstallationProcessingMethod]
ON [dbo].[Installations]
    ([InstallationProcessingMethod_Id]);
GO

-- Creating foreign key on [Installation_Id] in table 'InstallationWasteCodes'
ALTER TABLE [dbo].[InstallationWasteCodes]
ADD CONSTRAINT [FK_InstallationWasteCode_Installation]
    FOREIGN KEY ([Installation_Id])
    REFERENCES [dbo].[Installations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_InstallationWasteCode_Installation'
CREATE INDEX [IX_FK_InstallationWasteCode_Installation]
ON [dbo].[InstallationWasteCodes]
    ([Installation_Id]);
GO

-- Creating foreign key on [Installation_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_Installation]
    FOREIGN KEY ([Installation_Id])
    REFERENCES [dbo].[Installations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_Installation'
CREATE INDEX [IX_FK_WasteRecordCardElement_Installation]
ON [dbo].[WasteRecordCardElements]
    ([Installation_Id]);
GO

-- Creating foreign key on [WasteCode_Id] in table 'InstallationWasteCodes'
ALTER TABLE [dbo].[InstallationWasteCodes]
ADD CONSTRAINT [FK_InstallationWasteCode_WasteCode]
    FOREIGN KEY ([WasteCode_Id])
    REFERENCES [dbo].[WasteCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_InstallationWasteCode_WasteCode'
CREATE INDEX [IX_FK_InstallationWasteCode_WasteCode]
ON [dbo].[InstallationWasteCodes]
    ([WasteCode_Id]);
GO

-- Creating foreign key on [Period_Id] in table 'WasteRecordCards'
ALTER TABLE [dbo].[WasteRecordCards]
ADD CONSTRAINT [FK_WasteRecordCard_Period]
    FOREIGN KEY ([Period_Id])
    REFERENCES [dbo].[Periods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCard_Period'
CREATE INDEX [IX_FK_WasteRecordCard_Period]
ON [dbo].[WasteRecordCards]
    ([Period_Id]);
GO

-- Creating foreign key on [ProcessingMethod_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_ProcessingMethod]
    FOREIGN KEY ([ProcessingMethod_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_ProcessingMethod'
CREATE INDEX [IX_FK_WasteRecordCardElement_ProcessingMethod]
ON [dbo].[WasteRecordCardElements]
    ([ProcessingMethod_Id]);
GO

-- Creating foreign key on [ProcessingMethod1_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_ProcessingMethod1]
    FOREIGN KEY ([ProcessingMethod1_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_ProcessingMethod1'
CREATE INDEX [IX_FK_WasteRecordCardElement_ProcessingMethod1]
ON [dbo].[WasteRecordCardElements]
    ([ProcessingMethod1_Id]);
GO

-- Creating foreign key on [ProcessingMethod_Id] in table 'WasteTransferCards'
ALTER TABLE [dbo].[WasteTransferCards]
ADD CONSTRAINT [FK_WasteTransferCard_ProcessingMethod]
    FOREIGN KEY ([ProcessingMethod_Id])
    REFERENCES [dbo].[ProcessingMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteTransferCard_ProcessingMethod'
CREATE INDEX [IX_FK_WasteTransferCard_ProcessingMethod]
ON [dbo].[WasteTransferCards]
    ([ProcessingMethod_Id]);
GO

-- Creating foreign key on [WasteCode_Id] in table 'WasteRecordCards'
ALTER TABLE [dbo].[WasteRecordCards]
ADD CONSTRAINT [FK_WasteRecordCard_WasteCode]
    FOREIGN KEY ([WasteCode_Id])
    REFERENCES [dbo].[WasteCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCard_WasteCode'
CREATE INDEX [IX_FK_WasteRecordCard_WasteCode]
ON [dbo].[WasteRecordCards]
    ([WasteCode_Id]);
GO

-- Creating foreign key on [WasteRecordCard_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_WasteRecordCard]
    FOREIGN KEY ([WasteRecordCard_Id])
    REFERENCES [dbo].[WasteRecordCards]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_WasteRecordCard'
CREATE INDEX [IX_FK_WasteRecordCardElement_WasteRecordCard]
ON [dbo].[WasteRecordCardElements]
    ([WasteRecordCard_Id]);
GO

-- Creating foreign key on [WasteRecordCard_Id] in table 'WasteTransferCards'
ALTER TABLE [dbo].[WasteTransferCards]
ADD CONSTRAINT [FK_WasteTransferCard_WasteRecordCard]
    FOREIGN KEY ([WasteRecordCard_Id])
    REFERENCES [dbo].[WasteRecordCards]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteTransferCard_WasteRecordCard'
CREATE INDEX [IX_FK_WasteTransferCard_WasteRecordCard]
ON [dbo].[WasteTransferCards]
    ([WasteRecordCard_Id]);
GO

-- Creating foreign key on [WasteTransferCard_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_WasteTransferCard]
    FOREIGN KEY ([WasteTransferCard_Id])
    REFERENCES [dbo].[WasteTransferCards]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_WasteTransferCard'
CREATE INDEX [IX_FK_WasteRecordCardElement_WasteTransferCard]
ON [dbo].[WasteRecordCardElements]
    ([WasteTransferCard_Id]);
GO

-- Creating foreign key on [ZseieCode_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_ZseieCode]
    FOREIGN KEY ([ZseieCode_Id])
    REFERENCES [dbo].[ZseieCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_ZseieCode'
CREATE INDEX [IX_FK_WasteRecordCardElement_ZseieCode]
ON [dbo].[WasteRecordCardElements]
    ([ZseieCode_Id]);
GO

-- Creating foreign key on [ZseieCode1_Id] in table 'WasteRecordCardElements'
ALTER TABLE [dbo].[WasteRecordCardElements]
ADD CONSTRAINT [FK_WasteRecordCardElement_ZseieCodeKind]
    FOREIGN KEY ([ZseieCode1_Id])
    REFERENCES [dbo].[ZseieCodes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WasteRecordCardElement_ZseieCodeKind'
CREATE INDEX [IX_FK_WasteRecordCardElement_ZseieCodeKind]
ON [dbo].[WasteRecordCardElements]
    ([ZseieCode1_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------