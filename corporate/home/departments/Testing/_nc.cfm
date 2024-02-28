<!--- Is there are URL Variable? If not, assign the value as last year --->
<cfif NOT isDefined("URL.YEAR")>
	<cfset url.year = "#lastyear#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "IQA Audit Findings by Program - <cfoutput>#url.year#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<!--- Query of DB - This is a static xls imported to the DB --->
<!--- Oct - Dec 2008: Findings Translated from Standard Categories back to Key Processes --->
<cfquery Datasource="Corporate" name="NC"> 
SELECT * FROM ReportTotalNCProgsSTATIC
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
ORDER BY Area, Year_
</CFQUERY>

<cfdump var="#NC#">

<!--- Query to gather Key Processes List --->
<cfquery Datasource="Corporate" name="KP"> 
SELECT * FROM KP_Report_2
ORDER BY alpha
</CFQUERY>

<!--- Assign a array vlaue to the Key Processes --->
<cfset var=ArrayNew(1)>
<cfloop query="KP">
	<cfset var[CurrentRow] = "#KP#"> 
</cfloop>
	<cfset var[23] = "Other">

<!--- Menu: Select Year --->
<br>
<u>Select Year:</u><br>
<cfloop index="j" from="2006" to="#curyear#">
	<cfoutput>
		<!--- 2006 through current year, double colon is only used between values, not after the last/curyear --->
		<cfif j neq #url.year#>
			<a href="_nc.cfm?year=#j#">#j#</a><cfif j neq curyear> ::</cfif>
		<cfelse>
			<b>#j#</b><cfif j neq curyear> ::</cfif>	
		</cfif>
	</cfoutput>
</cfloop><br>

<!--- Output --->
<Br>
<cfif NC.recordcount gt 0>
	<cfoutput query="NC">
	<u>#Area#</u><Br>
		<cfloop index=i from=1 to=23>
			<!--- Only show values where there are findings... Expr1 - Expr22 are the field names --->
			<cfif Evaluate("Expr#i#") gt 0>
				#var[i]# - #numberformat(Evaluate("Expr#i#"), 99)#<br>
			</cfif>
		</cfloop><br>
	</cfoutput>
<cfelse>
	<cfoutput>
		There are currently no findings from Program Audits for #url.year#.<Br>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->