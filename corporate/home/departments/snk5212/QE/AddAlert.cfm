<!--- Start of Page File --->
<cfset subTitle = "Add Quality Alert">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<script
	language="javascript"
	type="text/javascript"
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#Siteshared/cr_style.css"
});
</script>
</cfoutput>

<cfinclude template="#CARRootDir#inc_TOP.cfm">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM  CAR_ALERTS "ALERTS"
</CFQUERY>

<cfquery name="Clauses" DataSource="Corporate">
SELECT title FROM Clauses_2013July1
ORDER BY title
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KP">
SELECT * FROM KP_Report_2
ORDER BY KP
</CFQUERY>

<Cfif Check.recordcount eq 0>
	<cfset Alert.maxid = 1>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Alert">
	SELECT MAX(ID) + 1 AS maxid FROM  CAR_ALERTS  "ALERTS"
	</CFQUERY>
</CFIF>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND Finance = 'Yes'
AND CB = 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate">
SELECT * FROM  CAR_SECTOR  "SECTOR" ORDER BY Sector
</cfquery>

<cfparam name="form.EmpNo" type="string" default="NA">

<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT first_n_middle, last_name, preferred_name, employee_email
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
WHERE employee_number = '#form.EmpNo#'
</CFQUERY>

<cfif form.EmpNo eq "NA" OR QEmpLookup.recordcount gt 0>
   <cfif QEmpLookup.preferred_name neq "">
   <cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
   <cfelse>
   <cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
   </cfif>
  <cfset v_email = #QEmpLookup.employee_email#>
  <cfset qresult = 0>
<cfelse>
  <cfset v_name = ''>
  <cfset v_email = ''>
  <cfset qresult = 1>
</cfif>

<cfif IsDefined("Form.Name")>
	<cfif Form.Attach is NOT "">

	<CFFILE ACTION="UPLOAD"
	FILEFIELD="Attach"
	DESTINATION="#path#alert\"
	NAMECONFLICT="OVERWRITE">

	<cfset FileName="#Form.Attach#">

	<cfset NewFileName="#Alert.maxID#.#cffile.ClientFileExt#">

	<cffile
	    action="rename"
	    source="#FileName#"
	    destination="#path#alert\#NewFileName#">
	</cfif>

<cfquery name="addAlert" datasource="Corporate" blockfactor="100">
INSERT INTO CAR_ALERTS "ALERTS" (ID, Year_, Description, Evidence, Attach, Offices, Sectors, Author, AuthEmail, Posted, Status, Title, KP, SC)
VALUES(#Alert.maxId#, #curyear#, '#Form.Description#', '#form.Evidence#', <cfif form.attach is "">''<cfelse>'#NewFileName#'</cfif>, '#Form.Offices#', '#Form.Sectors#', '#form.name#', '#form.email#', #CreateODBCDate(curdate)#, 'Awaiting Review', '#form.title#', '#form.KP#', '#form.SC#')
</cfquery>

<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE ID = #Alert.maxId#
</cfquery>

<cfmail to="#Request.AlertEmail#" from="CAR.Web.Quality.Alert@ul.com" bcc="Christopher.J.Nicastro@ul.com" subject="Quality Alert Submitted" query="Alerts" type="HTML">
<table><tr><td class="blog-content">
A Quality Alert has been submitted: <br>
<a href="http://#CGI.Server_Name#/departments/snk5212/qe/AlertView.cfm?Year=#Year_#&ID=#ID#">View</a> Alert<br><br>
</td></tr></table>
</cfmail>

<cfmail to="#AuthEmail#" from="CAR.Web.Quality.Alerts@ul.com" subject="Quality Alert Submitted" query="Alerts" Type="HTML">
<table><tr><td class="blog-content">
Thank you for your submission. You may be contacted to discuss this Quality Alert before it is posted to the CAR Admin Web Site.<br><br>

<a href="http://#CGI.Server_Name#/departments/snk5212/qe/AlertView.cfm?Year=#Year_#&ID=#ID#">View</a> Alert<br><br>
</td></tr></table>
</cfmail>

	<cflocation url="AlertView.cfm?year=#curyear#&ID=#Alert.MaxID#" addtoken="No">

<cfelse>

	<cfform name="addAlert" action="#CGI.SCRIPT_NAME#" method="POST" enctype="multipart/form-data">
	<cfoutput>
	<b>Quality Alert Number</b>: #curyear#-#alert.MaxID#<br><br>

	This Quality Alert Request will be reviewed before posting on the CAR Admin Web Site.<br><br>

	<b>Date</b>: #dateformat(curdate, "mm/dd/yyyy")#<Br>
	<b>Author</b>: #v_name#<br>
	<input type="hidden" name="name" value="#v_name#">
	<b>Email</b>: #v_email#<br><br>
	<input type="hidden" name="email" value="#v_email#">
	<input type="hidden" name="EmpNo" value="#form.EmpNo#">

	<b>Title/Subject</b>:<br>
	<cfinput size="75" name="title" required="yes" message="Please enter the subject" type="Text"><br><br>

<cfset descrip = "Please provide a description of the issue">

	<b>Description</B>:<br>
	<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Description">#descrip#</textarea><br><br>

<cfset eviden = "List all corresponding CAR Numbers, Customer Complaint Numbers, Field Report Numbers, Project Numbers, etc">

	<b>Evidence of Issue</B>:<br>
	<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Evidence">#eviden#</textarea><br><br>
	</cfoutput>

	<b>Current Location(s) where issue has been identified</b>:<br>
	<SELECT NAME="Offices" size="8" multiple>
		<OPTION VALUE="None Selected<br><br>" selected>Select Locations Below
		<CFOUTPUT QUERY="OfficeName">
			<OPTION VALUE="#OfficeName#!!">#OfficeName#
		</CFOUTPUT>
	</SELECT><br>
	* Hold Control to select multiple offices
	<br><br>

	<b>Sector(s) where issue has been indentified</b>:<br>
	<SELECT NAME="Sectors" size="8" multiple>
		<OPTION VALUE="None Selected<br><br>" selected>Select Sectors Below
		<CFOUTPUT QUERY="Sector">
			<OPTION VALUE="#Sector#!!">#Sector#
		</CFOUTPUT>
	</SELECT><br>
	* Hold Control to select multiple offices
	<br><br>

	<b>Key Process Impacted</b>: (select one)<br>
	<SELECT NAME="KP">
		<OPTION VALUE="None Selected" selected>Select Key Process Below
		<CFOUTPUT QUERY="KP">
			<OPTION VALUE="#KP#">#KP#
		</CFOUTPUT>
	</SELECT>
	<br><br>

	<b>Standard Categories</b>: (select one)<br>
	<cfoutput>
		<a href="#IQARootDir#matrix.cfm" target="_blank">View Matrix</a> for Standard Categories<br>
	</cfoutput>
	<SELECT NAME="SC">
		<OPTION VALUE="None Selected" selected>Select Standard Category Below
		<CFOUTPUT QUERY="Clauses">
			<OPTION VALUE="#Title#">#Title#
		</CFOUTPUT>
	</SELECT>
	<br><br>

	Attach a File: (Optional)<br>
	File Types Allowed: zip, xls, ppt, doc, pdf)<br>
	<input name="Attach" type="File" size="50">
	<br><br>

	<input type="submit" value="Submit">
	</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->