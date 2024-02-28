<cfif Form.Publish is "Cancel">
	<cflocation url="Calibration_Details.cfm?ID=#URL.ID#" addtoken="no">
<cfelseif Form.Publish is "Confirm to Publish and Send Notifications">

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

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AllList"> 
SELECT Name, Email FROM IQADB_LOGIN
WHERE IQA = 'Yes'
AND Status IS NULL

UNION

SELECT Name, Email FROM CAR_LOGIN
WHERE QE = 'Yes'

ORDER BY Name
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IQAList"> 
SELECT Name, Email FROM IQADB_LOGIN
WHERE IQA = 'Yes'
AND Status IS NULL
ORDER BY Name
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AuditorList"> 
SELECT Name, Email FROM IQADB_LOGIN 
WHERE IQA = 'Yes'
AND Status IS NULL
ORDER BY Name
</cfquery>

<cfif Query.Owner eq "All Auditors">
	<cfset EmailList = #valueList(AuditorList.Email, ', ')#>
<cfelseif Query.Owner eq "All IQA">
	<cfset EmailList = #valueList(IQAList.Email, ', ')#>
<cfelseif Query.Owner eq "All QE">
	<cfset EmailList = #valueList(AllList.Email, ', ')#>
<cfelse>
	<cfset EmailList = "#Query.Owner#">
</cfif>

<cfmail query="Query" to="Internal.Quality_Audits@ul.com" from="Internal.Quality_Audits@ul.com" subject="#DB# Calibration Meeting Action Item #ItemID# has been assigned to you" type="HTML">
Originally sent to: #EmailList#<br><br>

<cfif StartDate eq EndDate>
	<cfset Date = "#dateformat(startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(startdate, "mmmm d")#-#dateformat(enddate, "d, yyyy")#">
</cfif>

<div class="blog-content">
Originally sent to: <cfif Owner eq "All">#EmailList#<cfelse>#Owner#</cfif><br><br>

You have been assigned the Owner of an Action Item from a #DB# Calibration Meeting<br>
<u>Action Item</u>: #ItemID#<br>
<u>Meeting Date(s)</u>: #Date#<br>
<u>Action Item Due Date</u>: #dateformat(DueDate, "mm/dd/yyyy")#<br>
<u>Date Added</u>: #dateformat(DateAdded, "mm/dd/yyyy")#<br>
<u>Subject</u>: #Subject#<br>
<u>Notes</u>: 
<cfset Dump = #replace(Notes, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

Please follow the link below to view this Item.<br>
<b>Note</b>: You must be logged in to the IQA Audit Database website to view this link.<br><br>

<a href="http://#CGI.Server_Name#/departments/snk5212/IQA/admin/Calibration_Item.cfm?ID=#ID#">View</a> Action Item #ItemID#.
</div>
</cfmail>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query.DB# Calibration Meeting - Publish Action Items">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset i = 1>
<cfoutput query="Query">
#i# : CM-#MeetingYear#-#MeetingID#, Item #ItemID# sent to #Owner#<br>
<cfset i = i+1>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
</cfif>