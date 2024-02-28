<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfoutput>
	<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>
	
<CFQUERY Name="Office" Datasource="Corporate">
SELECT OfficeName
From IQAtblOffices
WHERE Exist = 'Yes'
Order BY OfficeName
</CFQUERY>

<cfset xyz = #valueList(Office.OfficeName, '!')#>
<cfset myArrayList = ListToArray(xyz, '!')>

<div class="Blog-Title">
UL Locations vs 2009 IQA Audits
</div><br>

<div class="Blog-content">
<Table border="1">
<tr>
<td class="blog-title">Office Name</td>
<td class="blog-title">Audits Conducted</td>
</tr>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

	<cfquery Name="Audits" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT YEAR_ as "Year", ID, Auditedby, Month, Area, Status, audittype2
 FROM AuditSchedule
 WHERE OfficeName = '#myArrayList[i]#'
	 AND YEAR_='2009' AND  AuditedBy = 'IQA'
 ORDER BY Area, status
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<tr align="left" valign="top">
<td class="blog-content" width="400">
<cfoutput>
#myArrayList[i]#<br>
</cfoutput>
</td>

<td class="blog-content" width="400">
<cfif Audits.RecordCount eq 0>
	None<br>
</cfif>

<cfoutput query="Audits">
	<cfif len(status)>
		<font color="red">
			:: <a href="auditdetails.cfm?id=#id#&year=#year#">#Area#</a> [#status#] <br>
		</font>
	<cfelse>
	:: <a href="auditdetails.cfm?id=#id#&year=#year#">#Area# (#audittype2#)</a><br>
	</cfif>
</cfoutput>
</td>
</tr>
</cfloop>
</table>
</div>