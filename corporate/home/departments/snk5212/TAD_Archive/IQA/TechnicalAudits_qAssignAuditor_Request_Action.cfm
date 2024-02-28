<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT OfficeName 
FROM IQAtbloffices
WHERE Exist = 'Yes'
AND Finance = 'Yes'
AND Physical = 'Yes'
ORDER BY OfficeName
</cfquery>

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="#IQADir#TechnicalAudits_AssignAuditor_Request_Action_Submit.cfm?#CGI.Query_String#">
<cfoutput>
<u>Name</u>:<br>
#URL.Auditor#
<cfinput name="Auditor" type="Hidden" size="70" value="#URL.Auditor#" required="yes">
<input type="hidden" name="EmpNo" value="#URL.EmpNo#" />

<cfif isDefined("url.msg")>
	<!--- url.msg is removed --->
    <cfset viewParams = "" />
    <cfloop list="#cgi.query_string#" delimiters="&" index="i">
        <cfif listFirst(i, "=") neq "msg">
            <cfset viewParams = listAppend(viewParams, i, "&") />
        </cfif>
    </cfloop>
<input name="PreviousQueryString" type="Hidden" value="#viewParams#" />
</cfif>
<br><br>

<u>Location</u> (Oracle Employee Directory):<br>
#URL.Location#
<input type="hidden" name="Location" value="#URL.Location#" />
<br><br>
</cfoutput>

<!---
<u>Select Location</u>:<br />
<CFSELECT NAME="Location" message="Location is required" required="yes">
    <OPTION VALUE="">Select Site
    <option value="">---
<CFOUTPUT QUERY="OfficeName">
    <OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</CFSELECT>
<br><br>
--->

<cfoutput>
<u>Department Number</u> (Oracle Employee Directory):<br />
#URL.Department#
<input name="Department" type="Hidden" size="70" value="#URL.Department#">
</cfoutput>
<br /><Br />

<cfoutput>
<u>Email</u>:<br>
#URL.Email#
<input name="Email" type="Hidden" size="70" value="#URL.Email#">
<br><br>

<!---
<div style="position:relative; z-index:3">
<u>Active Date</u>:<br />
<cfinput type="datefield" name="ActiveDate" value="#curDate#" validate="date" maxlength="10" required="yes" message="Active Date is required">
</div>
<br><br><br />
--->

<input name="submit" type="submit" value="Request Auditor"> 
</cfoutput>
</cfform>