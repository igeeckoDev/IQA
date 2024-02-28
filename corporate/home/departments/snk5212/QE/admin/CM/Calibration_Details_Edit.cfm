<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT * FROM CalibrationMeetings
WHERE ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "#Query.DB# Calibration Meeting - Edit Meeting Dates">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<cfif IsDefined("Form.Submit")>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxMeetingID">
	UPDATE CalibrationMeetings
	SET
	StartDate=#CreateODBCDate(Form.e_StartDate)#,
	EndDate=#CreateODBCDate(Form.e_EndDate)#
    WHERE ID = #URL.ID#
	</cfquery>
	
	<cflocation url="Calibration_Details.cfm?ID=#URL.ID#&msg=Meeting dates changed to #Form.e_StartDate# - #Form.e_EndDate#"addtoken="No">
			
<cfelse>

<cfoutput query="Query">
	<cfform name="Audit" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">
	<br><B>Year</B><br>
	#MeetingYear#
	<br><br>

	<b>Start Date</B> (Current: #dateformat(StartDate, "mm/dd/yyyy")#)<br>
	<INPUT TYPE="Text" NAME="e_StartDate" VALUE="#dateformat(StartDate, "mm/dd/yyyy")#" onchange="return Validate_e_StartDate()"><br><br>
	
	<b>End Date</B> (Current: #dateformat(EndDate, "mm/dd/yyyy")#)<br>
	<INPUT TYPE="Text" NAME="e_EndDate" VALUE="#dateformat(EndDate, "mm/dd/yyyy")#" onchange="return Validate_e_EndDate()"><br><br>
	
	<input name="Submit" type="Submit" value="Save Changes">
	</cfform>
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->