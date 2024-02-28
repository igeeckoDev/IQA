<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<cfif Query2.StartDate eq Query2.EndDate>
	<cfset Date = "#dateformat(Query2.startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(Query2.startdate, "mmmm d")#-#dateformat(Query2.enddate, "d, yyyy")#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query2.DB# Calibration Meeting - Remove/Reinstate Uploaded Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->


<br>
<cfoutput>
<u>Meeting Dates</u> - #Date#<br>
<u>Meeting Type</u> - #Query2.DB#<br /><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM CalibrationMeetings_Attach
WHERE MeetingID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>
    
	You can Remove or Reinstate an uploaded file below. This will remove/add the file to the Meetings Detail page.<Br><br>
	
   	<cfoutput>
		<b>Attachments</b><br>
    </cfoutput>
	<cfif AttachCheck.recordcount eq 0>
		No Attachments Added<br><br>
	<cfelse>
    	<cfoutput query="AttachCheck">
			<cfif Remove eq 0>
				<cfset status = "Remove">
				<cfset statuschange = "Yes">
			<cfelseif Remove eq 1>
				<cfset status = "Reinstate">
				<cfset statuschange = "No">
			</cfif>
		
        	:: 
			<cfif filelabel is "">
				#filename# - <a href="Calibration_FileRemove_Update.cfm?MeetingID=#MeetingID#&ID=#ID#&Remove=#statuschange#">#status#</a> 
			<cfelse>
            	#fileLabel# (#filename#) - <a href="Calibration_FileRemove_Update.cfm?MeetingID=#MeetingID#&ID=#ID#&Remove=#statuschange#">#status#</a> 
			</cfif><br>
        </cfoutput><br>
    </cfif>
	
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->