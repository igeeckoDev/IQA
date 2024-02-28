<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<div align="Left" class="blog-time">
<br />
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

<cfif isDefined("URL.CAR")>
	<cfif URL.CAR eq "Yes">
        <cfset Type = "CAR">
    <cfelseif URL.CAR eq "No">
        <cfset Type = "SR">
    </cfif>
<cfelseif isDefined("FORM.Type")>
    <cfset Type = FORM.Type>
</cfif>

<cfform action="#IQADir#TechnicalAudits_SRCAR_Add2_Action.cfm?ID=#URL.ID#&Year=#URL.Year#">
<b>Please Enter <cfoutput>#Type#</cfoutput> Number:</b><br>

<cfinput type="hidden"
	name="IssueType"
    value="#Type#">

<cfinput type="text" 
	name="SRCARNumber"
    size="25" 
    message="Please Enter #Type# Number"
    required="Yes"><br><br>
    
<cfif isDefined("Type")>
	<cfinput type="hidden" name="SetDueDate" Value="Yes">
<cfelse>
	<cfinput type="hidden" name="SetDueDate" Value="No">
</cfif>

Please enter any additional SR or CAR Numbers below. Separate each with a comma.<br>
<cfinput type="text" 
	name="SRCAR_AdditionalNumbers"
    size="75"><br><br> 

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>