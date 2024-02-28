<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Auditor Qualifications - Audit Type">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Qualified
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<font class="warning">#url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<cfoutput>
<b>Auditor</b>: #Auditors.Auditor#<br /><br />
</cfoutput>

<b>Current - Audit Types Qualified to Conduct</b>:<Br />
<cfoutput query="Auditors">
    <cfif len(Qualified)>
    	#replace(Qualified, ",", "<br />", "All")#
    <cfelse>
    	None Listed
    </cfif>
</cfoutput><br /><br />

<cfFORM METHOD="POST" name="Audit" ACTION="Auditors_Qualification_Action.cfm?#CGI.QUERY_STRING#">
<b>New - Select Audit Types</b>: Select multiple by holding the Ctrl button<br />
<u>Usage</u>: Use "Retain Current" if you wish to leave the values as is. You can also add new values by selecting "Retain Current" and new values.<br />
<SELECT NAME="e_Qualified" displayname="Qualified Audit Types" multiple="multiple" size="5">
    <OPTION value="None">None</OPTION>
    <cfoutput query="Auditors">
	    <cfif len(Qualified)><option value="Retain Current">Retain Current</option></cfif>
    </cfoutput>
    <OPTION value="End to End">End to End</OPTION>
    <OPTION value="Full">Full</OPTION>
    <OPTION value="In-Process">In-Process</OPTION>
</SELECT><br /><Br />

<INPUT TYPE="button" value="Save" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->