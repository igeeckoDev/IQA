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

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.AccessLevel is "AS">

<cfoutput query="Plan">

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="AS_Upload_File.cfm?ID=#ID#&Year=#Year#&type=#url.type#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

<cfif url.type is "Report">
<br>
Upload Report:<br>
File will be renamed <B>#Year#-#ID#.pdf</b><br>
Must be PDF File Format!<br>
<INPUT NAME="File" SIZE=50 TYPE=FILE><br><br>

<cfelseif url.type is "Agenda">
<br>
Upload Agenda:<br>
File will be renamed <B>#Year#-#ID#.pdf</b><br>
Must be PDF File Format!<br>
<INPUT NAME="File" SIZE=50 TYPE=FILE><br><br>

<cfelse>
<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" addtoken="no">
</cfif>

<INPUT TYPE="button" value="Upload File" onClick=" javascript:check(document.Audit.File);"> 
</FORM>

</cfoutput>

<cfelse>
	<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" addtoken="no">
</CFIF>
</cflock>
					  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->