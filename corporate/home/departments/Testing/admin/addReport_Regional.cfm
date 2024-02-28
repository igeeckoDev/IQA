<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "File Uploads - Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="file.js"></script>
						  
<CFQUERY BLOCKFACTOR="100" name="Plan" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="Plan">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addReport_Regional_Update.cfm?ID=#ID#&Year=#Year#&type=#url.type#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

<cfif url.type is "Report">
<br>
Upload Report:<br>
File will be renamed <B>#Year#-#ID#.pdf</b><br>
Must be PDF File Format!<br>
<INPUT NAME="File" SIZE=50 TYPE=FILE><br><br>
</cfif>

<INPUT TYPE="button" value="Upload Audit Report" onClick=" javascript:check(document.Audit.File);"> 
</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->