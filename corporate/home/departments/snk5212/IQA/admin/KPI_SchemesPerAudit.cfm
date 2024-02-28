<CFQUERY BLOCKFACTOR="100" name="SchemesPerAudit" Datasource="Corporate">
SELECT Report.Programs, AuditSchedule.Month, AuditSchedule.AuditType2, AuditSchedule.AuditArea, AuditSchedule.Year_, AuditSchedule.ID, AuditSchedule.Area
FROM Report, AuditSchedule
WHERE AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Year_ = #URL.Year#
AND AuditSchedule.Year_ = Report.Year_
AND AuditSchedule.ID = Report.ID
ORDER BY AuditSchedule.Month, AuditSchedule.ID
</cfquery>

<cfif SchemesPerAudit.recordCount GT 0>

<cfset FullProgList = "">
<cfset MonthlyAuditCount = 0>
<cfset MonthHolder = 0>
<cfset MonthCount = 0>
<cfset ProgList = "">
<cfset MonthList = "">

<cfoutput query="SchemesPerAudit">
	<cfif MonthHolder IS NOT Month>
		<cfif MonthHolder GTE 1 AND MonthHolder LTE 12>
			<br>
			
			<!---
				<u>#MonthAsString(MonthHolder)# Total Schemes</u>: #MonthCount# (Includes repeats)<br>
			--->
			
			<cfif ProgList CONTAINS "None">
				<cfset ProgList = ListDeleteAt(ProgList, ListFind(ProgList, "None"))>
			<cfelseif ProgList CONTAINS "NoChanges">
				<cfset ProgList = ListDeleteAt(ProgList, ListFind(ProgList, "NoChanges"))>
			</cfif>
			
			<cfif MonthList CONTAINS "None">
				<cfset MonthList = ListDeleteAt(MonthList, ListFind(MonthList, "None"))>
			<cfelseif MonthList CONTAINS "NoChanges">
				<cfset MonthList = ListDeleteAt(MonthList, ListFind(MonthList, "NoChanges"))>
			</cfif>
			
			<cfset temp = structNew()>
			<cfloop list="#ProgList#" index="i" delimiters ="!!">
				<cfset temp[i] = "">
			</cfloop>
			<cfset distinctList = structKeyList(temp)>
			
			<!---
			<u>Number of Distinct Schemes in Monthly List</u>: #listLen(DistinctList)#<br>
			<u>Number of Audits</u>: #MonthlyAuditCount#<br>
			<u>Schemes Audited</u>: #ProgList#<br>
			<u>Disctinct Schemes</u>: #distinctList#<br><br>
			
			<u>Full Scheme List (all months)</u>: #FullProgList#<br><br>
			--->
			
			<cfset temp = structNew()>
			<cfloop list="#MonthList#" index="i" delimiters ="!!">
				<cfset temp[i] = "">
			</cfloop>
			<cfset MonthDistinctList = structKeyList(temp)>			
			
			<u>Monthly Scheme List</u>: #monthDistinctList#<br><br>
			
			<!---
			<cfset temp = structNew()>
			<cfloop list="#FullProgList#" index="i" delimiters ="!!">
				<cfset temp[i] = "">
			</cfloop>
			<cfset fullDistinctList = structKeyList(temp)>
			
			<u>Disctinct Schemes (all months)</u>: #fullDistinctList#<br><br>
			--->
			
			<cfset ProgList = "">
			<cfset MonthCount = 0>
			<cfset MonthlyAuditCount = 0>
			<cfset MonthList = "">
		</cfif>
		
		<cfIf MonthHolder eq 0><br></cfif>
		
		<b>#MonthAsString(Month)#</b><br>
	</cfif>

	<cfif AuditType2 eq "Program">
		<cfset auditCount = 1>
		<cfset ProgList = listAppend(ProgList, Area)>
		<cfset FullProgList = listAppend(FullProgList, Area)>
		
		<cfset MonthList = listAppend(MonthList, Area)>
	<cfelse>
		<cfset auditCount = #listLen(Programs)#>
		<cfset ProgList = listAppend(ProgList, Programs)>
		<cfset FullProgList = listAppend(FullProgList, Programs)>
		
		<cfset MonthList = listAppend(MonthList, Programs)>
	</cfif>	
	
	#Year_#-#ID#: #auditCount# [#AuditType2#, #AuditArea#<cfif AuditType2 eq "Program">, <b>#Area#</b></cfif></a>]<Br>	

	<cfset MonthlyAuditCount = MonthlyAuditCount + 1>
	<cfset MonthHolder = Month>
	<cfset MonthCount = MonthCount + auditCount>
	
</cfoutput>

<cfoutput>
<!---
	<u>#MonthAsString(MonthHolder)# Total Schemes</u>: #MonthCount#<br>
--->
	
<cfset temp = structNew()>
<cfloop list="#ProgList#" index="i" delimiters ="!!">
	<cfset temp[i] = "">
</cfloop>

<cfset distinctList = structKeyList(temp)>

<!---
<u>Distinct Schemes in Monthly List</u>: #listLen(DistinctList)#<br>
<u>Number of Audits</u>: #MonthlyAuditCount#<br>
<u>Schemes Audited</u>: #ProgList#<br>
---><br>

<u>Full Scheme List (all months)</u>: #listSort(FullProgList, "Text", "asc", "!!")#<br><br>

<cfset temp = structNew()>
<cfloop list="#FullProgList#" index="i" delimiters ="!!">
	<cfset temp[i] = "">
</cfloop>
<cfset fullDistinctList = structKeyList(temp)>

<cfset myarray = listtoarray(fullDistinctList)>
<cfset temp = arrayresize(myarray,listlen(fullDistinctList))>
<cfset fullDistinctList = arraytolist(myarray, ";")>

<u>Disctinct Schemes (all months)</u>: #fullDistinctList#<br><br>
</cfoutput>

<cfelse>
	No IQA audits have been completed for <cfoutput>#URL.Year#</cfoutput>. Change the year in the URL if you wish to see a different year.
</cfif>