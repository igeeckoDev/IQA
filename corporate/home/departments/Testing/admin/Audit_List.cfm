<!--- Determine what date to show, and last viewed Date if applicable.--->
<cfparam name="CurntDate" default="#now()#">
<cfif isdefined("MonthChange")>
	<cfif isdefined("JumpMonth")>
		<cfset curntdate = createodbcdate(dateadd("m", #url.monthchange#, lastdate))>
	<cfelseif isdefined("JumpYear")>
		<cfset curntdate = createodbcdate(dateadd("yyyy", #url.monthchange#, lastdate))>		
	<cfelse>
		<cfif monthchange is 'forward'>
			<cfset curntdate = createodbcdate(dateadd("m", 1, lastdate))>		
		<cfelse>
			<cfset curntdate = createodbcdate(dateadd("m", -1, lastdate))>
		</cfif>
	</cfif>
</cfif>
<cfparam name="YearSet" default="#year(CurntDate)#">
<cfparam name="MonthSet" default="#month(CurntDate)#">
<cfparam name="url.year" default="#YearSet#">
<cfparam name="Type" default="All">
<cfparam name="Type2" default="">

<cfset NextYear = #YearSet# + 1>

<!--- Create the date variables to search the Database by. --->
<cfset monthstart = createdatetime(#yearset#, #monthset#, 1, 0, 0, 0)>
<cfset monthend = createdatetime(#yearset#, #monthset#, #daysinmonth(monthstart)#, 23, 59, 59)>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitleHeading = "Audit Calendar List View - <cfoutput>#DateFormat(CurntDate, "mmmm, yyyy")#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY DataSource="Corporate" Name="BaseLine">
SELECT * FROM Baseline
WHERE Year_ = #YearSet#
</cfquery>

<cfif BaseLine.BaseLine eq 0>
	<cfoutput>
	<font color="red">#YearSet# IQA Audit Schedule is tentative.</font><br><Br>
	</cfoutput>
</cfif>

<cfinclude template="#IQARootDir#qAudit_List.cfm">

<br />
The * Before the Audit Number indicates that the audit continues into the following month.<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->