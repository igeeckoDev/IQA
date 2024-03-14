<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPAuditPlanning2016_Users
WHERE ID = 38
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
    subject="2016 DAP Audit Planning"
    type="html">
Dear BU managers, Industry Coordinators, Operations Staff, and NCB Managers:<br><br>

Assignment of DAP Audits for 2016 has begun. Our ultimate goal is to ensure that your BU based Auditor supply (capacity) meets your BU Audit
needs (Audit demand / quality).<br><br>

To help us in the process, we are requesting your input in meeting our shared goal for the 2016 audit year. This information will be included
in our audit and training plans.<br><br>

Please follow the link below to provide information pertaining to your Business Unit/Industry:<br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo_DAP.cfm?UserID=#ID#">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo_DAP.cfm?UserID=#ID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

To view the distribution list, please use the following link:<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/DAP_Distribution_2016.cfm">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/DAP_Distribution_2016.cfm</a><br /><br />

Please respond by <b>December 18, 2015</b>.<br><br>

Please contact Linda Ziemnick (North America) or Larisa Aoyagi (EULA, AP) if you have any questions or comments.<br><br>

Denise Echols<br>
UL LLC<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
--->

<cfset i = i+1>
</cfoutput>