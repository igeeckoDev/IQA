<!--- Is there are URL Variable? If not, assign the value as last year --->
<cfif NOT isDefined("URL.YEAR")>
	<cfset url.year = "#lastyear#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Findings by Program - <cfoutput>#url.year#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- Query of Report Table and Audit Schedule Table --->
<cfquery Datasource="Corporate" name="NC"> 
SELECT Report.*, AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Area
FROM Report, AuditSchedule
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = Report.ID
AND AuditSchedule.AuditType2 = 'Program'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.AuditedBY = 'IQA'
ORDER BY AuditSchedule.Area
</CFQUERY>

<!--- Standard Category List --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SC">
SELECT * FROM Clauses_2010Sept1
ORDER BY ID
</CFQUERY>

<!--- Assign a array vlaue to the Standard Categories --->
<cfset var=ArrayNew(1)>
<cfloop query="SC">
	<cfset var[CurrentRow] = "#Title#"> 
</cfloop>

<!--- Menu: Select Year --->
<br>
<u>Select Year:</u><br>
<cfloop index="j" from="2008" to="#curyear#">
	<cfoutput>
		<!--- 2006 through current year, double colon is only used between values, not after the last/curyear --->
		<cfif j neq #url.year#>
			<a href="findingsByProgram.cfm?year=#j#">#j#</a><cfif j neq curyear> ::</cfif>
		<cfelse>
			<b>#j#</b><cfif j neq curyear> ::</cfif>	
		</cfif>
	</cfoutput>
</cfloop><br><Br>

<cfset count = 0>

<!--- Output --->
<cfif NC.recordcount gt 0>
	<cfoutput query="NC">
	<u>#Area#</u> [#Year_#-#ID#-IQA]<Br>
		<cfloop index="i" from="1" to="#arrayLen(var)#">
			<!--- Only show values where there are findings. i.e., Count1 through CountX fields are not 0 --->
			<cfif Evaluate("Count#i#") gt 0>
				#var[i]# - #numberformat(Evaluate("Count#i#"), 99)#<br>
                <cfset count = count + #numberformat(Evaluate("Count#i#"), 99)#>
			</cfif>
		</cfloop>
        <cfif count eq 0>
	        <b>None</b><br>
        </cfif><br>
        <cfset count = 0>
	</cfoutput>
<cfelse>
	<cfoutput>
		There are currently no findings from Program Audits for #url.year#.<Br>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->