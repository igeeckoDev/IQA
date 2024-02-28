<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Auditor Qualifications - Standard">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Standard
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Standard
WHERE Status IS NULL
Order BY StandardName, RevisionNumber DESC
</CFQUERY>

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<font class="warning">#url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<cfoutput>
<b>Auditor</b>: #Auditors.Auditor#<br /><br />
</cfoutput>

<b>Current - Qualified Standards</b>:<Br />
<cfoutput query="Auditors">
    <cfif len(Standard)>
    	#replace(Standard, ",", "<br />", "All")#
    <cfelse>
    	None Listed
    </cfif>
</cfoutput><br /><br />

<cfFORM METHOD="POST" name="Audit" ACTION="Auditors_Standard_Action.cfm?#CGI.QUERY_STRING#">
<b>New - Select Standards</b>: Select multiple by holding the Ctrl button<br />
<u>Usage</u>: Use "Retain Current" if you wish to leave the values as is. You can also add new values by selecting "Retain Current" and new values.<br />
<SELECT NAME="e_Standard" displayname="Qualified Standards" multiple="multiple" size="5">
    <OPTION value="None">None</OPTION>
    <cfoutput query="Auditors">
	    <cfif len(Standard)><option value="Retain Current">Retain Current</option></cfif>
    </cfoutput>
    <cfoutput query="Standard">
	    <cfset standardValue = "#StandardName# (#RevisionNumber# - #dateformat(RevisionDate, "mm/dd/yyyy")#)">
		<OPTION VALUE="#standardValue#">#standardValue#
    </cfoutput>
</SELECT><br /><Br />

<INPUT TYPE="button" value="Save" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->