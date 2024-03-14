<cfif Form.Resched is "Cancel Request">
	<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">
<cfelseif form.resched is "Confirm Request">

    <CFQUERY BLOCKFACTOR="100" NAME="Old" Datasource="Corporate">
    SELECT ID, YEAR_ as "Year", Notes
    FROM AuditSchedule
    WHERE ID = #URL.ID#
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <CFQUERY BLOCKFACTOR="100" NAME="delete" Datasource="Corporate">
    UPDATE AuditSchedule
    SET
    Status='Deleted',
    <cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>
    Notes='#Old.Notes#<br><br>#N#'
    WHERE ID = #URL.ID#
    and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <!--- check if schedule is baselined for the year --->
    <CFQUERY BLOCKFACTOR="100" NAME="baselineCheck" Datasource="Corporate">
    SELECT *
    FROM Baseline
    WHERE Year_ = #url.Year#
    </CFQUERY>

	<!--- only send cancel notification if the schedule is baselined --->
	<cfif baselineCheck.baseline EQ 1>
        <CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
        SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
        FROM AuditSchedule
        WHERE ID = #URL.ID#
        and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>

        <cfoutput query="AuditSched">
            <cfif AuditType2 eq "Program">
                <cfset incSubject = "#Trim(Area)#">
            <cfelseif AuditType2 eq "Field Services">
                <cfset incSubject = "Field Services - #trim(Area)#">
            <cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
                <cfif isDefined("Area")>
                    <cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
                <cfelse>
                    <cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
                </cfif>
            <cfelseif AuditType2 is "MMS - Medical Management Systems">
                <cfset incSubject = "#Trim(Area)#">
            </cfif>
        </cfoutput>

        <cflock scope="SESSION" timeout="5">
            <cfif AuditSched.auditedby is "IQA">
                <cfmail
                    to="kai.huang@ul.com, Internal.Quality_Audits@ul.com"
                    cc="#SESSION.Auth.Email#"
                    from="Internal.Quality_Audits@ul.com"
                    subject="Audit Cancelled - Quality System Audit of #incSubject#"
                    query="AuditSched"
                    type="HTML">
                    The following audit has been cancelled:<br><br>

                    <u>Audit</u>: #Year#-#ID#-#AuditedBy#<br>
                    <u>Audit Type</u>: #AuditType2#<br />
                    <u>Audit Area</u>: #Trim(Area)#<br>
                    <u>Location</u>: #Trim(Officename)#<br>
                    <u>Lead Auditor</u>: #LeadAuditor#<br>
                    <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                    <u>Cancellation Comments</u>: #N#<br /><br />

                    Please contact #Request.contacts_CancelRescheduleAudits# with any questions or issues.
                </cfmail>
            </cfif>
        </cflock>
    </cfif>

    <!--- go to file upload page --->
	<cflocation url="AuditCancel_FileUpload.cfm?id=#url.id#&year=#url.year#" ADDTOKEN="No">
</cfif>