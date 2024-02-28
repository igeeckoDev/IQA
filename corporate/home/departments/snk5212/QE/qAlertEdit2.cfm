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
	elements: "mce1,mce2,mce3"
});
</script>
</cfoutput>

<cfif NOT isDefined("URL.ID")>
	<cflocation url="Alerts.cfm" addtoken="No">
</cfif>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND CB = 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate">
SELECT * FROM  CAR_SECTOR  "SECTOR" ORDER BY Sector
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KP">
SELECT * FROM KP_Report_2
ORDER BY KP
</CFQUERY>

<cfquery name="Clauses" DataSource="Corporate">
SELECT title FROM Clauses_2013July1
ORDER BY title
</cfquery>

<!---<cfinclude template="inc_TOP.cfm">--->

<cfif isDefined("Form.Title")>

	<cfif Form.Attach is "">
	<cfelse>

	<CFFILE ACTION="UPLOAD"
	FILEFIELD="Attach"
	DESTINATION="#path#alert"
	NAMECONFLICT="OVERWRITE">

	<cfset FileName="#Form.Attach#">

	<cfset NewFileName="#URL.ID#.#cffile.ClientFileExt#">

	<cffile
	    action="rename"
	    source="#FileName#"
	    destination="#path#alert\#NewFileName#">
	</cfif>

<cfquery name="Update" datasource="Corporate" blockfactor="100">
UPDATE CAR_ALERTS  "ALERTS" SET


Notes = <CFQUERYPARAM VALUE="#Form.Notes#" CFSQLTYPE="CF_SQL_CLOB">,
<cfif Form.Attach is NOT "">
Attach = '#NewFileName#',
</cfif>
Title = '#Form.Title#',
Description = <CFQUERYPARAM VALUE="#Form.Description#" CFSQLTYPE="CF_SQL_CLOB">,
Evidence = <CFQUERYPARAM VALUE="#Form.Evidence#" CFSQLTYPE="CF_SQL_CLOB">,
Offices = '#Form.Offices#',
Sectors = '#Form.Sectors#',
SC = '#form.SC#',
KP = '#Form.KP#',
cc = '#form.cc#'

WHERE Year_ = #URL.Year# and ID = #URL.ID#
</cfquery>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT *
 FROM CAR_ALERTS  "ALERTS"
 WHERE ID = #URL.ID#  AND YEAR_=#URL.Year#
</cfquery>

<cfoutput>
	<cflocation url="AlertView.cfm?#CGI.Query_String#" addtoken="No">
</cfoutput>

<cfelse>

<cfform enctype="multipart/form-data" name="ManageAlert" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">
<cfoutput query="Alerts">
<div class="blog-title">Quality Alert - Manage</div>

<B>Number</b>: #year#-#id#</B><br>
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

<b>Current Location(s) where issue has been identified</b>:<br>
<cfset Dump = #replace(Offices, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br><Br>", "All")#>
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

<cfoutput query="Alerts">
<b>Sector(s) where issue has been indentified</b>:<br>
<cfset Dump = #replace(Sectors, "!!,", "<Br>", "All")#>
<cfset Dump2 = #replace(Dump, "!!", "<br><Br>", "All")#>
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
		<OPTION VALUE="Active">Active
		<OPTION VALUE="Awaiting Review">Awaiting Review
        <OPTION Value="Closed">Closed
		<OPTION VALUE="Rejected">Rejected (No Email to Author)
	</select><br><br>

<cfoutput query="Alerts">
<b>Notes</b> - ONLY for Status = Rejected. Will be included in email if the alert is Rejected.<br>
<!---<cfif Notes is "">
	<cfset Blank = "Notes will be included in notification email if Accepted (to distribution list) or Rejected (to original Author).<br><br>Please delete this text if you do not wish to have any Notes listed.">
<cfelse>
	<cfset Blank = "#Notes#">
</cfif>--->
<textarea id='mce3' WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="Notes"></textarea>
<br><br>

<b>Email Distribution - cc</b> - <font class="warning">Please use commas between emails</font><br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="90" NAME="cc">#cc#</textarea>
<br><br>
</cfoutput>

<input type="submit" value="Submit">
</cfform>
</cfif>