<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
UPDATE AuditSchedule
SET

Approved='Yes'

WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer"> 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer"> 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
</cfquery>

<cfif Audit.AuditedBy eq "IQA">
	<Cfset AuditorCCEmails = "">
    
	<!--- add lead auditor field email --->
    <cfif len(Audit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#Audit.LeadAuditor#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(Audit.Auditor)>
        <cfloop index = "ListElement" list = "#Audit.Auditor#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    
    <!--- add auditor in training field emails --->
    <cfif len(Audit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#Audit.AuditorInTraining#"> 
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email 
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>
                
                <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

    <cfmail 
        to="#AuditorCCEmails#" 
        from="Internal.Quality_Audits@ul.com"
        cc="Internal.Quality_Audits@ul.com"
        subject="Audit Added to IQA Audit Schedule - #Year_#-#ID#-IQA"
        query="Audit"
        type="html">
The following audit has been recently added to the IQA Audit Schedule. You are listed as a member of the audit team.<br /><br />

Please View the audit details for additional information:<Br /><br />

<a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditDetails.cfm?ID=#ID#&Year=#Year_#">Audit Details</a>
	</cfmail>
</cfif>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">