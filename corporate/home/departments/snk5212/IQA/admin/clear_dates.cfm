<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Change the Audit Month - #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
		
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
    
<cfif isDefined("URL.msg")>
	<font class="warning">#url.msg#</font><br /><br />
</cfif>
</cfoutput>

<div class="blog-time">Add Dates/Change Dates Help - <A HREF="javascript:popUp('../webhelp/webhelp_changedates.cfm')">[?]</A>

<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="clear_dates_update.cfm?ID=#ID#&Year=#Year#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

The Audit Dates will be cleared when you submit this form. Please selected the new scheduled Month for #year#-#id# below.<br><br>

<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<OPTION VALUE="#i#"<cfif Month is i>SELECTED</cfif>>#MonthAsString(i)#
</cfloop>
</SELECT>
<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>	  
</cfoutput>				  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->