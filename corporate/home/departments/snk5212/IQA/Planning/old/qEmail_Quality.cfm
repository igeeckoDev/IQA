<!---
<cfquery Datasource="Corporate" name="qEmailQualityList"> 
SELECT DISTINCT Email 
From IQADB_LOGIN 
WHERE AccessLevel = 'RQM'
AND Status IS NULL
</cfquery>

<cfset i = 1>
Recipients:<br />
<cfoutput query="qEmailQualityList">
<cfif len(Email)>
#i# #Email#<br>

<cfmail 
	to="#Email#" 
	from="global.internalquality@ul.com"
    subject="2011 IQA Audit Planning"
    bcc="Christopher.J.Nicastro@ul.com" 
    type="html">
Quality Staff:<br><br>

Preparation for 2011 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for the 2011 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for UL Sites, Programs, and Processes:<br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/AuditPlanning_Quality_getEmpNo.cfm?Quality=Yes">http://usnbkiqas100p/departments/snk5212/IQA/Planning/AuditPlanning_Quality_getEmpNo.cfm?Quality=Yes</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 30, 2010</b>.<br><br>

<u>Note</u> - You can reuse this link to add additional information about other Sites/Processes/Programs.<br><br>

Contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Mobile: 1.847.323.4631<br>
Fax: 1.847.407.1020<br>
Email: global.internalquality@ul.com
</cfmail>

<cfset i = i+1>
</cfif>
</cfoutput>
--->