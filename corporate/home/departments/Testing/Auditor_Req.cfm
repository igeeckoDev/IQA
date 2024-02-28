<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT OfficeName, SubRegion, Region FROM IQAtbloffices
	WHERE Exist = 'Yes'
	ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditType" Datasource="Corporate">
	SELECT AuditType FROM AuditType
	ORDER BY AuditType
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Request to be an Auditor">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<script
	language="javascript"
	type="text/javascript"
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<cfparam name="form.link" default="No HTTP Referer">
<cfparam name="form.empNo" default="">

<!---
<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT first_n_middle, last_name, employee_email, employee_title, employee_type, location_code, department_number, employee_category, preferred_name, department_name

FROM
ULCUS.UL_HR_EMPLOYEE_GTD_VIEW

WHERE
employee_number='#form.EmpNo#'
</CFQUERY>
--->

  <cfset v_name = ''>
  <cfset v_title = ''>
  <cfset v_loc = ''>
  <cfset v_dept = ''>
  <cfset v_email = ''>
  <cfset v_deptName = ''>
  <cfset v_lastName = ''>
  <cfset qresult = 1>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Auditor_Req_Submit.cfm">

<INPUT TYPE="hidden" NAME="Status" VALUE="Requested">

<cfoutput>
Your Name:<br>
<cfINPUT size="75" TYPE="TEXT" NAME="Auditor" VALUE="#v_Name#" required="Yes" message="Name is Required"><br><br>

Email:<br>
<cfINPUT size="75" TYPE="TEXT" NAME="Email" VALUE="#v_email#" required="Yes" message="Email is Required"><br><br>

Title:<br>
<cfINPUT size="75" TYPE="TEXT" NAME="title" VALUE="#v_title#" required="Yes" message="Title is Required"><br><br>

<!---Location:<br>
<INPUT size="75" TYPE="TEXT" NAME="OfficeName" VALUE="#v_Loc#"><br><br>--->

Department Name and/or Number:<br>
<cfINPUT size="75" TYPE="TEXT" NAME="Dept" VALUE="" required="Yes" message="Department Name/Number is required"><br><br>

Phone:<br>
<cfINPUT TYPE="TEXT" NAME="Phone" VALUE="" required="Yes" message="Phone Number is required"><br><br>
</cfoutput>

Types of Audits Qualified to Conduct:<br>
(Hold Control to choose more than one)<br>
<CFSELECT NAME="AuditType" multiple="Yes" required="Yes" Message="Please select Types of Audits Qualified to Conduct" size="16">
		<OPTION Value="">Please Select Audit Type(s)
		<OPTION Value="">--
	<CFOUTPUT QUERY="AuditType">
		<OPTION VALUE="#AuditType#">#AuditType#
	</CFOUTPUT>
</CFSELECT>
<br><br>

Your Location:<br>
<CFSELECT NAME="OfficeName" required="Yes" Message="Please select your Location">
		<OPTION VALUE="">Please Select Your Location
	<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#!#SubRegion#!#Region#">#OfficeName# / #SubRegion# / #Region#
	</CFOUTPUT>
</CFSELECT>
<br><br>

Are you requesting to be a DAP, CTF and/or CBTL Auditor?<br>
Yes <input type="Radio" Name="DAP" Value="Yes"> No <INPUT TYPE="Radio" NAME="DAP" value="No" checked><br><br>

Are you requesting to be a Corporate Internal Quality Auditor?<br>
Yes <input type="Radio" Name="Corporate" Value="Yes"> No <INPUT TYPE="Radio" NAME="Corporate" value="No" checked><br><br>

Expertise:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Expertise" Value=""></textarea><br><br>

Training:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Training" Value=""></textarea><br><br>

Comments:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Comments" Value=""></textarea><br><br>

<cfoutput>
Confirm Auditor Last Name:<br>
<cfINPUT TYPE="TEXT" NAME="LastName" VALUE="#v_lastName#" required="Yes" message="Last name is required">
<br><br>
</cfoutput>

<br><br>
<INPUT TYPE="Submit" value="Submit Update">
</cfFORM>

<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->