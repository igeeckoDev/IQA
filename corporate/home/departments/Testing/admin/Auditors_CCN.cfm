<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Auditor Qualifications - CCN">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, CCN
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY Name="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_CCN
WHERE Status IS NULL
Order BY CCN
</CFQUERY>


<cfif isDefined("URL.msg")>
	<cfoutput>
    	<font class="warning">#url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<cfoutput>
<b>Auditor</b>: #Auditors.Auditor#<br /><br />
</cfoutput>

<b>Current - Qualified CCNs</b>:<Br />
<cfoutput query="Auditors">
    <cfif len(CCN)>
    	#replace(CCN, ",", "<br />", "All")#
    <cfelse>
    	None Listed
    </cfif>
</cfoutput><br /><br />

<cfFORM METHOD="POST" name="Audit" ACTION="Auditors_CCN_Action.cfm?#CGI.QUERY_STRING#">
<b>New - Select CCNs</b>: Select multiple by holding the Ctrl button<br />
<u>Usage</u>: Use "Retain Current" if you wish to leave the values as is. You can also add new values by selecting "Retain Current" and new values.<br />
<SELECT NAME="e_CCN" displayname="Qualified CCNs" multiple="multiple" size="5">
    <OPTION value="None">None</OPTION>
    <cfoutput query="Auditors">
	    <cfif len(CCN)><option value="Retain Current">Retain Current</option></cfif>
    </cfoutput>
	<cfoutput query="CCN">
    	<OPTION value="#CCN#">#CCN#</OPTION>
    </cfoutput>
</SELECT><br /><Br />

<INPUT TYPE="button" value="Save" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->