<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBID">
SELECT MAX(ID) + 1 AS newid FROM KB
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBIDAdd">
INSERT INTO KB(ID)
VALUES (#KBID.newid#)
</CFQUERY>

<cfif Form.File is "">

<cfelse>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#IQAPath#KB\attachments\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#KBID.newid#.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#IQAPath#KB\attachments\#NewFileName#">

</cfif>	
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB">
UPDATE KB
SET

<cfif Form.CAR is "Yes">
CAR='Yes',
<cfelseif Form.CAR is "No">
CAR='No',
</cfif>
Subject='#Form.e_Subject#',
Posted=#CreateODBCDate(Form.e_Posted)#,
Author='#Form.e_Author#',
Added='#form.added#',
<cfset D1 = #ReplaceNoCase(Form.e_Details,chr(13),"<br>", "ALL")#>
Details='#D1#',
<cfif Form.File is ""><cfelse>
File_='#NewFileName#',</cfif>
KBTopics='#Form.e_KBTopics#'

WHERE ID = #KBID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE ID = #KBID.newid#
</CFQUERY>

<cfinclude template="incKBEmailDistribution.cfm">

<cfmail query="Show" to="#Emails#, #Emails2#" from="Internal.Quality_Audits@ul.com" Mailerid="KBArticle" subject="New IQA/CAR Knowledge Base Article">
A new IQA/CAR Knowledge Base Article has been posted by #Added#.

Details:
"#Subject#" by #Author# listed under #KBTopics#.

Knowledge Base articles can be viewed on both the IQA and CAR Process Websites.

#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/KB.cfm?ID=#KBID.newID#
</cfmail>

<cfoutput>
	<cflocation url="KB.cfm?id=#KBID.newID#" addtoken="no">
</cfoutput>
