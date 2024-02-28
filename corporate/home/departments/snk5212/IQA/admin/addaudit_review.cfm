<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT AuditType2, AuditType, Area, OfficeName, AuditedBy, AuditArea
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif Check.audittype2 is "Technical Assessment"
	OR Check.audittype is "TPTDP"
	OR Check.audittype2 is "Local Function CBTL"
	OR Check.audittype2 is "Field Services"
	OR Check.audittype2 is "Lab Scope Review"
	OR Check.audittype2 is "Global Function/Process"
	OR Check.AuditArea is "Certification Body (CB) Audit">

	<!--- add audit to planning table --->
	<cfinclude template="AuditPlanning_moveAuditToPlanning.cfm">

	<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
<cfelse>
	<cfif check.audittype2 is "Program" OR check.audittype2 is "Scheme Documentation Audit">
        <CFQUERY name="Program" Datasource="Corporate">
        SELECT IQAtblOffices.OfficeName, ProgDev.Program
        FROM IQAtblOffices, ProgDev
        WHERE ProgDev.ID = #Form.e_Area#
        AND IQAtblOffices.ID = ProgDev.ProgOversight
        </CFQUERY>
    </cfif>

	<!---
	    <CFQUERY name="Program" Datasource="Corporate">
	    SELECT * FROM Program_Location
	    WHERE Program = '#FORM.e_Area#'
	    </CFQUERY>
    --->

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
    UPDATE AuditSchedule
    SET

    <!--- Local Function Audits for 2012+ required question "Initial Audit of this Site?"
	<cfif Check.AuditType2 eq "Local Function">
		InitialSiteAudit = #Form.InitialSiteAudit#,
	</cfif>
	--->

    <!--- scopes are gathered from the REQUEST scope - stored in the application.cfc file --->
    <cfif Check.AuditType2 eq "Local Function" AND FORM.e_Area eq "Laboratories">
        <cfset Scope = "#Request.IQAScope#">
        Scope = '#Scope#',
    </cfif>

    <cfif check.audittype2 is "Program" OR check.audittype2 is "Scheme Documentation Audit">
        OfficeName='#Program.OfficeName#',
        Area = '#Program.Program#'
    <cfelse>
        Area = '#Form.e_Area#'
    </cfif>

    WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    </CFQUERY>

	<!--- add audit to planning table --->
	<cfinclude template="AuditPlanning_moveAuditToPlanning.cfm">

	<Cfif check.AuditedBy eq "IQA">
        <CFQUERY BLOCKFACTOR="100" name="newCheck" Datasource="Corporate">
        SELECT AuditType2, AuditType, Area, OfficeName, AuditedBy
        FROM AuditSchedule
        WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
        AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
        </CFQUERY>

		<cfif newCheck.Area eq "Processes" OR newCheck.Area eq "Processes and Labs" OR newCheck.Area eq 'Laboratories'>
			<!--- Initial Site Audit Check --->
			<CFQUERY BLOCKFACTOR="100" name="InitialSiteAuditCheck" Datasource="Corporate">
			SELECT Count(*) as Count
			FROM AuditSchedule
			WHERE OfficeName = '#newCheck.OfficeName#'
			AND AuditType2 = 'Local Function'
			AND (Area = 'Processes' OR Area = 'Processes and Labs' OR Area = 'Laboratories')
			AND Year_ <= #URL.Year#
			AND Status IS NULL
            AND Approved = 'Yes'
			AND AuditedBy = 'IQA'
			</CFQUERY>
			<!--- /// --->

			<cfif InitialSiteAuditCheck.count EQ 0>
				<cflocation url="addaudit_InitialAuditCheck.cfm?#CGI.QUERY_STRING#" addtoken="no">
			<Cfelse>
				<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
			</cfif>
		<cfelseif newCheck.audittype2 is "Program">
			<!--- Initial Program Audit Check --->
			<CFQUERY BLOCKFACTOR="100" name="InitialProgramAuditCheck" Datasource="Corporate">
			SELECT Count(*) as Count
			FROM AuditSchedule
			WHERE Area = '#newCheck.Area#'
			AND AuditType2 = 'Program'
			AND Year_ <= #URL.Year#
			AND Status IS NULL
            AND Approved = 'Yes'
			AND AuditedBy = 'IQA'
			</CFQUERY>
			<!--- /// --->

			<cfif InitialProgramAuditCheck.count EQ 0>
				<cflocation url="addaudit_InitialAuditCheck.cfm?#CGI.QUERY_STRING#" addtoken="no">
			<cfelse>
				<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
			</cfif>
		<cfelse>
			<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
		</cfif>
	</cfif>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
</cfif>