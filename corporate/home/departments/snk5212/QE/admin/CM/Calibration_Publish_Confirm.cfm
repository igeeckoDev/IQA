<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">  AND
CalibrationMeetings.ID = CalibrationItems.MeetingID

ORDER BY CalibrationItems.Owner, CalibrationItems.ItemID
</CFQUERY>

<cfif Query2.StartDate eq Query2.EndDate>
	<cfset Date = "#dateformat(Query2.startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(Query2.startdate, "mmmm d")#-#dateformat(Query2.enddate, "d, yyyy")#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset SubTitle = "#Query2.DB# Calibration Meeting - Publish Action Items">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<Br>
<cfoutput>
<u>Meeting Dates</u> - #Date#<br>
<u>Meeting Type</u> - #Query.DB#<br><br>
</cfoutput>

Are you sure you want to Publish the Calibration Meeting?<br>
This will send email notifications to Owners for each Calibration Action Item, seen below:<br><br>

<cfset i = 1>
<cfoutput query="Query">
#i# : <u>Action Item #ItemID#</u><br>
&nbsp;&nbsp; - <u>Owner</u>: #Owner#<br>
&nbsp;&nbsp; - <u>Subject</u>: #Subject#<Br>
&nbsp;&nbsp; - <u>Meeting Dates</u>: #Date#<br><br>
<cfset i = i+1>
</cfoutput><br>

<cfoutput>
<FORM METHOD="POST" name="Audit" ACTION="Calibration_Publish.cfm?ID=#URL.ID#">

<INPUT TYPE="Submit" name="Publish" Value="Confirm to Publish and Send Notifications">
<INPUT TYPE="Submit" name="Publish" Value="Cancel">

</form>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->