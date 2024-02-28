<cfif Form.File is "">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddKB">
UPDATE KB
SET 
Subject='#Form.e_Subject#',
Posted=<cfif Form.e_Posted is "">null<cfelse>#CreateODBCDate(Form.e_Posted)#</cfif>,
CAR='#Form.CAR#',
Details='#Form.Details#'

WHERE ID=#URL.ID#
</CFQUERY>

<cfelse>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE  ID=#URL.ID#
</CFQUERY>

<!--- upload new KB attachment --->
<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#IQARootPath#KB\attachments\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#ID#.#cffile.ClientFileExt#">

 <cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#KB\attachments\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddKB">
UPDATE KB
SET 
Subject='#Form.e_Subject#',
File='#NewFileName#',
Posted=<cfif Form.Posted is "">null<cfelse>#CreateODBCDate(Form.Posted)#</cfif>,
CAR='#Form.CAR#',
Details='#Form.Details#'

WHERE ID=#URL.ID#
</CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE  ID=#URL.ID#
</CFQUERY>

<cfinclude template="KBEmailList.cfm">

<cfmail query="Show" to="#Emails#, #Emails2#, #Emails3#" from="Internal.Quality_Audits@ul.com" cc="Christopher.J.Nicastro@ul.com" subject="Update - IQA/QE Knowledge Base Article">
An update has been made to a IQA/QE Knowledge Base Article:

"#Subject#" by #Author# listed under #KBTopics#.
  
Please visit http://#CGI.SERVER_NAME#/departments/snk5212/QE/KB.cfm?id=#id# to view this new article.
</cfmail>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE  ID=#URL.ID#
</CFQUERY>

<cfoutput>
<cflocation url="#CARRootDir#KB.cfm?id=#URL.ID#" addtoken="No">
</cfoutput>
