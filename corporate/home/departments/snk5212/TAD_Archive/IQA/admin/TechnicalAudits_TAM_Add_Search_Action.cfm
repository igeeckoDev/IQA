<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT first_n_middle, 
	last_name, 
    employee_email as Email, 
    employee_number, 
    Location_Code as Location, 
    Department_Number as Department
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<!--- max id --->
<cfquery Datasource="UL06046" name="maxID"> 
SELECT 
	MAX(ID)+1 as maxID
FROM 
	TechnicalAudits_TAMList
</CFQUERY>

<cfoutput query="qEmpLookup">
    <!--- insert auditor into audit schedule table --->
    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO TechnicalAudits_TAMList(ID, Name, Email)
    VALUES(#maxID.maxID#, '#first_n_middle# #last_name#', '#Email#')    
    </cfquery>
</cfoutput>

<cflocation url="TechnicalAudits_TAM.cfm?msg=#qEmpLookup.Email# added as Deputy Technical Audit Manager" addtoken="no">