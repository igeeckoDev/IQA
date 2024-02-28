<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset sumAudits = 0>

<cfloop index=i from=1 to=4>

<cfif i eq 1>
	<cfset startMonth = 1>
	<cfset endMonth = 3>
<cfelseif i eq 2>
	<cfset startMonth = 4>
	<cfset endMonth = 6>
<cfelseif i eq 3>
	<cfset startMonth = 7>
	<cfset endMonth = 9>
<cfelseif i eq 4>
	<cfset startMonth = 10>
	<cfset endMonth = 12>
</cfif>

	<CFQUERY BLOCKFACTOR="100" NAME="countAudits" Datasource="Corporate">
	SELECT COUNT(*) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #url.year#
	AND STATUS IS NULL
	AND Month BETWEEN #startMonth# and #endMonth# 
	</CFQUERY>

	<cfoutput>
	#url.year#: Quarter #i#: #countAudits.Count# (#startMonth# - #endMonth#)<Br>
	<cfset sumAudits = sumAudits + countAudits.Count>
	
		<cfif i eq 4>
			Tota: #sumAudits#
		</cfif>
	</cfoutput>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->