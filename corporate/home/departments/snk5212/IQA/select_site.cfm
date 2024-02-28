<cfquery Datasource="Corporate" name="Region"> 
SELECT * 
FROM
	IQARegion, IQASubRegion, IQAtblOffices
WHERE 
	IQASubRegion.SubRegion <> 'None'
	AND IQARegion.Region = IQASubRegion.Region
	AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
	AND IQAtblOffices.OfficeName <> 'test location'
	AND (IQARegion.Region <> 'Global' AND IQARegion.Region <> 'Corporate')
ORDER BY 
	IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<cfif url.page eq "calendar">
	<cfset page = "Calendar">
<cfelseif url.page eq "audit_list2">
	<cfset page = "List View">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit #page# - Select Site or Region">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset RegHolder=""> 
<cfset SubRegHolder=""> 
<cfset i = 0>

<CFOUTPUT Query="Region">
<cfif region is NOT "Field Services">
	<cfif exist is "Yes">
		<cfif RegHolder IS NOT Region> 
			<cfIf RegHolder is NOT ""><br></cfif>
		<b><u>#Region#</u></b><br>
		</cfif>

		<cfif SubRegHolder IS NOT SubRegion> 
            <cfIf SubRegHolder is NOT ""><br></cfif>
        <b>&nbsp;&nbsp; #SubRegion#</b> :: <a href="#url.page#.cfm?type=subregion&type2=#SubRegion#&Year=#curyear#">View Region Audits</a><br>
        </cfif>

&nbsp;&nbsp;&nbsp; - <a href="#url.page#.cfm?type=location&type2=#officename#&Year=#curyear#">#OfficeName#</a><br>

<cfset RegHolder = Region> 
<cfset SubRegHolder = SubRegion>

<cfset i = i+1>
	</cfif>
</cfif>
</CFOUTPUT>
<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->