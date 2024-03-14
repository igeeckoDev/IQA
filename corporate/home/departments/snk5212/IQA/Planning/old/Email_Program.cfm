<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditPlanning2017_Users.ID as ID, AuditPlanning2017_Users.SentTo as SentTo, AuditPlanning2017_Users.Responded,
AuditPlanning2017_Users.SurveyType, AuditPlanning2017_Users.PostedBy, AuditPlanning2017_Users.Posted, Corporate.ProgDev.Program as Name
FROM AuditPlanning2017_Users, Corporate.ProgDev
WHERE AuditPlanning2017_Users.Type = 'Program'
AND AuditPlanning2017_Users.pID = Corporate.ProgDev.ID
ORDER BY Corporate.ProgDev.Program, AuditPlanning2017_Users.Responded, AuditPlanning2017_Users.Posted DESC
</CFQUERY>

<cfset i = 1>
<cfoutput query="Distribution">
#i#<br />
URL.UserID = #ID#<br />
Program Name = #Name#<br />
To: #SentTo#<br /><br />

<cfset Edit1 = replace(Name, "&lt;", "<", "All")>
<cfset ProgramName = replace(Edit1, "&gt;", ">", "All")>

<!---
<cfmail
	to="#SentTo#"
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="#ProgramName# - 2017 Audit Planning - Internal Quality Audits"
    type="html">
Program/Scheme Owners, Managers, and Specialists:<br><br>

Preparation for 2017 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for <b>#Name#</b> for the 2017 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for <b>#Name#</b>:<br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If you have additional audit requests specific to Certification Bodies, Certification Schemes, accredited testing laboratories, or calibration laboratories, please include this information in the survey responses.<br><br>

If someone will be providing this information on your behalf, please forward this email to them including the link above.<br><br>

To view the distribution lists, please use the following link:<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Program">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Program</a><br /><br />

You can add information for any of the categories listed in the link above by using the "Open Blank Survey" links.<br><br>

Please respond by <b>December 23, 2016</b>.<br><br>

<u>Note</u> - You will receive this email for each Program or Process where you are the Owner, Manager or Specialist.<br><br>

Please contact me if you have any questions, comments, or requests not covered in the above survey.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
--->

<cfset i = i+1>
</cfoutput>