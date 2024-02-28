<!--- If No is selected, no file upload --->
<cfif isDefined("Form.YesNoItem") AND Form.YesNoItem eq "No">



<!--- if Yes, check if there is a file --->
<cfelseif isDefined("Form.YesNoItem") AND Form.YesNoItem eq "Yes">
	<!--- file exists - upload/rename --->
	<cfif isDefined("Form.File")>

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
        
		<cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>
    
        <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#URL.Action#">
    </cfoutput>
    
        <!--- upload file to temp location --->
        <CFFILE ACTION="UPLOAD" 
            FILEFIELD="Form.File" 
            DESTINATION="#IQARootPath#TechAuditReports\TempUpload\" 
            NAMECONFLICT="OVERWRITE">
        
        <!---- set the path and set file name, using cffile.serverfileext from cffile above --->
        <cfset destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#cffile.ServerFileExt#">
        
        <cfset newFileName = "#Identifier#.#cffile.ServerFileExt#">
        
        <!--- upload file to destination--->
        <cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">    

        <!--- store report upload info --->
        <CFQUERY BLOCKFACTOR="100" NAME="checkMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Max(ID)+1 as maxID
        FROM TechnicalAudits_ReportFiles
        </CFQUERY>
                
        <!--- update TechnicalAudits_ReportFiles table --->
        <CFQUERY BLOCKFACTOR="100" NAME="ReportFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO TechnicalAudits_ReportFiles(ID, AuditYear, AuditID, DatePosted, PostedBy, ReportFileName, Flag_CurrentStep)
        VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDate(curdate)#, '<cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>', '#NewFileName#', '#URL.Action#')
        </CFQUERY>
        
        <cfset Flag_CurrentStep = "Corrective Actions Completed">
        
        <cfset HistoryUpdate = "Current Step: #Flag_CurrentStep#<br>Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br>Date: #curdate# #curTime#">
        
        <!--- history update --->
        <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_AuditSchedule
        SET
        
        History = <CFQUERYPARAM VALUE="#Audit.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
        
        WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
        </CFQUERY>
        
		<!--- update audit schedule table --->
        <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_AuditSchedule
        SET
        
        Whtaever fields....
		DueDate...
        Flag_CurrentStep = 'Non-Conformance Input Completed'
        
        WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
        </CFQUERY>
        
        <!--- email --->

   	    <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
	<!--- yes was selected but NO file --->
    <cfelse>
    	<cflocation url="" addtoken="no">
    </cfif>
</cfif>