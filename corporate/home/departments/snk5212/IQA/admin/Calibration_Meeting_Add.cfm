<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Calibration Meeting">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT * FROM CalibrationMeetings
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<cfif IsDefined("Form.e_StartDate") AND isDefined("Form.e_EndDate") AND isDefined("Form.e_MeetingYear")>

<cfset Form.e_StartDate = dateformat(Form.e_StartDate, "mm/dd/yyyy")>
<cfset Form.e_EndDate = dateformat(Form.e_EndDate, "mm/dd/yyyy")>

<!--- CalibrationMeetings.ID Assignment --->
<!--- check to see if any meetings entered yet --->
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
	SELECT * FROM CalibrationMeetings
	</CFQUERY>
	
<!--- if not set variable to 1, for first record --->	
	<cfif check.recordcount eq 0>
		<cfset maxId.maxID = 1>
	<cfelse>
<!--- if there are items, find max ItemID and add 1 --->
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxID">
		SELECT MAX(ID)+1 as maxID FROM CalibrationMeetings
		</CFQUERY>
	</cfif>
<!--- // --->

<!--- CalibrationMeetings.MeetingID Assignment --->
<!--- check to see if any meetings entered yet --->
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
	SELECT * FROM CalibrationMeetings
	WHERE MeetingYear = #Form.e_MeetingYear#
	</CFQUERY>
	
<!--- if not set variable to 1, for first record --->	
	<cfif check.recordcount eq 0>
		<cfset maxMeetingId.maxMeetingID = 1>
	<cfelse>
<!--- if there are items, find max ItemID and add 1 --->
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxMeetingID">
		SELECT MAX(MeetingID)+1 as maxMeetingID FROM CalibrationMeetings
		WHERE MeetingYear = #Form.e_MeetingYear#
		</CFQUERY>
	</cfif>
<!--- // --->

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxMeetingID">
	INSERT INTO CalibrationMeetings(ID, MeetingID, MeetingYear, StartDate, EndDate, DB)
	VALUES(#maxID.maxID#, #maxMeetingID.maxMeetingID#, #Form.e_Meetingyear#, #CreateODBCDate(Form.e_Startdate)#, #CreateODBCDate(Form.e_Enddate)#, '#FORM.e_DB#')
	</cfquery>
	
	<cflocation url="Calibration_Details.cfm?ID=#maxID.maxID#" addtoken="no">

<cfelse>

	<cfform name="Audit" action="#CGI.SCRIPT_NAME#" method="post" enctype="multipart/form-data">
    
    <cfset nextYear = #curyear# + 1>
    
	<br><B>Year</B><br>
	<SELECT NAME="e_MeetingYear" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
	<cfloop index="i" to="#nextyear#" from="2006">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
	</cfloop>
	</SELECT>
	<br><br>

	<b>Type of Meeting</b><br />
	<SELECT NAME="e_DB" displayname="Type of Meeting">
		<option value="">Select Type of Meeting Below
		<option value="">---
		<option value="CAR">CAR Admin
		<option value="QE">QE (includes Lead Auditor Meetings)
	</SELECT>
	<br><br>
		
	<b>Start Date</B><br>
	<INPUT TYPE="Text" NAME="e_StartDate" VALUE="" onchange="return ValidateSDate()" displayname="Meeting Start Date"><br><br>
	
	<b>End Date</B><br>
	Please enter the Start Date again if this is a one day meeting.<br>
	<INPUT TYPE="Text" NAME="e_EndDate" VALUE="" onchange="return ValidateEDate()" displayname="Meeting End Date"><br><br>
	
	<b>Meeting Minutes - File Upload</b><br>
	Note - You can upload files once the meeting is created.<br><br>
	
	<INPUT TYPE="button" value="Save New Calibration Meeting" onClick=" javascript:checkFormValues(document.all('Audit'));">
	</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->