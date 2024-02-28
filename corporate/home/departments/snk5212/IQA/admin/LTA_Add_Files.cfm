<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Add Report">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="file.js"></script>
						  
<CFQUERY BLOCKFACTOR="100" name="Plan" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.AccessLevel is "Laboratory Technical Audit">

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="LTA_Add_Files_Update.cfm?ID=#URL.ID#&Year=#URL.Year#">

<br>
Upload Report:<br>
File will be renamed <B>#URL.Year#-#URL.ID#.file extension</b><br>
<INPUT NAME="File" SIZE=50 TYPE=FILE><br><br>

<INPUT TYPE="button" value="Send Scope Letter" onClick=" javascript:check(document.Audit.File);"> 
</FORM>

</cfoutput>

<cfelse>
<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" ADDTOKEN="No">
</CFIF>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->