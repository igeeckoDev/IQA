<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditPlanning2017_Users
WHERE Type = 'Operations'
ORDER BY ID
</CFQUERY>

<cfset i = 1>
<cfoutput query="Distribution">
#i#<br />
URL.UserID = #ID#<br />
To: #SentTo#<br /><br />

<!---
<cfmail
	to="#SentTo#"
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="Operations - 2017 Audit Planning - Internal Quality Audits"
    type="html">
Engineering Staff:<br><br>

Preparation for 2017 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for the 2017 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information pertaining to Engineering Operations:<br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If you have additional audit requests specific to Certification Bodies, Certification Schemes, accredited testing laboratories, or calibration laboratories, please include this information in the survey responses.<br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

To view the distribution lists, please use the following link:<br />
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Operations">http://usnbkiqas100p/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Operations</a><br /><br />

You can add information for any of the categories listed in the link above by using the "Open Blank Survey" links.<br><br />

Please respond by <b>December 23, 2016</b>.<br><br>

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