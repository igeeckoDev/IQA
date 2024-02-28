<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "SRs Generated From #url.Year# IQA Audits - View Quantity and SR Numbers by Standard Category">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select Year: 
<cfoutput>
    <cfloop index="i" from="2010" to="#curyear#">
		<cfif url.year eq #i#><b>#i#</b><cfelse><a href="_SRoutput3.cfm?Year=#i#">#i#</a></cfif>
    </cfloop>
</cfoutput>
<br />

<hr class='dash'><Br />

<cfset var=ArrayNew(1)>
<cfset Count = 0>

<cfloop from="1" to="37" index="i">
	<cfset var[i] = "SR#i#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT #var[i]# as SR, Clauses_2010SEPT1.Title
FROM Report, Clauses_2010SEPT1
WHERE Report.Year_ = #URL.Year#
AND Report.AuditedBy = 'IQA'
AND Clauses_2010SEPT1.ID = #i#
AND #var[i]# <> '0'
ORDER BY Clauses_2010SEPT1.Title
</CFQUERY>

<cfset ClauseHolder = "">

	<!--- output --->
	<cfoutput query="a">
		<cfif ClauseHolder IS NOT Title>
			<cfif Count gt 0>
				<b>#Count#</b><br>
			</cfif><br>
		<cfset Count = 0>
			<cfIf ClauseHolder is NOT "">
				<br>
			</cfif>
			<b><u>#Title#</u></b><br>
		</cfif>
		
		<cfset dump = #replace(SR, ",", "<br>", "All")#>
		#dump#<Br>

		<cfset Count = Count + listlen(SR)>
		
		<cfset ClauseHolder = Title>
	</cfoutput>
</cfloop>

<cfoutput><B>#Count#</B></cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->