<!--- ID for new Row --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID FROM xSNAPData
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT 

INTO xSNAPData
	(ID, 
	AuditYear, 
	AuditID, 
	AuditOfficeNameID, 
	FunctionType, 
	FunctionType2, 
	WTDPCompliance, 
	TCPQualification, 
	CARs, 
	ProjectsReviewed, 
	ComplianceTo00LCS0258, 
	L2Competency, 
	L2EmpNo,
	L2EmpStatus,
	RecordsCompliance, 
	Posted, 
	AuditMonth,
	Notes)

VALUES
	(#NewID.NewID#, 
	#URL.Year#, 
	#URL.ID#, 
	#URL.OfficeID#, 
	'Qualification', 
	'PPP', 
	'NA', 
	'NA', 
	'NA', 
	'NA', 
	'NA', 
	'NA', 
	'00000', 
	'NA',
	'NA',
	#now()#, 
	10,
	'')
</cfquery>