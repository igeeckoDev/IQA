<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>

<CFQUERY BLOCKFACTOR="100" name="menu" DataSource="Corporate">
SELECT * FROM CAR_menu_root
WHERE STATUS IS NULL
ORDER BY alphaID
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="kbmenu" DataSource="Corporate">
SELECT * FROM KBMenu
ORDER BY alphaID
</cfquery>

<table width="600">
<tr>
<td width="300" class="blog-content" valign="top" align="left">
<cfoutput>
	<!--- if logged in show all but 'login' item --->
		:: <a href="#CARAdminDir#index.cfm">Main - CAR Process Website</a><br>
		<!--- :: <a href="#CARRootDir#ASReports.cfm?Year=#curyear#">AS Reports (ANSI / OSHA / SCC)</a><br>--->
		:: <a href="notes:///86256F150051C1B0">Global CAR Database</a> (Link to Lotus Notes)<br>
		:: <a href="#CARRootDir#CARTrainingFiles.cfm">CAR Training Documents</a><br>
		:: <a href="Links.cfm">Links</a><br>
		:: <a href="KBIndex.cfm">IQA / CAR Website Knowledge Base</a><br>
		:: <a href="Training.cfm">Training Aids</a><br>
		:: CAR Administrators<br>
		&nbsp;&nbsp;&nbsp; -  <a href="CARAdminList.cfm">View CAR Admin List</a><br>
		&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#CARAdminAdd.cfm">Add CAR Admin</a><br>
		&nbsp;&nbsp;&nbsp; -  Performance (<u>See QE Files</u>)<br>
		&nbsp;&nbsp;&nbsp; -  Responsibility Matrix <a href="#CARRootDir#CARmatrix/CARAdministratorResponsibilityList.xls">[view]</a> <a href="#CARAdminDir#CARResponsibility.cfm">[upload]</a><br>
			&nbsp;&nbsp;&nbsp; -  Requests <a href="#CARRootDir#getEmpNo.cfm?page=request">[request form]</a> <a href="Request.cfm">[view requests]</a><br>

			<cfif SESSION.Auth.AccessLevel eq "SU">
			:: Email Check<br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#EmailCheck.cfm">Email Verify</a><br>
			:: <a href="#CARAdminDir#TrainerLogin.cfm">CAR Trainer Logins - Verify</a><br>
			</cfif>
	</td>
	<td width="300" class="blog-content" valign="top" align="left">
			:: FAQ - Frequently Asked Questions<br>
			&nbsp;&nbsp;&nbsp; -  <a href="FAQ.cfm">Full CAR Process FAQ</a><br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARRootDir#FAQ_RH.cfm">FAQ Revision History</a><br>
			&nbsp;&nbsp;&nbsp; -  <a href="CAROwners.cfm">FAQ - CAR Owners</a> <br>
			&nbsp;&nbsp;&nbsp; -  <a href="CARAdmins.cfm">FAQ - CAR Administrators</a><br>
			:: Manage Lists<br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#CARSource_View.cfm">CAR Sources / FAQ 12</a><br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#RootCause_Add.cfm">Root Cause Categories / FAQ 26</a><br>
			:: Quality Alerts<br>
			&nbsp;&nbsp;&nbsp; -  <a href="Alerts.cfm">View Alerts</a><br>
			&nbsp;&nbsp;&nbsp; -  <a href="viewMetrics.cfm">Quality Alert Metrics</a><br>
			:: CAR Process Calibration Meetings<br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#CM/Calibration_Index.cfm">Calibration Meetings</a><br>
			:: QE Related Files<br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#CARFiles.cfm">View/Add Files</a><Br>
			&nbsp;&nbsp;&nbsp; -  <a href="#CARAdminDir#CARFilesCategories.cfm">View/Add Categories</a><Br>
</td></cfoutput>
	
</tr>
<tr>
	<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<!--- Logged in status and public/admin view toggle --->
		<cfoutput>
		Logged in as: #SESSION.Auth.Username#/#SESSION.Auth.AccessLevel#<br>
		Go to <a href="#CARRootDir#">Public View</a> (You will remain logged in)<br><br>
		
		:: <a href="logout.cfm">Logout</a><br>
		:: <a href="#CARAdminDir#archive/directory_listing.cfm">Archive Directory</a><br>
		</cfoutput>
        
		<cfif cgi.path_translated eq "#path#KBIndex.cfm" or cgi.path_translated eq "#path#KB.cfm" or cgi.path_translated eq "#path#KB_AddCategory.cfm" or cgi.path_translated eq "#path#KB_AddItem.cfm">
			<br>
			<cfoutput query="kbmenu">
				:: <a href="#link#">#text#</a><br>
			</cfoutput>
		</cfif>
<!--- // --->

	</td>
</tr>
</table>

<cfelse>
	<!--- not logged in, go to login screen --->
	<cflocation url="global_login.cfm" addtoken="No">
</cfif>
</cflock>