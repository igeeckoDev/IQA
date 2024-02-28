<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Internal Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="OfficeStats">
SELECT * FROM iReportSubRegion
WHERE region='#url.region#'
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>				  
<br><u><b>#url.Year# Internal Audit Report</b></u> - <u><b>#url.region#</u></b><br>
<u>Viewing</u>: region by Office <a href="iReport_region.cfm?region=#url.region#&year=#url.year#">[view overall region data]</a><br><br>
Select year: 
<A href="iReport_Office.cfm?region=#url.region#&year=2006">2006</A> ::  
<a href="iReport_Office.cfm?region=#url.region#&year=2007">2007</A><br>
</cfoutput><br>

<cfif OfficeStats.recordcount is "0">
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
<cfoutput query="KP">
<tr>
<td class="blog-content">
#KP#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 01>
<cfoutput query="OfficeStats">
<td class="blog-content">

<Table border="1">
<tr><td class="blog-small" align="center"><b><a href="iReport_SubRegion.cfm?subregion=#SubRegion#&year=#url.year#">#SubRegion#</a></b></td></tr>
<cfloop list="#OfficeStats.ColumnList#" index="col">
<cfif col is "Year" or col is "AuditType" or col is "AuditedBy" or col is "ID" or col is "Region" or col is "subregion" or col is "OfficeName">
<cfelse>
<tr>
 	<td class="blog-content" align="center" width="120" nowrap>
		#round(OfficeStats[col][i])#
	</td></tr> 
</cfif>
</cFLOOP>
<cfset i = i+1>
</TABLE>

</td>
 </cfoutput>
</tr>
</TABLE>
</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->