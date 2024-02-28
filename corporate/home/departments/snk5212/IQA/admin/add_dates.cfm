<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Audit Dates - #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#IQARootDir#webhelp/webhelp.js"></script>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>

<cfif isDefined("URL.msg")>
	<font class="warning">#url.msg#</font><br /><br />
</cfif>
</cfoutput>

<div class="blog-time">
<cfoutput query="ScheduleEdit">
Add Dates/Change Dates Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_changedates.cfm')">[?]</A></div><br />
						  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="add_dates_update.cfm?ID=#ID#&Year=#Year#&auditedby=#auditedby#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">
<INPUT TYPE="Hidden" NAME="Month" VALUE="#Month#">

Curent Month Scheduled: #MonthAsString(Month)#<br>
*Adding dates below will automatically change the month scheduled (if necessary)<br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="e_StartDate" <cfif StartDate is NOT "">VALUE="#DateFormat(StartDate, 'mm/dd/yyyy')#"</cfif> onChange="return ValidateESDate()" displayname="Start Date"><br><br>
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" <cfif StartDate is NOT "">VALUE="#DateFormat(EndDate, 'mm/dd/yyyy')#"</cfif> onChange="return ValidateEDate()"><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>	  

<br />
<b>Clear Dates</b><br>
If you wish to change the month without adding audit dates, go to the <a href="clear_dates.cfm?ID=#ID#&Year=#Year#">Clear Dates</a> page.
</cfoutput>				  
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->