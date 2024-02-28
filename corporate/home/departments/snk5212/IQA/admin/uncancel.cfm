<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Reinstate Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="delete" Datasource="Corporate">
	UPDATE AuditSchedule
	SET Status = null
	WHERE ID = #URL.ID#
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
	SELECT Auditschedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
	WHERE ID = #URL.ID#
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput query="AuditSched">					  
Audit #Year#-#ID#-#AuditedBy# has been resinstated - the status has been changed from 'Cancelled' to 'Active'.<br><br>

Return to <a href="auditdetails.cfm?#cgi.QUERY_STRING#">Audit Details</a>.
</cfoutput>	  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->