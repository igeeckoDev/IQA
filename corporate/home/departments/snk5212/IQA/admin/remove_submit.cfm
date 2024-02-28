<cfif Form.Remove is "Cancel Request">
	<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
<cfelseif form.Remove is "Confirm Request">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Remove Audit Confirmation">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Old" Datasource="Corporate"> 
SELECT ID, YEAR_ as "Year", Notes
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="delete" Datasource="Corporate">
	UPDATE AuditSchedule
	SET 
    
	Status='removed',
	<cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>
	Notes='#Old.Notes#<br><br>#N#'	
    
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
		
<cfoutput query="AuditSched">					  
Audit #year_#-#id#-#auditedby# has been removed from the Audit Schedule.<br><br>

#notes#
</cfoutput>	  
		  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
</cfif>