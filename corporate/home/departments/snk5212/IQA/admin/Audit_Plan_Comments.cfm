<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Audit Plan Comments">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset Start = #url.Start#>
<cfset Middle = #url.start# + 1>
<cfset End = #url.Start# + 2>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cflock scope="SESSION" timeout="60">
<cfquery name="plan" Datasource="Corporate"> 
SELECT *
 FROM Plan
 WHERE OfficeName='#URL.OfficeName#' 
 AND START_=#URL.Start# AND YEAR_=#URL.YEAR#
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "IQAAuditor" or SESSION.Auth.AccessLevel is "Auditor"> AND  AuditedBy = 'IQA'
<cfelse>
 AND  AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfif Plan.recordcount is 0>
<cfoutput>
<b><u>Audit Plan Comments</u></b><br>
</u>#URL.OfficeName# (#URL.Year#) - #URL.AuditedBy#</u><br><br>
The Audit Plan for #URL.Year# has not yet been entered. Please enter the audit plan data first.<br><br>
<a href="#link#">Return</a> to Audit Plan<br><br>
</cfoutput>
<cfelse>
<cfoutput query="Plan">	
<b><u>Audit Plan Comments</u></b><br>
</u>#URL.OfficeName# (#URL.Year#) - #URL.AuditedBy#</u><br><br>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Audit_Plan_Comments_Submit.cfm?officename=#url.officename#&start=#URL.Start#&year=#url.year#&auditedby=#URL.AuditedBy#">

<cfif NOT Len(Comments)>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="e_Comments" Value="" displayname="Comments"></textarea><br><br>
<cfelse>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="e_Comments" Value="" displayname="Comments">#Comments#</textarea><br><br>
</cfif>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>
</cfoutput>		
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->