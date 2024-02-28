<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#REQUEST.SiteTitle# - Edit AS Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Edit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="ASContact" Datasource="Corporate">
SELECT * FROM ASContact
ORDER BY ASContact
</cfquery>
	
<CFQUERY BLOCKFACTOR="100" NAME="ASAccreditors" Datasource="Corporate">
SELECT * FROM ASAccreditors
ORDER BY Accreditor
</cfquery>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
	
<cfoutput query="Edit">	
<b>#AuditedBy#-#year#-#ID#</b><br><br>
			  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="AS_edit_Submit.cfm?ID=#URL.ID#&Year=#Year#">
<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="AS">
<b>Audit Year</b>: #Year#</b><br />
<b>Month Scheduled</b>: #MonthAsString(Month)#<br>
<b>Audit Dates</b>: 
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br /><Br />

<u>Note</u> - Please change audit dates/month under the heading "Audit Dates" on the <a href="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#">Audit Details</a> page.<br /><br />

Type of Audit: (#AuditType#)<br>
<SELECT NAME="e_AuditType" displayname="Accreditor">
	<OPTION Value="#AuditType#" SELECTED>No Changes
	<option value="">---
</cfoutput>
<cfoutput query="ASAccreditors">	
	<OPTION VALUE="#Accreditor#">#Accreditor#
</cfoutput>											
</SELECT>
<br><br>

<cfoutput query="Edit">
Site being Audited: (#OfficeName#)<br>
<SELECT NAME="e_OfficeName" displayname="Site Audited">
		<OPTION VALUE="#OfficeName#" SELECTED>No Changes
	<option value="">---		
</cfoutput>		
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="Edit">
AS Contact: (#ASContact#)<br>
<SELECT NAME="e_ASContact" displayname="AS Contact">
		<OPTION VALUE="#ASContact#">No Changes
		<option value="">---
</cfoutput>
<CFOUTPUT QUERY="ASContact">
		<OPTION VALUE="#ASContact#">#ASContact#
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="Edit">
Site Contact: (#SiteContact#)<br>
<INPUT TYPE="TEXT" NAME="e_SiteContact" VALUE="#SiteContact#" displayname="Site Contact"><br><br>

Scope:<br>
<cfset S1 = #ReplaceNoCase(Scope, "<br>", chr(13), "ALL")#>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Scope" Value="#Scope#">#S1#</textarea><br><br>
</cfoutput>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->