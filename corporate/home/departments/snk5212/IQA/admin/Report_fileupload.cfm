<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#IQARootPath#Reports\Temp" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#-ReportAttach.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#Reports\Temp\#NewFileName#">
    
<cffile
    action="move"
    source="#IQARootPath#Reports\Temp\#NewFileName#"
    destination="#IQARootPath#Reports\">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE Report
SET 

Attach='#NewFileName#'

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">
