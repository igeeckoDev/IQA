<cfif url.page eq "calendar">
	<cfset page = "Audit Calendar">
<cfelseif url.page eq "audit_list2">
	<cfset page = "Yearly Audit List">
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
	<!---SELECT DISTINCT LeadAuditor 
    FROM AuditSchedule
	WHERE LeadAuditor <> '- None -' 
	AND LeadAuditor IS NOT NULL
	ORDER BY LeadAuditor--->
    
    SELECT LeadAuditor as Aud
    FROM AuditSchedule
    WHERE LeadAuditor <> '- None -'
    AND AuditedBy = 'IQA'

	UNION

    SELECT Auditor as Aud
    FROM AuditSchedule
    WHERE Auditor <> '- None -'
    AND AuditedBy = 'IQA'

	UNION
    
    SELECT AuditorInTraining as Aud
    FROM AuditSchedule
    WHERE AuditorInTraining <> '- None -'
    AND AuditedBy = 'IQA'
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "View #page# - by Auditor">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select Lead Auditor:<Br /><br>

<CFOUTPUT QUERY="AuditorList">
 - <a href="#url.page#.cfm?type=auditor&type2=#Aud#&year=#curyear#">#Aud#</a><br>
</CFOUTPUT><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->