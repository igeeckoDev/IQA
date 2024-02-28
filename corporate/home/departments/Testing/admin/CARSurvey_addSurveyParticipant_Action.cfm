<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT first_n_middle,
	last_name,
    employee_email as Email,
    employee_number

FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT EMail
FROM CARSurvey_DistributionDetails
WHERE Email = '#qEmpLookup.Email#'
AND dID = #URL.dID#
</CFQUERY>

<cfif Check.RecordCount EQ 0>
	<cfoutput query="qEmpLookup">
	    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	    SELECT MAX(ID)+1 as NewID
	    FROM CARSurvey_DistributionDetails
	    </CFQUERY>

		<!--- insert name in to CARSurvey_Users Table --->
	    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	    INSERT INTO CARSurvey_DistributionDetails(ID, dID, Email)
		VALUES(#NewUserID.NewID#, #URL.dID#, '#Email#')
	    </cfquery>
	</cfoutput>

	<cflocation url="CARSurvey_manageDistribution.cfm?ID=#URl.dID#" addtoken="no">
<cfelseif Check.RecordCount GT 0>
	<cflocation url="CARSurvey_manageDistribution.cfm?ID=#URl.dID#&msg=#qEmpLookup.Email# has already been added to the distribution list" addtoken="no">
</cfif>