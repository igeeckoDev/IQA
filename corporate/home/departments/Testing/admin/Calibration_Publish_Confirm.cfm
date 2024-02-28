<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND CalibrationMeetings.ID = CalibrationItems.MeetingID

ORDER BY CalibrationItems.Owner, CalibrationItems.ItemID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Calibration Meeting Publish - CM-#Query2.MeetingYear#-#Query2.MeetingID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
Are you sure you want to Publish the Calibration Meeting?<br>
This will send email notifications to Owners for each Calibration Action Item, seen below:<br><br>

<cfset i = 1>
<cfoutput query="Query">
#i# : CM-#MeetingYear#-#MeetingID#, Item #ItemID#<br>
&nbsp;&nbsp; - #Subject#<Br>
&nbsp;&nbsp; - #Owner#<br><br>
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