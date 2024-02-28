<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT ID,YEAR_ as "Year"
 FROM TPReport5
 WHERE ID = #URL.ID#  AND  Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif a.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO TPReport5(ID, Year)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">)
</cfquery>
</cfif>

<cfquery name="Input" Datasource="Corporate">
UPDATE TPReport5
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x lt 10>
00#x# = #form[x]#,
<cfelse>
0#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Comments='N/A'

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID=#URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='Entered'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cflocation url="TPReport_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">