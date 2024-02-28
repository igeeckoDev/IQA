<!--- Start of Page File --->
<cfset subTitle = "<a href='CARAdminList.cfm'>CAR Administrator Profiles</a> - Edit CAR Administrator Profile">
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
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="CARTrainer" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE Trainer = 'Yes'
ORDER BY LastName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND CB = 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Backup" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE Status = 'Active'
ORDER BY Name
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Status" DataSource="Corporate">
SELECT Status FROM AuditorStatus
WHERE Status <> 'Denied'
ORDER BY Status
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
ORDER BY CARSource
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CARAdminDetails" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE ID = #URL.ID#
</cfquery>

<cfif isDefined("Form.Name")>

	<cfquery name="editCARAdmin" datasource="Corporate" blockfactor="100">
UPDATE CARAdminList
	SET
	<cfif DCQR eq "Yes">
	DCQRArea='#Form.DCQRArea#',
	<cfelse>
	DCQRArea=null,
	</cfif>
	Name='#form.name#',
	Location='#Form.Location#',
	Email='#Form.Email#',
	LastName='#Form.LastName#',
	Status='#Form.Status#',
	<cfif Form.Status is "In Training">
	CARTrainer='#Form.CarTrainer#',
	</cfif>
	Expertise='#Form.Expertise#',
	Training='#Form.Training#',
	x65='#Form.x65#',
	x17020='#Form.x17020#',
	x17025='#Form.x17025#',
	x17065='#Form.x17065#',
	Trainer='#Form.Trainer#',
	Backup=#Form.Backup#,
	DCQR='#Form.DCQR#',
	<cfif len(form.dateadded)>
	DateAdded=#CreateODBCDate(form.DateAdded)#,
	</cfif>
	CorpCarAdmin='#Form.CorpCarAdmin#'

	WHERE
	ID = #URL.ID#
</cfquery>

<cfoutput>
	<cflocation url="CARAdminView.cfm?ID=#URL.ID#" addtoken="No">
</cfoutput>

<cfelse>
<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#?#CGI.Query_String#" method = "post">

<cfoutput query="CARAdminDetails">
<!---
<cflock scope="SESSION" timeout="5">
	<cfif SESSION.Auth.AccessLevel eq "SU">
		<a href="CARAdminDelete_Confirm.cfm?ID=#URL.ID#">Delete Record</a><br /><br />
	</cfif>
</cflock>
--->

Name:<Br>
<cfinput value="#Name#" size="75" name="Name" required="yes" Message="Please Enter Full Name" type="text" Maxlength="128"><br><br>

Email: (external UL Email address)<br>
<cfinput value="#Email#" size="75" name="Email" required="yes" Message="Please enter external UL Email Address" type="text" Maxlength="255"><br><br>
</cfoutput>

Location:<Br>
<SELECT NAME="Location">
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#" <cfif Officename eq CARAdminDetails.Location>selected</cfif>>#OfficeName#
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="CARAdminDetails">
<b><u>Training Completed</u></b><br><br>
<b>Guide 65</b>:<br>
<cfset selValue=#CARAdminDetails.x65#>

<cfinput type="radio" name="x65" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x65" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b>ISO/IEC 17020</b>:<br>
<cfset selValue=#CARAdminDetails.x17020#>

<cfinput type="radio" name="x17020" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x17020" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b>ISO/IEC 17025</b>:<br>
<cfset selValue=#CARAdminDetails.x17025#>

<cfinput type="radio" name="x17025" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x17025" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b>ISO/IEC 17065</b>:<br>
<cfset selValue=#CARAdminDetails.x17065#>

<cfinput type="radio" name="x17065" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x17065" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b>Corporate CAR Admin</b>:<br>
<cfset selValue=#CARAdminDetails.CorpCarAdmin#>

<cfinput type="radio" name="CorpCarAdmin" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="CorpCarAdmin" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b><u>CAR Adminstrator Trainer</u></b><Br>
<cfset selValue=#CARAdminDetails.Trainer#>

<cfinput type="radio" name="Trainer" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="Trainer" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b><u>Designated Corporate Quality Reviewer</u></b><Br>
<cfset selValue=#CARAdminDetails.DCQR#>

<cfinput type="radio" name="DCQR" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="DCQR" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No
<br><br>

<b><u>Designated Areas for Designated Corporate Quality Reviewer</u></b><br>
Currently Selected: <cfif DCQRArea neq ""><br>#ListChangeDelims(DCQRArea, "<br>")#<cfelse>None Selected</cfif><br>
<SELECT NAME="DCQRArea" multiple size="10">
		<OPTION VALUE="#CARAdminDetails.DCQRArea#" selected>Retain Current Selections
</cfoutput>
<CFOUTPUT QUERY="CARSource">
		<OPTION VALUE="#CARSource#">#CARSource#
</CFOUTPUT>
</SELECT><br>
* Hold Control to select multiple items<br><br>

<b><u>CAR Admin Backup</u></b><Br>
<SELECT NAME="Backup">
	<cfif CarAdminDetails.Backup is 0>
		<OPTION VALUE="0" selected>None Selected
	</cfif>
		<OPTION VALUE="0">None Selected
<CFOUTPUT QUERY="Backup">
	<cfif Name neq CARAdminDetails.Name>
		<OPTION VALUE="#ID#" <cfif ID eq CarAdminDetails.Backup>selected</cfif>>#Name#
	</cfif>
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="CarAdminDetails">
<b><u>Training Comments</u></b><Br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="Training">#Training#</textarea>
<br><br>

<b><u>Expertise</u></b><Br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="Expertise">#Expertise#</textarea>
<br><br>
</cfoutput>

<b><u>Status</u></b><Br>
<SELECT NAME="Status" displayname="Status">
<CFOUTPUT QUERY="Status">
		<OPTION VALUE="#Status#" <cfif Status eq CARAdminDetails.Status>selected</cfif>>#Status#
</CFOUTPUT>
		<OPTION VALUE="CAR Administration Support">CAR Administration Support
</SELECT>
<br><br>

<b>CAR Admin Trainer</b> - For CAR Admins In Training<br>
<SELECT NAME="CARTrainer">
	<OPTION VALUE="">Not Applicable
<CFOUTPUT QUERY="CARTrainer">
	<OPTION VALUE="#Name#" <cfif Name eq CARAdminDetails.CARTrainer>selected</cfif>>#Name#
</cfoutput>
</SELECT>
<br><br>

<cfoutput query="CarAdminDetails">
<b><u>Confirm Last Name</u></b>:<Br>
<cfinput value="#LastName#" size="75" name="LastName" required="yes" Message="Please Enter Last Name" type="text" Maxlength="128"><br><br>

<b><u>CAR Admin Date</u> (date added as a CAR Admin)</b><br>
<cfinput value="#dateformat(DateAdded, 'mm/dd/yyyy')#" size="50" name="DateAdded" required="no" validate="date"><br><br>

<input type="submit" value="Submit">
</cfoutput>
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->