<!--- get audit identifier, add flag_currentStep to end --->
<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="Audit">
	<cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelse>
        <cfset AuditTypeID = "P">
    </cfif>
    
    <cfif RequestType eq "Test">
    	<cfset RequestTypeID = "T">
    <cfelse>
    	<cfset RequestTypeID = "N">
    </cfif>

	<cfset AuditorLoc = #right(AuditorDept, 3)#>
    
    <cfif AuditType2 eq "Full">
        <cfset ReviewLoc = #right(ProjectPrimeReviewerDept, 3)#>
    <cfelse>
        <cfset ReviewLoc = #right(ProjectPrimeReviewerDept, 3)#>
    </cfif>

    <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#URL.Action#">
</cfoutput>

<!--- get file name from audit report upload --->
<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ReportFileName, DatePosted
FROM TechnicalAudits_ReportFiles
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND Flag_CurrentStep = 'Audit Completed - Audit Report Posted'
</cfquery>

<!--- copy Audit Report Posted file to TempUpload --->
<CFFILE action="copy"
    source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
    destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\">
    
<cfoutput>
<cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
<cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
<cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
</cfoutput>

<!--- rename/move the file from TempUpload to audit folder and name it with current action (Non-Conformance Review Completed) --->
<CFFILE action="rename"
    source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\#getFile.reportFileName#"
    destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#getFileExt#">