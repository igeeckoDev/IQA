<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?Year=#URL.year#'>Audit Planning</a> - Add/Edit Scheme Owner">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudit" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Area
FROM AuditSchedule_Planning
WHERE xGUID = #URL.AuditID#
</cfquery>

<cfif structKeyExists(form,'submit')>
	<cfdump var="#Form#">

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="update">
	Update ProgDev
	SET
	SchemeOwner = <cfif len(form.SchemeOwner)>'#Form.SchemeOwner#'<Cfelse>null</cfif>

	WHERE ID = #Form.ID#
	</cfquery>

	<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
	<cfset qs = cgi.query_string>
	<cfset newURL = queryStringDeleteVar("auditID", qs)>

	<cflocation url="AuditPlanning.cfm?#newURL#" addtoken="no">
<cfelse>
	<CFQUERY BLOCKFACTOR="100" NAME="SchemeOwner" Datasource="Corporate">
	SELECT SchemeOwner, ID
	From ProgDev
	WHERE Program = '#viewAudit.Area#'
	</cfquery>

	<cfoutput query="SchemeOwner">
		<u>Program</u>: <b>#ViewAudit.Area#</b><br>
		<u>Scheme Owner</u>: <cfif len(SchemeOwner)><b>#SchemeOwner#</b><cfelse>None listed</cfif><br><br>

		<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="updateSchemeOwner" action="#CGI.Script_Name#?#CGI.Query_String#">
			Scheme Owner:<br>
			<input type="text" value="#SchemeOwner#" Name="SchemeOwner" size="80">
			<br><br>

			<input Type="hidden" value="#ID#" name="ID">

			<input name="Submit" type="Submit" value="Submit">
		</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->