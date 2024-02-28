<cflock scope="session" timeout="5">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
    SELECT * FROM CalibrationMeetings
	<cfif NOT isDefined("SESSION.Auth.isLoggedIn")>
    	WHERE DB = 'CAR'
	</cfif>
    ORDER BY MeetingYear DESC, StartDate DESC
    </CFQUERY>
</cflock>

<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator Calibration Meeting Index">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif Query.RecordCount gt 0>

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