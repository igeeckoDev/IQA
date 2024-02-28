<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB, 

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status, CalibrationItems.CompletedDate

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationItems.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> AND
CalibrationMeetings.ID = CalibrationItems.MeetingID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "#Query.DB# Calibration Meeting - Action Item #Query.ItemID# Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<Br>
<cfoutput query="Query">
<cfif StartDate eq EndDate>
	<cfset Date = "#dateformat(startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(startdate, "mmmm d")#-#dateformat(enddate, "d, yyyy")#">
</cfif>

<u>Meeting Dates</u> - #Date#<br>
<u>Meeting Type</u> - #DB#<br />
<u>Action Item</u> - #ItemID#<br><br>

<B>Subject</B><br>
#Subject#<br><br>

<B>Date Added</B><br>
#dateformat(DateAdded, "mm/dd/yyyy")#<br><br>

<B>Due Date</B><br>
#Dateformat(DueDate, "mm/dd/yyyy")#<br><br>

<B>Owner</B><br>
#Owner#<br><br>

<B>Added By</B><br>
#AddedBy#<br><br>

<B>Notes</B><br>
	<cfset Dump = #replace(Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
	
<b>Status</b><br>
<cfif Status is "No">
	Open
<cfelseif Status is "Yes">
	Completed<br><br>
	
	<b>Completion Date</b><br>
	#dateformat(CompletedDate, "mm/dd/yyyy")#
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->