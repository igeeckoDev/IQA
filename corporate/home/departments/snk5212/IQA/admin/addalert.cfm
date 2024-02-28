<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="newID"> 
SELECT MAX(ID) + 1 AS newid 
FROM IQADB_ALERTS  "ALERTS" 
</CFQUERY>

<cfif Form.upload is NOT "">
<CFFILE ACTION="UPLOAD" 
FILEFIELD="upload" 
DESTINATION="#IQARootDir#alertdocs\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.upload#">

<cfoutput>
<cfset NewFileName="#newID.newID#.#cffile.ClientFileExt#">
</cfoutput> 
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootDir#alertdocs\#Form.upload#">
	
<cffile
    action="delete"
    file="#IQARootDir#alertdocs\#Form.upload#">
<cfelse>
</cfif>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID"> 
INSERT INTO IQADB_ALERTS "ALERTS" (ID, Subject, Details, Start_, End, Notes, File_)
VALUES (#newID.newid#, '#Form.Subject#', '#Form.Details#', <cfif Form.Start is "">null<cfelse>#CreateODBCDate(Form.Start)#</cfif>, <cfif Form.End is "">null<cfelse>#CreateODBCDate(Form.End)#</cfif>, <cfif Form.Notes is "">null<cfelse>'#Form.Notes#'</cfif>, <cfif Form.upload is "">null<cfelse>'#NewFileName#'</cfif>)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Alerts" Datasource="Corporate"> 
SELECT * FROM IQADB_ALERTS "ALERTS" 
WHERE ID = #newID.newid#
</CFQUERY>

<cfmail
	 to="Global.InternalQuality@ul.com"
	 from="Internal.Quality_Audits@ul.com"
	 Mailerid="AuditorAlert"
	 subject="New Auditor Alert on IQA Website">
A new Auditor Alert entitled '#Subject#' has been added to the IQA web site main page.

Please visit http://#CGI.SERVER_NAME#/departments/snk5212/iqa/ to view this alert.
</cfmail>

<cflocation url="alerts.cfm?ID=#newID.newID#" addtoken="no">