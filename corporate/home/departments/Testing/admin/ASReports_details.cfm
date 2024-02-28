<!--- Start of Page File --->
<cfset subTitle = "ANSI / OSHA / SCC Reports - Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->
<cfparam name="CurntDate" default="#now()#">
<cfparam name="YearSet" default="#year(CurntDate)#">

<CFQUERY BLOCKFACTOR="100" NAME="SearchResults" DataSource="Corporate">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, audittype, auditedby, RescheduleNextYear, status, leadauditor, ascontact, auditor, sitecontact, QENotes, audittype2, GCAR, GCARConfirmDate
 FROM AuditSchedule
 WHERE Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">  AND
	ID = #url.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Reports" DataSource="Corporate">
SELECT YEAR_ as "Year", ID, rID, fileName, fileLabel, GCAR, ConfirmDate
FROM ASReportAttach
WHERE Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">  AND
ID = #url.ID#
</cfquery>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop><br>
   </cfif>

<cfoutput query="SearchResults">
<a href="ASReports.cfm?Year=#URL.Year#">Return</a> to AS Reports List View<br /><br />

<b>Audit Number:</b><br>
<cfif auditedby is "AS">
AS-#URL.Year#-#URL.ID#
<cfelse>
#URL.Year#-#URL.ID#-#AuditedBy#
</cfif>
<br><br>

<b>Accreditor:</b><br>
#AuditType#<br><br>

<b>Site Audited:</b><br>
#OfficeName#<br><br>

<b>Audit Dates:</b><br>
<!---<cfinclude template="incASReportsDates.cfm"><br>--->

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

<!--- output of incDates.cfc --->
#DateOutput#<Br /><br />

<b>Files and Reports:</b>
<cflock scope="SESSION" timeout="5">
	<cfif isDefined("SESSION.Auth.isLoggedIn")>
		<cfif SESSION.Auth.IsLoggedIn eq "Yes" AND Session.Auth.IsLoggedInApp is "QE"
			OR SESSION.Auth.IsLoggedIn eq "Yes" AND Session.Auth.IsLoggedInApp is "IQA">
				<cfif SESSION.Auth.Username is "Konigsfeld" OR SESSION.Auth.UserName is "Pallanti" OR SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.UserName is "Carlisle">
                    [<a href="ASReports_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#">Upload Files</a>]
                </cfif>
		</cfif>
	</cfif>
</cflock>
</cfoutput><br>

<cfif Reports.recordcount neq 0>
	<cfoutput query="Reports">
		<cfif filelabel neq "">#filelabel#<cfelse>#filename#</cfif> :: <a href="#CARDir#ASReports/#filename#">View</a><br />
    </cfoutput>
<cfelse>
	No Files or Reports Added<br />
</cfif>
<br>

<cfoutput query="SearchResults">
<b>Notes:</b>
<cflock scope="SESSION" timeout="5">
	<cfif isDefined("SESSION.Auth.isLoggedIn")>
		<cfif SESSION.Auth.IsLoggedIn eq "Yes" AND Session.Auth.IsLoggedInApp is "QE"
			OR SESSION.Auth.IsLoggedIn eq "Yes" AND Session.Auth.IsLoggedInApp is "IQA">
				<cfif SESSION.Auth.Username is "Konigsfeld" OR SESSION.Auth.UserName is "Pallanti" OR SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.UserName is "Carlisle">
                    [<a href="ASReports_Notes.cfm?ID=#URL.ID#&Year=#URL.Year#"><cfif QENotes neq "">Edit<cfelse>Add</cfif></a>]
                </cfif>
		</cfif>
	</cfif>
</cflock>
<br>
<cfif QENotes neq "">
	<cfset Dump = #replace(QENotes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
<cfelse>
	N/A
</cfif><br><br>

<!---
<b>GCAR - Findings/Observations</b><br>
<cfif GCAR eq "Yes">
	Observations have been entered into GCAR. (Confirmed on #dateformat(GCARConfirmDate, "mm/dd/yyyy")#)<br>
<cfelse>
	Observations have not been entered into GCAR.<br><br>
	<cflock scope="Session" timeout="10">
		<cfif SESSION.Auth.AccessLevel is "AS" OR Session.Auth.Accesslevel is "SU">
			If the Observations for this Audit have been entered into GCAR, click the 'Confirm' link below.<br>
			<u>Obsevations Entered into GCAR</u> - <b><a href="ASReports_Findings_Complete.cfm?ID=#URL.ID#&Year=#URL.Year#">Confirm</a></b>
		</cfif>
	</cflock>
</cfif>
--->
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->