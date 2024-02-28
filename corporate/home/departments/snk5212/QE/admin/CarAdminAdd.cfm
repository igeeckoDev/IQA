<!--- Start of Page File --->
<cfset subTitle = "Add CAR Administrator">
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

<cfif isDefined("URL.ID")>
<CFQUERY BLOCKFACTOR="100" NAME="View" DataSource="Corporate">
SELECT * FROM CARAdminRequest
WHERE ID = #URL.ID#
</cfquery>
<cfelse>
	<cfset View.name="">
	<cfset View.Email="">
	<cfset View.Location="">
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND Finance = 'Yes'
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

<cfif isDefined("Form.Training")>

	<cfquery name="addID" datasource="Corporate" blockfactor="100">
SELECT MAX(ID)+1 as maxId FROM CARAdminList
</cfquery>

	<cfquery name="addCARAdmin" datasource="Corporate" blockfactor="100">
INSERT INTO CARAdminList(ID)
VALUES(#addID.maxId#)
</cfquery>

	<cfparam name="Form.DCQRArea" default="">

	<cfquery name="addCARAdmin2" datasource="Corporate" blockfactor="100">
	UPDATE CARAdminList
	SET
	DCQRArea = '#Form.DCQRArea#',
	Name='#form.name#',
	Location='#Form.Location#',
	Email='#Form.Email#',
	LastName='#Form.LastName#',
	Status='#Form.Status#',
	Expertise='#Form.Expertise#',
	Training='#Form.Training#',
	x65='#Form.x65#',
	x17020='#Form.x17020#',
	x17025='#Form.x17025#',
	x17065='#Form.x17065#',
	Trainer='#Form.Trainer#',
	Backup=#Form.Backup#,
	DCQR='#Form.DCQR#',
	<cfif form.dateadded is "">
	<cfelse>
	DateAdded=#CreateODBCDate(form.DateAdded)#,
	</cfif>
	CorpCARAdmin='#form.CorpCarAdmin#'

	WHERE ID = #addID.maxID#
</cfquery>

<cfoutput>
	<cflocation url="CARAdminView.cfm?ID=#addID.maxID#" addtoken="No">
</cfoutput>

<cfelse>
<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#" method = "post">

<cfoutput>
Name:<Br>
<cfinput size="75" name="Name" required="yes" Message="Please Enter Full Name" type="text" Maxlength="128" value="#View.Name#"><br><br>

Email: (external UL Email address)<br>
<cfinput size="75" name="Email" required="yes" Message="Please enter external UL Email Address" type="text" Maxlength="255" value="#View.Email#"><br><br>

Location:<Br>
<SELECT NAME="Location">
		<OPTION VALUE="None">Select Location Below
		<OPTION Value="#View.Location#" selected>#View.Location#
</cfoutput>
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT><br><br>

<b><u>Training Completed</u></b><br><Br>
<b>ISO/IEC Guide 65</b>:<br>
Yes <cfinput type="Radio" name="x65" value="Yes" checked="false"> No <cfinput type="Radio" name="x65" value="No" checked="true"><Br><Br>

<b>ISO/IEC 17020</b>:<br>
Yes <cfinput type="Radio" name="x17020" value="Yes" checked="false"> No <cfinput type="Radio" name="x17020" value="No" checked="true"><br><Br>

<b>ISO/IEC 17025</b>:<br>
Yes <cfinput type="Radio" name="x17025" value="Yes" checked="false"> No <cfinput type="Radio" name="x17025" value="No" checked="true"><Br><br>

<b>ISO/IEC 17065</b>:<br>
Yes <cfinput type="Radio" name="x17065" value="Yes" checked="false"> No <cfinput type="Radio" name="x17065" value="No" checked="true"><Br><br>

<b><u>Corporate CAR Admin</u></b><Br>
Yes <cfinput type="Radio" name="CorpCarAdmin" value="Yes" checked="false"> No <cfinput type="Radio" name="CorpCarAdmin" value="No" checked="true"><Br><br>

<b><u>CAR Adminstrator Trainer</u></b><Br>
Yes <cfinput type="Radio" name="Trainer" value="Yes" checked="false"> No <cfinput type="Radio" name="Trainer" value="No" checked="true"><Br><br>

<b><u>Designated Corporate Quality Reviewer</u></b><Br>
Yes <cfinput type="Radio" name="DCQR" value="Yes" checked="false"> No <cfinput type="Radio" name="DCQR" value="No" checked="true"><Br><br>

<b><u>Designated Areas for Designated Corporate Quality Reviewers</u></b><br>
<SELECT NAME="DCQRArea" multiple>
<CFOUTPUT QUERY="CARSource">
		<OPTION VALUE="#CARSource#">#CARSource#
</CFOUTPUT>
</SELECT><br>
* Hold Control to select multiple items<br><br>

<b><u>CAR Admin Backup</u></b><Br>
<SELECT NAME="Backup">
		<OPTION VALUE="0">None
<CFOUTPUT QUERY="Backup" group="Name">
		<OPTION VALUE="#ID#">#Name#
</CFOUTPUT>
</SELECT><br><br>

<cfset blank="">

<cfoutput>
<b><u>Training Comments</u></b><Br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="Training">
<cfif isDefined("URL.ID")>
Guide 65 - #View.x65notes#<br><br>ISO/IEC 17020 - #View.x17020notes#<br><br>ISO/IEC 17025 - #View.x17025notes#
<cfelse>
#blank#
</cfif>
</textarea>
<br><br>

<b><u>Expertise</u></b><Br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="Expertise">#blank#</textarea>
<br><br>
</cfoutput>

<b><u>Status</u></b><Br>
<SELECT NAME="Status" displayname="Status">
<CFOUTPUT QUERY="Status">
	<cfif isDefined("URL.ID")>
		<OPTION VALUE="#Status#" <cfif Status is "In Training">selected</cfif>>#Status#
	<cfelse>
		<OPTION VALUE="#Status#">#Status#
	</cfif>
</CFOUTPUT>
		<OPTION VALUE="CAR Administration Support">CAR Administration Support
</SELECT>
<br><br>

<b><u>Confirm Last Name</u></b><Br>
<cfinput size="75" name="LastName" required="yes" Message="Please Enter Last Name" type="text" Maxlength="128"><br><br>

<b><u>CAR Admin Date</u> (date added as a CAR Admin)</b><br>
<cfinput size="50" name="DateAdded" validate="date" value="#curdate#"><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->