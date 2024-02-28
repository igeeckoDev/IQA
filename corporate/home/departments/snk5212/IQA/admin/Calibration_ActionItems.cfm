<cfparam name="URL.View" default="All">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status

<!--- Login.Email, Login.Name, Login.IQA --->

FROM CalibrationItems, CalibrationMeetings <!--- , IQADB_LOGIN "LOGIN" --->

WHERE CalibrationMeetings.ID = CalibrationItems.MeetingID
<!---
AND CalibrationItems.Owner = Login.Email
AND Login.IQA = 'Yes'
AND CalibrationMeetings.DB = 'Corporate'
--->
<cfif isDefined("URL.View")>
	<cfif URL.View eq "Open">
		AND CalibrationItems.Status = 'No'
	<cfelseif URL.View eq "Closed">
    	AND CalibrationItems.Status = 'Yes'
	</cfif>
</cfif>

ORDER BY
	CalibrationItems.Owner,
	CalibrationMeetings.MeetingYear DESC,
    CalibrationMeetings.Startdate DESC,
    CalibrationItems.ItemID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Calibration Meeting Action Items - #URL.View# Items">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Note</b> - Open Action Items - The subject of will appear <font class=warning>in red text</font> in the list below.<br><br>

<cfset OwnerHolder = "">

<cfif Query.recordcount gt 0>
	<cfoutput query="Query">
		<cfif OwnerHolder IS NOT Owner>
		<cfIf OwnerHolder is NOT ""><br></cfif>
			<u>#Owner#</u><br>
		</cfif>

	<cfif StartDate eq EndDate>
		<cfset Date = "#dateformat(startdate, "mmm d, yyyy")#">
	<cfelse>
		<cfset Date = "#dateformat(startdate, "mmm d")#-#dateformat(enddate, "d, yyyy")#">
	</cfif>

	#Date# (#DB#) - <a href="Calibration_Item.cfm?ID=#ID#">Item #ItemID#</a> :: <cfif Status eq "No"><font color="red"></cfif>#Subject#<cfif Status eq "No"></font></cfif><br>
	<cfset OwnerHolder = Owner>
	</cfoutput>
<cfelse>
	<cfoutput>
	No Items were found (Criteria: #URL.View# Items)
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->