<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning2013_Users
WHERE ID > 52
ORDER BY ID
</CFQUERY>

<cfset i = 1>
<cfoutput query="Distribution">
#i#<br />
URL.UserID = #ID#<br />
Type = #Type#<br />
SurveyType = #SurveyType#<bR />
To: #SentTo#<br /><br />

<!---
<cfmail 
	to="#SentTo#" 
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="2013 IQA Audit Planning - #Type#"
    type="html">
#Type# Staff:<br><br>

Preparation for 2013 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for the 2013 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information pertaining to #Type#:<br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 12, 2012</b>.<br><br>

Please contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
--->

<cfset i = i+1>
</cfoutput>