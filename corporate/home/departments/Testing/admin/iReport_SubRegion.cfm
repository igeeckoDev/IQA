<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Internal Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SubRegionStats">
SELECT * FROM iReportSubRegion
WHERE SubRegion='#url.subregion#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="OfficeStats">
SELECT * FROM iReportOffice
WHERE subregion='#url.subregion#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>				  
<br><u><b>#url.Year# Internal Audit Report</b></u> - <u><b>#url.SubRegion#</u></b><br>
<u>Viewing</u>: Subregion Overall <a href="iReport_SubRegion2.cfm?subregion=#url.subregion#&year=#url.year#">[view data for each office]</a><br><br>
Select year: 
<A href="iReport_SubRegion.cfm?subregion=#url.subregion#&year=2006">2006</A> ::  
<a href="iReport_SubRegion.cfm?subregion=#url.subregion#&year=2007">2007</A><br>
</cfoutput><br>

<cfif SubRegionStats.recordcount is "0">
<br>There have been no audits conducted for this Sub-Region in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>

<cfquery name="KP" Datasource="Corporate">
SELECT * FROM KeyProcesses
ORDER BY ID
</cfquery>

<Table>
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="275" valign="top">
<tr><td class="blog-content" valign="top"><b>Key Processes</b></td></tr>
<cfoutput query="KP" startrow="1" maxrows="17">
<tr>
<td class="blog-content">
#KP#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfoutput query="SubRegionStats" group="year">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-content" align="center"><b>Findings and Observations</b></td></tr>
<cfloop list="#SubRegionStats.ColumnList#" index="col">
<cfif col is "Year" or col is "SubRegion" or col is "AuditType" or col is "AuditedBy" or col is "Region" or col is "officename">
<cfelse>
<tr>
 	<td class="blog-content" align="center">
		#round(SubRegionStats[col][1])#
	</td></tr> 
</cfif>
<cfset i = i+1>
</cFLOOP>
</TABLE>

</td>
 </cfoutput>
</tr>
</TABLE>
<br>
<table>
<tr class="blog-content">
	<td class="blog-content">
<br>
*The data above is comprised of audits from the offices listed below.<br><br>

<cfset i = 1>
<cfoutput query="OfficeStats">
#i#: #OfficeName#<br>
<cfset i = i + 1>
</cfoutput><br>
	</td>
</tr>
</table>
</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
