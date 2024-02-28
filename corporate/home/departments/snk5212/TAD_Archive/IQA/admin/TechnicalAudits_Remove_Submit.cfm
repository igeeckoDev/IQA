<cfif Form.Remove is "Cancel Request">
	<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
<cfelseif form.Remove is "Confirm Request">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audit - Remove Audit Confirmation">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Old" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * 
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="delete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE TechnicalAudits_AuditSchedule
	SET 
    
	Status='removed',
	<cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>
	<cfset HistoryUpdate = "Audit removed from the Audit Schedule<br>Notes: #N#<Br>Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br>Date: #curdate# #curTime#">
	Notes='#Old.Notes#<br><br>This audit has been removed from the Audit Schedule: #N#',
    History = <CFQUERYPARAM VALUE="#Old.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">	
    
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * 
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput query="Audit">					  
<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

Audit #varAuditIdentifier# / #year_#-#id#-Technical Audit has been removed from the Audit Schedule.<br><br>

#notes#
</cfoutput>	  
		  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
</cfif>