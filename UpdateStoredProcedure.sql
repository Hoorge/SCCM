USE [SCCM_PBI_Reporting]
GO
/****** Object:  StoredProcedure [dbo].[usp_installedserverroles]    Script Date: 6/8/2020 4:57:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[usp_installedserverroles]
AS
BEGIN
truncate table [SCCM_PBI_Reporting].dbo.ust_installedserverroles

Insert into [SCCM_PBI_Reporting].dbo.ust_installedserverroles
select
	Netbios_Name0,
	REPLACE(ConfigurationItemName, 'Installed Server Roles - ', '')
from [CM_NOV].dbo.v_CIComplianceStatusDetail a
where ConfigurationItemName in(
	select distinct displayname
	from [CM_NOV].dbo.v_LocalizedCIProperties
	where displayname like 'Installed Server Roles - %' and DisplayName not in('Installed Server Roles - File Server', 'Installed Server Roles - Storage Services'))
order by Netbios_Name0

Select * from [SCCM_PBI_Reporting].dbo.ust_installedserverroles

SET NOCOUNT ON;
END
