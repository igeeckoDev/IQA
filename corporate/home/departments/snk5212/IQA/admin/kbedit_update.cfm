<cfif Form.File is "">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB">
UPDATE KB
SET
Subject='#Form.Subject#',
Posted=<cfif Form.Posted is "">null<cfelse>'#Form.Posted#'</cfif>,
CAR='#Form.CAR#',
Details=<CFQUERYPARAM VALUE='#Form.Details#'>

WHERE ID=#URL.ID#
</CFQUERY>

<cfelse>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Show">
    SELECT * FROM KB
    WHERE ID = #URL.ID#
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

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB">
    UPDATE KB
    SET
    Subject='#Form.Subject#',
    FILE_='#NewFileName#',
    Posted=<cfif Form.Posted is "">null<cfelse>'#Form.Posted#'</cfif>,
    CAR='#Form.CAR#',
    Details=<CFQUERYPARAM VALUE='#Form.Details#'>

    WHERE ID = #URL.ID#
    </CFQUERY>
</cfif>

<!--- Send Email notification of changes --->
<cfif Form.Notify eq "Yes">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Show">
    SELECT * FROM KB
    WHERE ID = #URL.ID#
    </CFQUERY>

	<cfinclude template="incKBEmailDistribution.cfm">

	<cfmail query="Show" to="#Emails#, #Emails2#" from="Internal.Quality_Audits@ul.com" replyto="Christopher.J.Nicastro@ul.com" bcc="Christopher.J.Nicastro@ul.com" Mailerid="KBArticle" subject="Update - IQA Knowledge Base Article">
    An update has been made to an Article in the IQA Knowledge Base:

    Details:
    "#Subject#" listed under #KBTopics#.

    Please visit http://corporate/departments/snk5212/QualityEngineering/KB.cfm?id=#id# to view this new article.
    </cfmail>
</cfif>

<cfoutput>
	<cflocation url="KB.cfm?id=#URL.ID#" ADDTOKEN="No">
</cfoutput>