<!--- Start of Page File --->
<cfset subTitle = "ANSI / OSHA / SCC Reports -  #url.year#<br><font color=red>This list contains AS and Local Quality Audits</font>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="SearchResults" DataSource="Corporate">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, audittype, auditedby, RescheduleNextYear, status, leadauditor, ascontact, auditor, sitecontact, audittype2

FROM AuditSchedule

WHERE Approved = 'Yes'
AND AuditType2 = 'Accred'
AND Status IS Null
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">
AND (AuditType LIKE 'ANSI%' OR 	AuditType LIKE 'OSHA%' OR AuditType LIKE 'SCC%')

ORDER BY AuditType, Month, ID
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Distinct">
SELECT
	DISTINCT AuditType
FROM
	AuditSchedule
WHERE
	(AuditType LIKE 'ANSI%' OR AuditType LIKE 'OSHA%' OR AuditType LIKE 'SC%') 
    AND Approved = 'Yes' 
    AND YEAR_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER"> 
    AND AuditType2 = 'Accred' 
    AND Status IS NULL
</CFQUERY>

<b>Search Criteria</b><br />
<u>Audits by</u>: Accreditation Services and Local Quality<br />
<u>Accreditor</u>: ANSI / OSHA / SCC Only<br><br>

<cfoutput>
Search Returned #searchresults.recordcount# Audits<br><br>

Jump to Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="#curyear#" from="2004">
		<OPTION VALUE="ASReports.cfm?year=#i#">#i#
</cfloop>
</SELECT>
<br><br>
</cfoutput>

<cfif searchResults.recordcount gt 0>

<cfset NumFields = 4>

<b>View Accreditor</b>:<br>
<cfoutput query="Distinct">
 :: <a href="###AuditType#">#AuditType#</a><br>
</cfoutput><br>

<table border="1">
<tr>
	<td class="Blog-title" align="center">Audit Number<br>(Link to IQA)</td>
	<td class="Blog-title" align="center">Location</td>
	<td class="Blog-title" align="center">Dates</td>
	<td class="Blog-title" align="center">Reports</td>
</tr>
<cfset TypeHolder = "">
<cfoutput query="SearchResults">
	<cfif TypeHolder IS NOT AuditType>
		<cfIf TypeHolder is NOT ""></cfif>
		<tr>
			<td colspan="#NumFields#" class="Blog-Title">
				<a name="#AuditType#"></a>
				<b>#AuditType#</b>
			</td>
		</tr>
	</cfif>

<tr>
	<td class="Blog-content">
        <a href="../IQA/auditdetails.cfm?id=#ID#&year=#Year#" target="_blank">
        <cfif auditedby is "AS">
	        AS-#year#-#id#
        <cfelse>
    	    #year#-#id#-#AuditedBy#
        </cfif>
        </a>
	</td>
    
    <!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>
    
	<td class="Blog-content">#OfficeName#</td>
	<td class="Blog-content">
		<!--- output of incDates.cfc --->
		#DateOutput#
	</td>
    
<CFQUERY BLOCKFACTOR="100" NAME="Reports" DataSource="Corporate">
SELECT YEAR_, ID, rID
FROM ASReportAttach
WHERE Year_ = #Year#
AND ID = #ID#
</cfquery>

	<td class="Blog-content" align="center">
    	<cfif Reports.RecordCount GT 0>
        	<a href="ASReports_details.cfm?ID=#ID#&Year=#Year#">View</a>
        <cfelse>
        	<cflock scope="SESSION" timeout="5">
				<cfif isDefined("SESSION.Auth.isLoggedIn") 
					AND SESSION.Auth.IsLoggedIn eq "Yes" 
					AND SESSION.Auth.IsLoggedInApp is "QE" 
					AND SESSION.Auth.Username is "Konigsfeld" 
					OR isDefined("SESSION.Auth.isLoggedIn")
					AND SESSION.Auth.IsLoggedIn eq "Yes" 
					AND SESSION.Auth.IsLoggedInApp is "QE" 
					AND SESSION.Auth.Username is "Carlisle"   
					OR isDefined("SESSION.Auth.isLoggedIn") 
					AND SESSION.Auth.IsLoggedIn eq "Yes" 
					AND SESSION.Auth.IsLoggedInApp is "QE" 
					AND SESSION.Auth.AccessLevel is "SU">
	 		           <a href="ASReports_details.cfm?ID=#ID#&Year=#Year#">Add</a>
                <cfelse>
                	--
				</cfif>
			</cflock>
        </cfif>
    </td>
</tr>
<cfset TypeHolder = AuditType>
</cfoutput>
</table>

<cfelse>
	<font color="red">No Audits found for <cfoutput>#url.year#</cfoutput></font>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->