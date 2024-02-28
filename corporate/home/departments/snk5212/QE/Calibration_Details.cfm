<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<cfif Query2.StartDate eq Query2.EndDate>
	<cfset Date = "#dateformat(Query2.startdate, "mmmm d, yyyy")#">
<cfelseif Query2.StartDate neq Query2.EndDate>
    <cfif dateformat(Query2.StartDate, "mm") eq dateformat(Query2.EndDate, "mm")>
       <cfset Date = "#dateformat(Query2.startdate, "mmmm d")#-#dateformat(Query2.enddate, "d, yyyy")#">
    <cfelse>
       <cfset Date = "#dateformat(Query2.startdate, "mmmm dd")# - #dateformat(Query2.enddate, "mmmm dd, yyyy")#">
    </cfif>
</cfif>

<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator Calibration Meeting - #Date#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<br>
<cfoutput query="Query2">
<b>Dates of Meeting</b><br>
#Date#<br><br>

<b>Type of Meeting</b><br />
CAR Process<br /><br />
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM CalibrationMeetings_Attach
WHERE MeetingID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Remove = 'No'
</CFQUERY>
    
   	<cfoutput>
		<b>Attachments</b><br>
	</cfoutput>
	<cfif AttachCheck.recordcount eq 0>
		No Attachments Added<br><br>
	<cfelse>
    	<cfoutput query="AttachCheck">
        	:: 
			<cfif filelabel is "">
				#filename# - <a href="#IQARootDir#Calibration/#filename#">View</a>
			<cfelse>
            	#fileLabel# - <a href="#IQARootDir#Calibration/#filename#">View</a>
			</cfif><br>
        </cfoutput><br>
    </cfif>

<cfif isDefined("SESSION.Auth.isLoggedIn")>
<b>Meeting Action Items</b> (listed by Owner)<br><br />

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query"> 
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID,

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status

<!--- Login.Email, Login.Name --->

FROM CalibrationItems, CalibrationMeetings <!---, CAR_LOGIN "LOGIN" --->

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND CalibrationItems.MeetingID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
<!---
AND CalibrationItems.Owner = Login.Email

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
        	Item #ItemID#<cfif Status eq "no"></font></cfif> :: #Subject# [<a href="Calibration_Item.cfm?ID=#ID#">View</a>]<br>
		<cfset OwnerHolder = Owner>
	</cfoutput>
</cfif>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->