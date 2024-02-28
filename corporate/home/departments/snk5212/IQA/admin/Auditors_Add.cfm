<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Add Auditor - Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT OfficeName 
FROM IQAtbloffices
WHERE Exist = 'Yes'
AND Finance = 'Yes'
AND Physical = 'Yes'
ORDER BY OfficeName
</cfquery>

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<b><font class="warning">#url.msg#</font></b>
        <br /><br />
    </cfoutput>
</cfif>

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="Auditors_update.cfm?Type=#URL.Type#">
<cfoutput>
<u>Name</u>:<br>
#URL.Auditor#
<cfinput name="Auditor" type="Hidden" size="70" value="#URL.Auditor#" required="yes">
<input type="hidden" name="EmpNo" value="#url.EmpNo#" />

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
<br><br>
</cfoutput>

<cfif url.Type NEQ "TechnicalAudit">
    <u>Select Location</u>:<br />
    <CFSELECT NAME="Location" message="Location is required" required="yes">
        <OPTION VALUE="">Select Site
        <option value="">---
    <CFOUTPUT QUERY="OfficeName">
        <OPTION VALUE="#OfficeName#">#OfficeName#
    </CFOUTPUT>
    </CFSELECT>
    <br><br>
<cfelse>
	<cfoutput>
    <u>Department Number</u> (Oracle Employee Directory):<br />
    #URL.Department#
    <input name="Department" type="Hidden" size="70" value="#URL.Department#">
    <input name="Location" type="Hidden" size="70" value="#URL.Location#">
	</cfoutput>
    <br /><Br />
</cfif>

<cfoutput>
<u>Email</u>:<br>
#URL.Email#
<input name="Email" type="Hidden" size="70" value="#URL.Email#">
<br><br>

<div style="position:relative; z-index:3">
<u>Active Date</u>:<br />
<cfinput type="datefield" name="ActiveDate" value="#curDate#" validate="date" maxlength="10" required="yes" message="Active Date is required">
</div>
<br><br><br />

<input name="submit" type="submit" value="Add Auditor"> 
</cfoutput>
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->