<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?Year=#URL.year#'>#URL.Year# Audit Planning</a> - Remove Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif structKeyExists(form,'submit')>
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="updateAudit" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning
	SET
	status = 'Removed',
	Notes = <cfqueryparam value="#Form.Notes#" CFSQLTYPE="cf_sql_clob">
	WHERE xGUID = #URL.AuditID#
	</cfquery>

	<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
	<cfset qs = cgi.query_string>
	<cfset newURL = queryStringDeleteVar("auditID", qs)>

	<cflocation url="AuditPlanning.cfm?#newURL#" addtoken="no">
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudit" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT *
		FROM AuditSchedule_Planning
		WHERE xGUID = #URL.AuditID#
	</cfquery>

	<cfoutput query="viewAudit">
	<B>#Year_#-#ID#-IQA</B><Br>
	<u>Audit Type</u> - #AuditType2#<br>
	<u>Location</u> - #OfficeName#<br>
	<u>Area</u> - #Area#<br><br>

	<fORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="#CGI.Script_Name#?#CGI.Query_String#">
	Are you are you want to remove this audit?<br><br>

	Yes <input
			type="checkbox"
			name="YesNoItem"
			value="Yes" /><Br><br>

	Notes:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Notes" displayname="Notes" value=""></textarea>

	<input type="Submit" name="Submit" value="Remove this Audit from the Planning Module">
	</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->