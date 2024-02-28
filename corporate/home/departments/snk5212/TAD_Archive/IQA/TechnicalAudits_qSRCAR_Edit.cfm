<CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM TechnicalAudits_SRCAR
WHERE ID = #URL.SRCAR_ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfif isDefined("URL.msg")>
	<font class="warning"><cfoutput>#URL.msg#</cfoutput></font><br /><br />
    
    <cfoutput>
    If no changes are required, please return to the previous page:<br />
    <a href="TechnicalAudits_AddNC_SelectCategory.cfm?#CGI.QUERY_STRING#">Add Non-Conformances and SR/CARs</a><br /><br />
    </cfoutput>
</cfif>

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.12 Input Non-Conformances<br /><br />
</cfoutput>
</div>

<cfform action="#IQADir#TechnicalAudits_SRCAR_Edit_Action.cfm?#CGI.QUERY_STRING#">
<b>Please Enter <cfoutput>#SRCAR.IssueType#</cfoutput> Number:</b><br>

<cfinput type="hidden"
	name="IssueType"
    value="#SRCAR.IssueType#">

<cfinput type="text" 
	name="SRCARNumber"
    size="25" 
    value="#SRCAR.SRCARNumber#"
    message="Please Enter #SRCAR.IssueType# Number"
    required="Yes"><br><br>

Please enter any additional SR or CAR Numbers below. Separate each with a comma.<br>
<cfinput type="text" 
	name="SRCAR_AdditionalNumbers"
    value="#SRCAR.SRCAR_AdditionalNumbers#"
    size="75"><br><br>
      
<b><cfoutput>#SRCAR.IssueType#</cfoutput> Due Date to be Closed</b><br />

<cfinput type="datefield"
	name="SRCARClosedDueDate"
    value="#dateformat(SRCAR.SRCARClosedDueDate, 'mm/dd/yyyy')#"
    required="yes"
    message="Please Enter the #SRCAR.IssueType# Due Date to be Closed"><br /><br /><br />

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>