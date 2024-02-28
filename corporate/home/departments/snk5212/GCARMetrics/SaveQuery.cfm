<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Saving Report">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfif IsDefined("Form.e_Title") AND isDefined("Form.e_EmpID")>

<!--- GCAR_Metrics_SavedQueries.ID Assignment --->
<!--- check to see if any meetings entered yet --->
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="check" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ID FROM GCAR_Metrics_SavedQueries
	</CFQUERY>
	
<!--- if not set variable to 1, for first record --->	
	<cfif check.recordcount eq 0>
		<cfset maxId.maxID = 1>
	<cfelse>
<!--- if there are items, find max ItemID and add 1 --->
		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="maxID" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT MAX(ID)+1 as maxID FROM GCAR_Metrics_SavedQueries
		</CFQUERY>
	</cfif>
<!--- // --->

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="maxMeetingID" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO GCAR_Metrics_SavedQueries(ID, EmpID, Title, PageName, QueryString, DateSaved)
	VALUES(#maxID.maxID#, '#Form.e_EmpID#', '#Form.e_Title#', '#Form.PageName#', '#Form.QueryString#', #now()#)
	</cfquery>
	
	<cflocation url="ViewQueries.cfm?EmpNo=#Form.e_EmpID#" addtoken="no">

<cfelse>
Please enter the following information:<Br><br>

<u>Name</u> - A recognizable name for this Report/View. This Name will be viewable when you return to search for saved reports.<br><br>
<u>Employee ID</u> - Please verify that your Employee ID is correct. You will be able to view your saved reports using your Employee ID.<br><br>
	
	<cfoutput>
	<FORM ACTION="#CGI.ScriptName#" METHOD="POST" name="Audit">
		Name of Saved Report/View:<br>
		<input type="text" name="e_Title" value="" size="75" displayname="Save View/Report Name"><Br><Br>
		
		Employee ID<br>
		<input maxlength="5" type="text" name="e_EmpID" value="#Form.EmpNo#" displayname="Employee ID"><br><br>
			
		<u>Page</u>: #Form.PageName#<br>
		<input type="hidden" name="PageName" value="#Form.PageName#"><Br />
		
		<u>Query String</u>: #Form.QueryString#<br>
		<input type="hidden" name="QueryString" value="#Form.QueryString#"><br />
		
		<u>Date Saved</u>: #dateformat(now(), "mm/dd/yyyy")#<br><br>
		<input type="hidden" name="DateSaved" value="#now()#">
		
		<INPUT TYPE="button" value="Save Query" onClick=" javascript:checkFormValues(document.all('Audit'));">
	</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->