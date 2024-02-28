<cfif url.page eq "calendar">
	<cfset page = "Audit Calendar">
<cfelseif url.page eq "audit_list2">
	<cfset page = "Yearly Audit List">
<cfelseif url.page eq "schedule">
	<cfset page = "Schedule">
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
	SELECT Auditor, Region, SubRegion, IQA
	FROM AuditorList
	WHERE Status = 'Active' OR Status = 'In Training'
	ORDER BY IQA DESC, Region, SubRegion, Auditor
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "View #page# - by Quality Auditor">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select Quality Auditor:<Br /><br />

<cfset RegionHolder = "">
<cfset SubRegionHolder = "">

<CFOUTPUT QUERY="AuditorList">
<cfif RegionHolder IS NOT Region>
    <br />
    <b><cfif IQA eq "Yes">Internal Quality Audits<cfelse>#Region#</cfif></b><br />
	<cfset SubRegionHolder = "">
</cfif>

<cfif IQA eq "No">
	<cfif SubRegionHolder IS NOT SubRegion>
        <u>#SubRegion#</u><br />
    </cfif>
</cfif>

<cfif url.page eq "schedule">
 - <a href="#url.page#.cfm?auditor=#Auditor#&year=#curyear#&AuditedBy=All">#Auditor#</a><br>
<cfelse>
 - <a href="#url.page#.cfm?type=auditor&type2=#Auditor#&year=#curyear#">#Auditor#</a><br>
</cfif>

<cfset RegionHolder = Region>
<cfset SubRegionHolder = SubRegion>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->