<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, SentTo
FROM AuditPlanning_Users
WHERE Type = 'ULE'
</CFQUERY>

<Cfoutput query="Distribution">
<!---
<cfmail 
	to="#SentTo#" 
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="2012 IQA Audit Planning - UL Environment"
    type="html">    
UL Environment Staff:<br><br>

Preparation for 2012 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for <b>UL Environment</b> for the 2012 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for <b>UL Environment</b>:<br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 20, 2011</b>.<br><br>

Contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
</Cfoutput>

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, SentTo
FROM AuditPlanning_Users
WHERE Type = 'VS'
</CFQUERY>

<Cfoutput query="Distribution">
<cfmail 
	to="#SentTo#" 
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="2012 IQA Audit Planning - UL Verification Services"
    type="html">  
UL Verification Services Staff:<br><br>

Preparation for 2012 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for <b>UL Verification Services</b> for the 2012 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for <b>UL Verification Services</b>:<br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 20, 2011</b>.<br><br>

Contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
</Cfoutput>

<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, SentTo
FROM AuditPlanning_Users
WHERE Type = 'WiSE'
</CFQUERY>

<Cfoutput query="Distribution">
<cfmail 
	to="#SentTo#" 
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="2012 IQA Audit Planning - WiSE"
    type="html">   
WiSE Staff:<br><br>

Preparation for 2012 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for <b>WiSE</b> for the 2012 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for <b>WiSE</b>:<br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#">http://usnbkiqas100p/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=#ID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 20, 2011</b>.<br><br>

Contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
--->
</Cfoutput>