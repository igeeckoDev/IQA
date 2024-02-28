<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<a href="qManagementChain.cfm">GCAR Report - Exclude from Management Escalation Chain</a> :: <a href="qManagementChain_Modify.cfm">Modify List</a> :: Add Name<br><br>

<cfif structkeyexists(form, "Submit")>
	<cfquery name="AddRow" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(ID)+1 as maxID
	FROM GCAR_METRICS_ManagementChain
	</cfquery>

	<cfquery name="InsertRow" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO GCAR_METRICS_ManagementChain(ID, Name)
	VALUES(#addRow.maxID#, '#Form.Name#')
	</cfquery>

	<cflocation url="qManagementChain_Modify.cfm" addtoken="No">
<cfelse>
	<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="qManagementChain_Add.cfm">

	Add Name (ensure the name is listed EXACTLY the same as it is in GCAR):<br>
	<input name="Name" type="Text" size="70" value="">
	<br><br>

	<input name="Submit" type="submit" value="Submit">
	</form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->