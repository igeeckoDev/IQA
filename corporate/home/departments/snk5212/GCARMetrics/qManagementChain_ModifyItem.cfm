<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<a href="qManagementChain.cfm">GCAR Report - Exclude from Management Escalation Chain</a> :: <a href="qManagementChain_Modify.cfm">Modify List</a> :: Edit Name<br><br>

<cfif structkeyexists(form, "Submit")>
	<cfquery name="InsertRow" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE GCAR_METRICS_ManagementChain
	SET
	Name = '#Form.Name#'
	WHERE ID = #URL.ID#
	</cfquery>

	<cflocation url="qManagementChain_Modify.cfm" addtoken="No">
<cfelse>

	<cfquery name="qGetName" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ID, Name
	FROM GCAR_METRICS_ManagementChain
	WHERE ID = #URL.ID#
	</cfquery>

	<cfoutput query="qGetName">
		<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="qManagementChain_ModifyItem.cfm?ID=#ID#">

		Add Name (ensure the name is listed EXACTLY the same as it is in GCAR):<br>
		<input name="Name" type="Text" size="70" value="#Name#">
		<br><br>

		<input name="Submit" type="submit" value="Submit">

		</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->