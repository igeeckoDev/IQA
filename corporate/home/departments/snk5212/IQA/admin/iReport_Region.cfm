<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Internal Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="OfficeStats">
SELECT * FROM iReportSubRegion
WHERE region='#url.region#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RegionStats">
SELECT * FROM iReportRegion
WHERE Region='#url.Region#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>				  
<br><u><b>#url.Year# Internal Audit Report</b></u> - <u><b>#url.Region#</u></b><br>
<u>Viewing</u>: region by Office <a href="iReport_region2.cfm?region=#url.region#&year=#url.year#">[view data for each subregion]</a><br><br>
Select year: 
<A href="iReport_Region.cfm?Region=#url.Region#&year=2006">2006</A> ::  
<a href="iReport_Region.cfm?Region=#url.Region#&year=2007">2007</A><br>
</cfoutput><br>

<cfif RegionStats.recordcount is "0">
<br>There have been no audits conducted for this Sub-Region in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>

<cfquery name="KP" Datasource="Corporate">
SELECT * FROM KeyProcesses
ORDER BY ID
</cfquery>

<Table>
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="400" valign="top">
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
<cfoutput query="RegionStats" group="year">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-content" align="center"><b>Noncompliance and Preventive actions</b></td></tr>
<cfloop list="#RegionStats.ColumnList#" index="col">
<cfif col is "Year" or col is "Region" or col is "AuditType" or col is "AuditedBy">
<cfelse>
<tr>
 	<td class="blog-content" align="center">
		#round(RegionStats[col][1])#
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
*The data above is comprised of audits from the Subregions listed below.<br><br>

<cfset i = 1>
<cfoutput query="OfficeStats">
#i#: #Subregion#<br>
<cfset i = i + 1>
</cfoutput><br>
	</td>
</tr>
</table>
</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
