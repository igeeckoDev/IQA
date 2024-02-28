<cfoutput>
	<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>
	
<CFQUERY Name="LF" Datasource="Corporate">
SELECT Function From LocalFunctions
Order BY Function
</CFQUERY>

<cfset xyz = #valueList(LF.Function, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<div class="Blog-Title">
Local Functions vs 2009 IQA Audits
</div><br>

<div class="Blog-content">
<Table border="1">
<tr>
<td class="blog-title">Local Function / Process Name</td>
<td class="blog-title">Audits Conducted</td>
</tr>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

	<cfquery Name="Audits" Datasource="Corporate"> 
SELECT YEAR_ as "Year", ID, Auditedby, Month, Status, OfficeName
 FROM AuditSchedule
 WHERE Area = '#myArrayList[i]#'
	 AND YEAR_='2009' AND  AuditType2 = 'Local Function'
	 AND  AuditedBy = 'IQA'
 ORDER BY OfficeName
</cfquery>

<tr align="left" valign="top">
<td class="blog-content" width="200">
<cfoutput>
#myArrayList[i]#<br>
</cfoutput>
</td>

<td class="blog-content" width="450">
<cfif Audits.RecordCount eq 0>
	None<br>
</cfif>

<cfoutput query="Audits">
	<cfif len(status)>
		<font color="red">
			:: <a href="auditdetails.cfm?id=#id#&year=#year#">#OfficeName#</a> [#status#]<br>
		</font>
	<cfelse>
	:: <a href="auditdetails.cfm?id=#id#&year=#year#">#OfficeName#</a><br>
	</cfif>
</cfoutput>
</td>
</tr>
</cfloop>
</table>
</div>