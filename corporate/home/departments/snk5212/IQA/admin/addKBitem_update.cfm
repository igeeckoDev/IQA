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
DESTINATION="#IQARootPath#KB\attachments\"
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#KBID.newid#.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#KB\attachments\#NewFileName#">

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

<cfif Form.Email neq "None">
	<cfif Form.Email eq "Technical">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBEmailList">
		SELECT Email FROM IQADB_Login
		WHERE status IS NULL
		AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
		AND
			(EMAIL IS NOT NULL
			AND EMAIL <> 'Internal.Quality_Audits@ul.com'
			AND Email <> 'Joe.Taylor@ul.com'
			AND Email <> 'Michael.Schneider@ul.com')
		ORDER BY Email
		</CFQUERY>

		<cfset Emails = #valueList(KBEmailList.Email, ',')#>
		<cfset Emails2 = "Lenore.J.Berman@ul.com, Antonio.L.Romanacce@ul.com">
	<cfelseif Form.Email eq "RQM">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBEmailList">
		SELECT Email FROM IQADB_Login
		WHERE status IS NULL
		AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
		AND
			(EMAIL IS NOT NULL
			AND EMAIL <> 'Internal.Quality_Audits@ul.com'
			AND Email <> 'Joe.Taylor@ul.com'
			AND Email <> 'Michael.Schneider@ul.com')
		ORDER BY Email
		</CFQUERY>

		<cfset Emails = #valueList(KBEmailList.Email, ',')#>
	<cfelseif Form.Email eq "IQA">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBEmailList">
		SELECT Email FROM IQADB_Login
		WHERE status IS NULL
		AND (AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
		AND
			(EMAIL IS NOT NULL
			AND EMAIL <> 'Internal.Quality_Audits@ul.com'
			AND Email <> 'Joe.Taylor@ul.com'
			AND Email <> 'Michael.Schneider@ul.com')
		ORDER BY Email
		</CFQUERY>

		<cfset Emails = #valueList(KBEmailList.Email, ',')#>
	</cfif>

	<cfmail query="Show" to="#Emails#, #Emails2#" from="Internal.Quality_Audits@ul.com" Mailerid="KBArticle" subject="New IQA/CAR Knowledge Base Article">
	A new IQA/CAR Knowledge Base Article has been posted by #Added#.

	Details:
	"#Subject#" by #Author# listed under #KBTopics#.

	Knowledge Base articles can be viewed on both the IQA and CAR Process Websites.

	http://usnbkiqas100p/departments/snk5212/IQA/KB.cfm?ID=#KBID.newID#
	</cfmail>
</cfif>

<cfoutput>
	<cflocation url="KB.cfm?id=#KBID.newID#" addtoken="no">
</cfoutput>
