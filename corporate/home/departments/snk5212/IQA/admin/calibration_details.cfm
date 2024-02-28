<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cfif Query2.StartDate eq Query2.EndDate>
	<cfset Date = "#dateformat(Query2.startdate, "mmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(Query2.startdate, "mmm d")#-#dateformat(Query2.enddate, "d, yyyy")#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query2.DB# Calibration Meeting - #Date#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br />
<cfif isDefined("URL.msg")>
	<cfoutput>
		<font color="red">Update:</font> #url.msg#
	</cfoutput><br><Br>
</cfif>

<cflock scope="SESSION" timeout="5">
	<cfif SESSION.Auth.AccessLevel eq "SU"
		OR SESSION.Auth.AccessLevel eq "Admin"
		OR SESSION.Auth.Username eq "Heinzinger"
		OR SESSION.Auth.Username eq "Peck">
            <b><u>Options</u></b><br>
            <cfoutput>
            :: <a href="Calibration_FileUpload.cfm?ID=#URL.ID#">Add</a> Attachment / Upload File<br>
            :: <a href="Calibration_Item_Add.cfm?ID=#URL.ID#">Add</a> Meeting Action Item<br>
            :: <a href="Calibration_Details_Edit.cfm?ID=#URL.ID#">Edit</a> Meeting Dates<br>
            :: <a href="Calibration_Publish_Confirm.cfm?ID=#URL.ID#">Publish</a> - Send Notifications of Action Items to each Owner<br>
            :: <a href="Calibration_FileRemove.cfm?ID=#URL.ID#">Remove / Reinstate</a> a File / Attachment<Br><Br>
            </cfoutput>
	</cfif>
</cflock>

<cfoutput query="Query2">
<b>Dates of Meeting</b><br>
#dateformat(Startdate, "mmmm dd")#-#dateformat(EndDate, "dd, yyyy")#<br><br>

<b>Type of Meeting</b><br />
#DB#<br /><br />
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM CalibrationMeetings_Attach
WHERE MeetingID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Remove = 'No'
ORDER BY FileLabel, FileName, ID
</CFQUERY>

   	<cfoutput>
		<b>Attachments</b><br />
	</cfoutput>
	<cfif AttachCheck.recordcount eq 0>
		No Attachments Added<br><br>
	<cfelse>
    	<cfoutput query="AttachCheck">
        	::
			<cfif filelabel is "">
				#filename# - <a href="../calibration/#filename#">View</a>
			<cfelse>
            	#fileLabel# - <a href="../calibration/#filename#">View</a>
			</cfif><br>
        </cfoutput><br>
    </cfif>

<cfoutput>
<b>Meeting Action Items</b> (listed by Owner - Red Text indicates the Action Item is Open)<br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear,
CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate,
CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status

<!--- Login.Email, Login.Name, Login.IQA --->

FROM  CalibrationItems, CalibrationMeetings <!---, IQADB_LOGIN "LOGIN" --->

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND CalibrationMeetings.ID = CalibrationItems.MeetingID
<!---
AND CalibrationItems.Owner = Login.Email
AND Login.IQA = 'Yes'
--->

ORDER BY CalibrationItems.Owner, CalibrationItems.ItemID
</CFQUERY>

<cfif query.recordcount eq 0>
	No Action Items
<cfelse>
	<cfset OwnerHolder = "">
	<cfoutput query="Query">
		<cfif OwnerHolder IS NOT Owner>
		<cfIf OwnerHolder is NOT ""><br></cfif>
		<u>#Owner#</u><br>
		</cfif>
		<cfif Status eq "No"><font color="red"></cfif>
        	Item #ItemID#<cfif Status eq "no"></font></cfif> :: <a href="Calibration_Item.cfm?ID=#ID#">#Subject#</a>
			<cfif Status eq "No"> (Due: #dateformat(DueDate, "mm/dd/yyyy")#)<cfelse>(Completed)</cfif><br>
		<cfset OwnerHolder = Owner>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->