<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Report - Upload Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset numberoffields = 5>

<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif len(evaluate(variables.filename))>
      <cffile action="UPLOAD"
         destination="#IQARootPath#Reports/Temp"
         nameconflict="OVERWRITE"
         filefield="#variables.filename#">

		<!--- add a row in table for every file uploaded --->
        <!--- update row with filename, filelabel, associated report # --->
      	<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="Corporate">
		SELECT MAX(rID)+1 as maxID FROM ReportAttach
        </cfquery>

        <cfif maxID.recordcount eq 0>
        	<cfset rID = 1>
        <cfelse>
        	<cfset rID = #maxID.maxID#>
        </cfif>

		<cffile action="rename"
			destination="#IQARootPath#Reports/#URL.Year#-#URL.ID#-Attach-#rID#.#cffile.serverFileExt#"
			source="#IQARootPath#Reports\Temp\#cffile.serverFile#">

        <cfset filelabel = #Evaluate("form.fileLabel#i#")#>

		<cfset vFileName = "#URL.Year#-#URL.ID#-Attach-#rID#.#cffile.serverFileExt#">

        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		INSERT INTO ReportAttach(ID, Year_, rID, filename, fileLabel)
        VALUES(#URL.ID#, #URL.Year#, #rID#, '#vFileName#', '#fileLabel#')
        </CFQUERY>

      <cfset message = message & ",File%20#i#%20(#file.serverfile#)%20was%20uploaded">

     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>

   <cflocation url="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#URL.AuditedBy#&msg=#variables.message#" addtoken="no">

<cfelse>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>
  <cfoutput><Br>

<cfif url.auditedby is "LAB" OR url.AuditedBy is "VS" OR url.AuditedBy is "ULE">
		<a href="auditdetails.cfm?id=#url.id#&year=#url.year#&auditedby=#URL.AuditedBy#">Return to Audit Details</a>
<cfelse>
		<a href="report_output_all.cfm?id=#url.id#&year=#url.year#&auditedby=#URL.AuditedBy#">Return to Audit Report</a>
</cfif><Br /><br />

    <form action="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#URL.AuditedBy#" enctype="multipart/form-data" method="post">
  </cfoutput>

     <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
     <cfset filename = "file" & #i#>
     <cfoutput><b>File #i#</b></cfoutput><br />
     	Add File to Upload:<br />
        <input type="File" name="<cfoutput>#variables.filename#</cfoutput>"><br>

        File Title<br />
        <input type="text" name="<cfoutput>fileLabel#i#</cfoutput>" size="75" /><br /><br />
     </cfloop>

    <input type="Submit" name="Upload" value="Upload Report Files">

    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->