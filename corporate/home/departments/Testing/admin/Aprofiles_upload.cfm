<CFQUERY BLOCKFACTOR="100" NAME="ID" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE ID= #URL.ID#
	ORDER BY LastName
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Profile - Upload Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>
						  
<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">
<div class="blog-time">Auditor List Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditorlist.cfm')">[?]</A></div><br>

This page allows you to upload one up to ten qualification files at a time for the expertise/training for the auditor profile of <cfoutput query="ID"><B>#trim(auditor)#</B>. Any file field left blank will be ignored.<br><br>

<a href="Aprofiles_detail.cfm?id=#id#">View Auditor Profile</a></cfoutput><br><br>

<cfset numberoffields = 10>

<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif len(evaluate(variables.filename))>
      <cffile action="UPLOAD"
         destination="#IQARootPath#Auditors\#URL.ID#"
         nameconflict="OVERWRITE"
          filefield="#variables.filename#">
      <cfset message = message & ",File%20#i#%20(#file.serverfile#)%20was%20uploaded">
     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>
   <cflocation url="AProfiles_upload.cfm?id=#url.id#&msg=#variables.message#" ADDTOKEN="No">
 
<cfelse>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>
  <cfoutput><form action="AProfiles_upload.cfm?id=#url.id#" enctype="multipart/form-data" method="post"></cfoutput>
     <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
     <cfset filename = "file" & #i#>
     <input type="File" name="<cfoutput>#variables.filename#</cfoutput>"><br>
     </cfloop>
 <input type="Submit" name="upload" value="upload">
 </form>
</cfif>

Note: If you need to delete files from the qualification list, please contact <a href="mailto:Kai.Huang@ul.com">Kai Huang</a><br><br>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->