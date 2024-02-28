<CFQUERY BLOCKFACTOR="100" NAME="Update" Datasource="Corporate">
UPDATE IQAtblOffices
SET
RQM=<cfif NOT len(form.RQM)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.RQM)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
QM=<cfif NOT len(form.QM)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.QM)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
GM=<cfif NOT len(form.GM)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.GM)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
LES=<cfif NOT len(form.LES)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.LES)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
Other=<cfif NOT len(form.Other)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.Other)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
Other2=<cfif NOT len(form.Other2)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.Other2)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
<!---QRS=<cfif NOT len(form.QRS)>null<cfelse>TRIM('#FORM.QRS#')</cfif>,--->
Regional1=<cfif NOT len(form.Regional1)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.Regional1)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
Regional2=<cfif NOT len(form.Regional2)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.Regional2)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>,
Regional3=<cfif NOT len(form.Regional3)>null<cfelse><CFQUERYPARAM VALUE="#TRIM(Form.Regional3)#" CFSQLTYPE="CF_SQL_CLOB"></cfif>

WHERE ID=#URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT * FROM IQAtbloffices
	WHERE ID = #URL.ID#
	ORDER BY OfficeName
</cfquery>

<cflocation url="contacts.cfm?#cgi.QUERY_STRING#" addtoken="No">