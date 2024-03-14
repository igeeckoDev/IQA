<cfoutput>
<script
	language="javascript"
	type="text/javascript"
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "exact",
	content_css : "#SiteDir#SiteShared/cr_style.css",
	elements : "mce1,mce2,mce3"
});
</script>
</cfoutput>

<cfif NOT isDefined("URL.ID")>
	<cflocation url="Alerts.cfm" addtoken="No">
</cfif>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_ALERTS "ALERTS"
WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KP">
SELECT * FROM KP_Report_2
</CFQUERY>

<cfquery name="Clauses" DataSource="Corporate">
SELECT title FROM Clauses_2013July1
ORDER BY title
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND CB = 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate">
SELECT * FROM CAR_SECTOR "SECTOR"
ORDER BY Sector
</cfquery>

<!---<cfinclude template="inc_TOP.cfm">--->

<cfif isDefined("Form.Title")>

	<cfif Form.Attach is "">
	<cfelse>

	<CFFILE ACTION="UPLOAD"
	FILEFIELD="Attach"
	DESTINATION="#CARRootPath#alert"
	NAMECONFLICT="OVERWRITE">

	<cfset FileName="#Form.Attach#">

	<cfset NewFileName="#URL.ID#.#cffile.ClientFileExt#">

	<cffile
	    action="rename"
	    source="#FileName#"
	    destination="#CARRootPath#alert\#NewFileName#">
	</cfif>

<cfquery name="Update" datasource="Corporate" blockfactor="100">
UPDATE CAR_ALERTS "ALERTS"
SET

<cfif Form.Status is "Rejected">
Notes = <CFQUERYPARAM VALUE="#Form.Notes#" CFSQLTYPE="CF_SQL_CLOB">,
</cfif>
<cfif Form.Status is "Active">
Accepted = #CreateODBCDate(curdate)#,
</cfif>
<cfif len(Form.Attach)>
Attach = '#NewFileName#',
</cfif>
Title = '#Form.Title#',
Description = <CFQUERYPARAM VALUE="#Form.Description#" CFSQLTYPE="CF_SQL_CLOB">,
Evidence = <CFQUERYPARAM VALUE="#Form.Evidence#" CFSQLTYPE="CF_SQL_CLOB">,
Offices = '#Form.Offices#',
Sectors = '#Form.Sectors#',
KP = '#Form.KP#',
SC = '#Form.SC#',
cc = '#form.cc#',
Status = '#Form.Status#'

WHERE Year_ = #URL.Year# and ID = #URL.ID#
</cfquery>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_ALERTS "ALERTS"
WHERE ID = #URL.ID# AND YEAR_=#URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList">
SELECT * FROM IQADB_LOGIN "LOGIN"
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CARAdminList">
SELECT * FROM CARAdminList
WHERE (Status = 'Active' OR Status = 'CAR Administration Support' OR Status = 'In Training')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CAR">
SELECT * FROM  CAR_LOGIN "LOGIN"
WHERE status IS NULL
AND (AccessLevel <> 'AS')
AND Status IS NULL
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality.Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com)
ORDER BY Email
</CFQUERY>
--->

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<!--- <cfset Emails2 = #valueList(CAR.Email, ',')#> --->
<cfset Emails3 = #valueList(CARAdminList.Email, ',')#>
<cfset Emails4 = "Joe.Taylor@ul.com, Jon.F.Schuette@ul.com, Walter.E.Ballek@ul.com, Rodney.E.Morton@ul.com, James.E.Feth@ul.com, Lenore.J.Berman@ul.com, Dale.C.Hendricks@ul.com, Michael.Schneider@ul.com, Matthew.J.Marotto@ul.com, Deborah.Jennings-Conner@ul.com, Keith.A.Mowry@ul.com, Rick.A.Titus@ul.com, Lawrence.F.Michalowski@ul.com, Tammy.Wiseman@ul.com, #form.cc#">

<cfif Alerts.Status is "Active">
	<cfmail
    	to="#AuthEmail#, #Emails#, #Emails3#, #Emails4#"
    	From="Internal.Quality_Audits@ul.com"
        replyto="global.internalquality@ul.com"
        bcc="global.internalquality@ul.com"
        subject="Quality Alert #year_#-#id#"
        query="Alerts"
        type="HTML">
A Quality Alert has been published on the CAR Process Website.  A potential systemic or recurring issue has been identified. Please review your respective areas for this issue and make corrections as necessary. If you have any questions, please contact Denise Echols.<br /><br />

<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/qe/AlertView.cfm?Year=#Year_#&ID=#ID#">View</a> Quality Alert #Year_#-#ID#.
	</cfmail>
<cfelseif Alerts.Status is "Rejected">
	<cfmail
    	to="#AuthEmail#"
        From="CAR.Web.Quality.Alert@ul.com"
        cc="#form.cc#, global.internalquality@ul.com"
        subject="Status - Quality Alert #year_#-#id# - #Status#"
        query="Alerts"
        type="HTML">
			Quality Alert #year_#-#id# has been rejected.<br><br>

			#Notes#<br><br>

			For Questions or Comments, please contact Denise Echols.<br><br>

			<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/qe/AlertView.cfm?Year=#Year_#&ID=#ID#">View</a> Alert<br><br>
	</cfmail>
</cfif>

<cfoutput>
	<cflocation url="AlertView.cfm?#CGI.Query_String#" addtoken="No">
</cfoutput>

<cfelse>

<cfform enctype="multipart/form-data" name="ManageAlert" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">
<cfoutput query="Alerts">
<div class="blog-title">Quality Alert - Manage</div>

<B>Number</b>: #year_#-#id#</B><br>
<b>Author</b> - <a href="mailto:#AuthEmail#">#Author#</a><br>
<b>Date Submitted</b> - #dateformat(posted, "mm/dd/yyyy")#<br>
<cfif Status is "Active">
<b>Date Accepted</b> - #dateformat(accepted, "mm/dd/yyyy")#<br>
</cfif>
<br>

<b>Title/Subject</b>:<br>
<cfinput size="75" value="#Title#" name="title" required="yes" message="Please enter the subject" type="Text"><br><br>

<b>Description</b><Br>
<textarea id='mce1' WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Description">#Description#</textarea>
<br><br>

<b>Evidence</b><br>
<textarea id='mce2' WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Evidence">#Evidence#</textarea>
<br><br>

<!--- locations ---->
<b>Current Location(s) where issue has been identified</b>:<br>
<cfset Dump = #replace(Offices, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br>", "All")#>
<u>Current Selection</u>:<br />
#Dump2#

	<SELECT NAME="Offices" multiple>
		<OPTION VALUE="#Offices#" selected>Retain Current Selections
		</cfoutput>
		<CFOUTPUT QUERY="OfficeName">
			<OPTION VALUE="#OfficeName#!!">#OfficeName#
		</CFOUTPUT>
	</SELECT><br>
	* Hold Control to select multiple offices
	<br><br>

<!--- Sectors --->
<cfoutput query="Alerts">
<b>Sector(s) where issue has been indentified</b>:<br>
<cfset Dump = #replace(Sectors, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br>", "All")#>
<u>Current Selection</u>:<br />
#Dump2#

	<SELECT NAME="Sectors" multiple>
		<OPTION VALUE="#Sectors#" selected>Retain Current Selections
		</cfoutput>
		<CFOUTPUT QUERY="Sector">
			<OPTION VALUE="#Sector#!!">#Sector#
		</CFOUTPUT>
	</SELECT><br>
	* Hold Control to select multiple offices
	<br><br>

<!--- Key Process --->
<b>Key Process Impacted</b>: (select one)<br>
<cfoutput query="Alerts">
<u>Current Selection</u>: #KP#<br />

	<SELECT NAME="KP">
		<OPTION VALUE="#KP#" selected>Retain Current Selection
		</cfoutput>
		<CFOUTPUT QUERY="KP">
			<OPTION VALUE="#KP#">#KP#
		</CFOUTPUT>
	</SELECT>
	<br><br>

<!--- Standard Category --->
<cfoutput query="Alerts">
<b>Standard Category where issue has been indentified</b>: (select one)<br>
	<a href="#IQARootDir#matrix.cfm" target="_blank">View Matrix</a> for Standard Categories<br>
<u>Current Selection</u>:
#SC#<Br />

	<SELECT NAME="SC">
        <Option Value="#SC#" selected>Retain Current Selection
		</cfoutput>
        <CFOUTPUT QUERY="Clauses">
			<OPTION VALUE="#Title#">#Title#
		</CFOUTPUT>
	</SELECT>
	<br><br>

<cfoutput query="Alerts">
Attach a File: (Optional)<br>
<cfif attach is NOT "">Current Attachment: <a href="#CARRootDir#alert/#Attach#">View</a></cfif>
File Types Allowed: zip, xls, ppt, doc, pdf)<br>
<input name="Attach" type="File" size="50" onchange="return checkfile();">
<br><br>
</cfoutput>

<b>Status</b><br>
	<SELECT NAME="Status">
		<OPTION VALUE="">Select Status
		<OPTION VALUE="Active">Active - Email to Distribution List
		<OPTION VALUE="Awaiting Review">Awaiting Review - No Email
        <OPTION Value="Closed">Closed - Email to Distribution List
		<OPTION VALUE="Rejected">Rejected - Email to Author
	</select><br><br>

<cfoutput query="Alerts">
<b>Notes</b> - ONLY for Status = Rejected. Will be included in email if the alert is Rejected.<br>
<!---<cfif Notes is "">
	<cfset Blank = "Notes will be included in notification email if Accepted (to distribution list) or Rejected (to original Author)">
<cfelse>
	<cfset Blank = "#Notes#">
</cfif>--->
<textarea id='mce3' WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="Notes"></textarea>
<br><br>

<b>Email Distribution - cc</b> - <font class="warning">Please use commas between emails</font><br>
<textarea WRAP="virtual" ROWS="8" COLS="90" NAME="cc">#cc#</textarea><br><br>
</cfoutput>

<input type="submit" value="Submit">
</cfform>
</cfif>
