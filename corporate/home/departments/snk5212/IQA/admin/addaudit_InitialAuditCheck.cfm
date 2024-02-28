<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Audit - Initial Audit Check">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT AuditType2, AuditType, Area, OfficeName 
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

			<CFQUERY BLOCKFACTOR="100" name="InitialProgramAuditCheck" Datasource="Corporate">
			SELECT Count(*) as Count
			FROM AuditSchedule
			WHERE Area = '#check.Area#'
			AND AuditType2 = 'Program'
			AND Year_ <= #URL.Year#
			AND Status IS NULL            
            AND Approved = 'Yes'
			AND AuditedBy = 'IQA'
			</CFQUERY>
            
            <!---
			<Cfdump var="#InitialProgramAuditCheck#">
			--->

<cfif check.AuditType2 eq "Program">
	<cfset Type = "Program">
<cfelse>
	<cfset Type = "Site">
</cfif>

<cfoutput query="Check">
<cfform action="addaudit_InitialAuditCheck_Submit.cfm?#CGI.Query_String#">
<b>Initial #Type# Audit?</b><br />
<cfif Type eq "Program">
	<u>Program</u>: #Area#
<cfelseif Type eq "Site">
	<u>Site</u>: #OfficeName#
</cfif><br><br>

This appears be the first #Type# audit of this #Type# - If this is correct, please select Yes. Otherwise, select No.<br />
Yes <cfinput type="radio" value="1" name="Initial" checked="yes">
No <cfinput type="radio" value="0" name="Initial">
<br /><br />

<u>Note</u> - An initial audit of a #Type# requires that all applicable Standard Categories are covered.<br /><br />
<cfinput type="Submit" name="Submit" value="Submit">
</cfform>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->