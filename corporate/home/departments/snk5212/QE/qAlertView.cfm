<cfif NOT isDefined("URL.ID")>
	<cflocation url="Alerts.cfm" addtoken="No">
</cfif>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE ID = #URL.ID#
</cfquery>

<cfinclude template="inc_TOP.cfm">

<cfoutput query="Alerts">
<cflock scope="Session" Timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel is "SU">
	    :: <a href="#CARRootDir#AlertEdit2.cfm?Year=#year#&id=#ID#">Edit</a> Quality Alert - <b><font class="warning">No Notifications</font></b> are sent<br>
        :: <a href="#CARRootDir#AlertEdit.cfm?Year=#year#&id=#ID#">Edit </a> Quality Alert - Notifications will be sent<br /><br />
	</cfif>
</cflock>
</cfoutput>

<cfoutput query="Alerts">
<B>Quality Alert ID</b>: #year#-#id#</B><br>
<b>Submitted By</b> - <a href="mailto:#AuthEmail#">#Author#</a><br>
<b>Title/Subject</b> - #Title#<br>
<cfif status is "Active">
	<b>Date Posted</b> - #dateformat(posted, "mm/dd/yyyy")#<br>
    <b>Date Accepted</b> - #dateformat(accepted, "mm/dd/yyyy")#
<cfelseif status is "Awaiting Review">
	<b>Date Posted</b> - #dateformat(posted, "mm/dd/yyyy")#
<cfelseif status is "Rejected">
    <b>Date Posted</b> - #dateformat(posted, "mm/dd/yyyy")#<br>
    <b>Date Rejected</b> - #dateformat(rejected, "mm/dd/yyyy")#
</cfif><br>

<!---<b>Date Posted</b> - #dateformat(Accepted, "mm/dd/yyyy")#<br>--->
<b>Status</b> - <font color="red"><b>#Status#</b></font><br><br>

<b>Description</b><br>
<cfset Dump = #replace(Description, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<b>Evidence</b><br>
<cfset Dump = #replace(Evidence, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#

<b>Current Location(s) where issue has been identified</b>:<br>
<cfset Dump = #replace(Offices, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br><Br>", "All")#>
#Dump2#

<b>Sector(s) where issue has been indentified</b>:<br>
<cfset Dump = #replace(Sectors, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br><Br>", "All")#>
#Dump2#

<b>Key Process Impacted</b>:<br>
#KP#<br><br>

<b>Standard Category Impacted</b>:<br>
#SC#<br><br>

<!---
<cfif Notes is NOT "">
<b>Notes</b><br>
<cfset Dump = #replace(Notes, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfif>
--->

<cfif Status is "Awaiting Review" or Status is "Active">
<b>Distribution List</b>:<br />
CAR Admins<br />
IQA Staff<br />
Local and Regional Quality Managers<br />
Jim Feth<br>
Walt Ballek<br>
Rod Morton<br>
Joe Taylor<br />
Jon Schuette<br>
Lenore Berman<br />
Dale Hendricks<br />
Michael Schneider<br />
Deborah Jennings-Conner<br>
Matt Marotto<br>
Keith Mowry<br>
Rick Titus<br>
Larry Michalowski<br>
Tammy Wiseman<br>
<cfset Dump = #replace(cc, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
<cfset Dump3 = #replace(Dump2, ",", "<br>", "All")#>
#Dump3#<br /><br />
</cfif>

<cfif attach is NOT ""><b>Attachment</b><br />
 - <a href="#CARRootDir#alert/#Attach#">View file</a></cfif>
</cfoutput>