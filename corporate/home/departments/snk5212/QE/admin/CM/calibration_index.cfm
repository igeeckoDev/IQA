<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT * FROM CalibrationMeetings
ORDER BY MeetingYear DESC, StartDate DESC
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Calibration Meetings Index">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif Query.RecordCount gt 0>
<b>Legend - Meeting Types</b><br>
<u>IQA</u> - Internal Quality Audits (prior to 2010)<br>
<u>CAR</u> - CAR Process<br>
<u>QE</u> - Quality Engineering (IQA and CAR groups) - includes IQA Lead Auditor Meetings<br><br>

<cfset YearHolder = "">
<cfoutput query="Query">
	<cfif YearHolder IS NOT MeetingYear> 
	<cfIf YearHolder is NOT ""><br></cfif>
	<b>#MeetingYear#</b><br> 
	</cfif>
&nbsp;&nbsp;&nbsp; :: #dateformat(StartDate, "m/d/yyyy")# (#DB#) - <a href="Calibration_Details.cfm?ID=#ID#">View</a><br>
	<cfset YearHolder = MeetingYear>
</cfoutput>

<cfelse>
No Calibration Meetings were found.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->