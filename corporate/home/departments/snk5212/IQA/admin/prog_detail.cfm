<!--- DV_CORP_002 02-APR-09 --->
<cfquery datasource="Corporate" name="ProgDetail"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 3e4eb46a-f0a4-4cd6-856e-07e82d32d2fd Variable Datasource name --->
SELECT * from IQAtblOffices, Programs
WHERE Programs.ID = #URL.ProgID#
AND IQAtblOffices.ID = ProgOversight
ORDER BY OfficeName, Program
<!---TODO_DV_CORP_002_End: 3e4eb46a-f0a4-4cd6-856e-07e82d32d2fd Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cfquery datasource="Corporate" name="ProgLoc"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 949e386f-acff-403a-bc6b-84b304ec7070 Variable Datasource name --->
SELECT * from IQAtblOffices, Programs, ProgLoc
WHERE Programs.ID = #URL.ProgID#
AND IQAtblOffices.ID = LocOp
AND Programs.ID = ProgID
ORDER BY OfficeName
<!---TODO_DV_CORP_002_End: 949e386f-acff-403a-bc6b-84b304ec7070 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cfquery datasource="Corporate" name="Prog"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: cdd92921-6556-43af-850d-2fc6f8a07a8f Variable Datasource name --->
SELECT * from Programs
WHERE Programs.ID = #URL.ProgID#
<!---TODO_DV_CORP_002_End: cdd92921-6556-43af-850d-2fc6f8a07a8f Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cfquery datasource="Corporate" name="ProgAudits"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: f177dfea-69ae-4728-a538-0ddbdb8700cc Variable Datasource name --->
SELECT * from AuditSchedule
WHERE Area = '#Prog.Program#'
ORDER BY Year, ID
<!---TODO_DV_CORP_002_End: f177dfea-69ae-4728-a538-0ddbdb8700cc Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Program Detail">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<cfoutput query="ProgDetail">
<b>Program</b><br>
#Program#
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "CPO" or SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.accesslevel is "SU">
 [<a href="prog_edit.cfm?progid=#id#">edit</a>]
</cfif>
</cflock>
<br><br>

<b>Program Owner</b><br>
#ProgOwner#, #LocOwner#, #Region#<br>
(#POEmail#)<br><br>

<b>Program Manager</b><br>
#Manager#<br>
(#PMEmail#)<br><br>

<b>Type of Program</b><br>
#Type#<br><br>

<b>Oversight Location</b><br>
#OfficeName#<br><br>
</cfoutput>

<cfset ProgHolder=""> 
<cfset ATHolder="">
<b>Operating Locations</b><br>
<cfif url.progid is 50>
All UL Offices <a href="Office_list.cfm">[view]</a><br>
<cfelse>
<cfif progloc.recordcount is 0>
&nbsp; - No Locations Listed<br>
<cfelse>
<CFOUTPUT Query="ProgLoc">
<cfif officename is "">
&nbsp; - No Locations Listed
<cfelse>
<!---<cfif ProgHolder IS NOT Program> 
<cfIf ProgHolder is NOT ""><br></cfif>
</cfif>
	<cfif ATHolder IS NOT ActivityType> 
	<cfIf ATHolder is NOT ""><br></cfif>
	<b>#ActivityType#</b><br>
	</cfif>--->
	&nbsp; - #OfficeName#<br>
	<!---<cfset ATHolder = ActivityType>
	<cfset ProgHolder = Program>--->
</cfif>
</CFOUTPUT>
</cfif>
</cfif>
<br>

<cfoutput query="ProgDetail">
<b>UL Programs Master List (CPO)</b><br>
<cfif cpo is 1>Yes<cfelse>No</cfif><br><br>

<b>CPC-MR</b><br>
<cfif CPCMR is 1>Yes<cfelse>No</cfif><br><br>

<b>Silver</b><br>
<cfif silver is 1>Yes<cfelse>No</cfif><br><br>

<b>Program Audited by IQA</b><br>
<cfif iqa is 1>Yes<cfelse>No</cfif><br><br>

<b>Comments</b><br>
<cfif comments is NOT "">
#Comments#
<cfelse>
No Comments
</cfif>
<br><br>
</cfoutput>

<cfif ProgAudits.recordcount is 0>
<b>Audits</b><br>
There have been no audits of 
<cfoutput query="ProgAudits"><u>#Program#</u></cfoutput> by IQA.
<cfelse>
<cfset YearHolder=""> 
<cfoutput query="ProgAudits">
	<cfif YearHolder IS NOT Year> 
	<cfIf YearHolder is NOT ""><br></cfif>
	<b><u>#Year# Audits</u></b><br> 
	</cfif>
 - <a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#year#-#id#-#auditedby#</a><br>
	<cfset YearHolder = Year>
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->