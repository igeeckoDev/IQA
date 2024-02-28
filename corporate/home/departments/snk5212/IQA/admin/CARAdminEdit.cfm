<!--- DV_CORP_002 02-APR-09 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "CAR Website - CAR Administrator - Edit">
<cfinclude template="SOP.cfm">

<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 42e3a508-e3c6-43aa-9487-9c092a853706 Variable Datasource name --->
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
ORDER BY OfficeName
<!---TODO_DV_CORP_002_End: 42e3a508-e3c6-43aa-9487-9c092a853706 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Backup" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 28b6d46a-646f-477f-8000-9d40ea4ae3e6 Variable Datasource name --->
SELECT * FROM CARAdminList
WHERE Status = 'Active'
ORDER BY Name
<!---TODO_DV_CORP_002_End: 28b6d46a-646f-477f-8000-9d40ea4ae3e6 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
						  
<CFQUERY BLOCKFACTOR="100" NAME="Status" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d763f45a-9417-49b2-be7c-e3429e482b07 Variable Datasource name --->
SELECT Status FROM AuditorStatus
ORDER BY Status
<!---TODO_DV_CORP_002_End: d763f45a-9417-49b2-be7c-e3429e482b07 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 4fea5136-2ff9-4701-9690-99c3f9b97ae4 Variable Datasource name --->
SELECT * FROM CARSource
ORDER BY CARSource
<!---TODO_DV_CORP_002_End: 4fea5136-2ff9-4701-9690-99c3f9b97ae4 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CARAdminDetails" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: ece88411-3d40-49e4-82d0-427c8a130c60 Variable Datasource name --->
SELECT * FROM CARAdminList
WHERE ID = #URL.ID#
<!---TODO_DV_CORP_002_End: ece88411-3d40-49e4-82d0-427c8a130c60 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
				
<cfif isDefined("Form.Name")>

	<cfquery name="editCARAdmin" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 63e093f6-0cf9-4517-97e5-d5c559dd96f2 Variable Datasource name --->
UPDATE CARAdminList 
	SET
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
	Trainer='#Form.Trainer#',
	Backup=#Form.Backup#,
	DCQR='#Form.DCQR#',
	DCQRArea='#Form.DCQRArea#'
	
	WHERE
	ID = #URL.ID#
<!---TODO_DV_CORP_002_End: 63e093f6-0cf9-4517-97e5-d5c559dd96f2 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	
<cfoutput>
	<cflocation url="CARAdminView.cfm?ID=#addID.maxID#">
</cfoutput>

<cfelse>
<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#" method = "post">
<cfoutput query="CARAdminDetails">

Name:<Br>
<cfinput value="#Name#" size="75" name="Name" required="yes" Message="Please Enter Full Name" type="text" Maxlength="128"><br><br>

Email: (external UL Email address)<br>
<cfinput value="#Email#" size="75" name="Email" required="yes" Message="Please enter external UL Email Address" type="text" Maxlength="255"><br><br>

Location:<Br>
<SELECT NAME="Location">
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#" <cfif Officename eq CARAdminDetails.OfficeName>selected</cfif>>#OfficeName#
</CFOUTPUT>
</SELECT><br><br>

<b><u>Training Completed</u></b><br>
<b>Guide 65</b>:<br> 
<cfset selValue=#CARAdminDetails.x65#>
	
<cfinput type="radio" name="x65" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x65" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No

<b>ISO/IEC 17020</b>:<br>
<cfset selValue=#CARAdminDetails.x17020#>
	
<cfinput type="radio" name="x17020" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x17020" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No

<b>ISO/IEC 17025</b>:<br>
<cfset selValue=#CARAdminDetails.x17025#>
	
<cfinput type="radio" name="x17025" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="x17025" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No

<b><u>CAR Adminstrator Trainer</u></b><Br>
<cfset selValue=#CARAdminDetails.Trainer#>
	
<cfinput type="radio" name="Trainer" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="Trainer" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No

<b><u>Designated Corporate Quality Reviewer</u></b><Br>
<cfset selValue=#CARAdminDetails.DCQR#>
	
<cfinput type="radio" name="DCQR" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#"> Yes
<cfinput type="radio" name="DCQR" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"> No

<b><u>Designated Areas for Designated Corporate Quality Reviewer</u></b><br>
* Hold Control to select multiple items<br>
Currently: #DCQRArea#<br>
</cfoutput>
<SELECT NAME="DCQRArea" multiple>
<CFOUTPUT QUERY="CARSource">
		<OPTION VALUE="#CARSource#">#CARSource#
</CFOUTPUT>
</SELECT><br><br>

<b><u>CAR Admin Backup</u></b><Br>
<SELECT NAME="Backup">
<CFOUTPUT QUERY="Backup">
		<OPTION VALUE="#ID#" <cfif ID eq CarAdminDetails.Backup>selected</cfif>>#Name#
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="CarAdminDetails">
<b><u>Training Comments</u></b><Br>
<textarea value="#Training#" name="Training" value="" WRAP="PHYSICAL" ROWS="8" COLS="75" id="Training"></textarea>

<br><br>

<b><u>Expertise</u></b><Br>
<textarea value="#Expertise#" name="Expertise" value="" WRAP="PHYSICAL" ROWS="8" COLS="75" id="Expertise"></textarea>

<br><br></cfoutput>

<b><u>Status</u></b><Br>
<SELECT NAME="Status" displayname="Status">
<CFOUTPUT QUERY="Status">
		<OPTION VALUE="#Status#" <cfif Status eq CARAdminDetails.Status>selected</cfif>>#Status#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput>
<b><u>Confirm Last Name</u></b>:<Br>
<cfinput value="#LastName#" size="75" name="LastName" required="yes" Message="Please Enter Last Name" type="text" Maxlength="128"><br><br>

<input type="submit" value="Submit">
</cfoutput>
</cfform>
</cfif>
				  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->