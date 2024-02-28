<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status, CalibrationItems.CompletedDate

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationItems.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
AND CalibrationMeetings.ID = CalibrationItems.MeetingID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query.DB# Calibration Meeting - Action Item Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<Br>
<cfoutput>
<u>Meeting</u> - #dateformat(Query.Startdate, "mmmm dd")#-#dateformat(Query.EndDate, "dd, yyyy")#<br>
<u>Meeting Type</u> - #Query.DB#<br />
<u>Action Item</u> - #Query.ItemID#<br><br>
</cfoutput>

<b><u>Options</u></b><br>
<cfoutput query="Query">
:: <a href="calibration_details.cfm?ID=#mID#">Return</a> to Meeting Details<br>
<cflock scope="SESSION" timeout="5">
	<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "Admin" OR SESSION.Auth.Username eq "Heinzinger" OR SESSION.Auth.Username eq "Peck">
		:: <a href="Calibration_Item_Edit.cfm?ID=#ID#">Edit</a> Action Item<br>
	</cfif>
</cflock><br>

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