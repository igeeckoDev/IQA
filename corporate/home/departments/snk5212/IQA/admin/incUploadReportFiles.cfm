<cfset numberoffields = 5>

<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif len(evaluate(variables.filename))>
      <cffile action="UPLOAD"
         destination="#basedir#Reports"
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
        
        <cfset filelabel = #Evaluate("form.fileLabel#i#")#>
        
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		INSERT INTO ReportAttach(ID, Year, rID, filename, fileLabel)
        VALUES(#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, #rID#, '#file.serverfile#', '#fileLabel#')
        </CFQUERY>
      
      <cfset message = message & ",File%20#i#%20(#file.serverfile# (#filelabel#))%20was%20uploaded">
     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>
   <cflocation url="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" ADDTOKEN="No">
 
<cfelse>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>
  <cfoutput>
    <form action="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
  </cfoutput>
  
     <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
     <cfset filename = "file" & #i#>
     <cfoutput><b>File #i#</b></cfoutput><br />
     	Add File to Upload:<br />
        <input type="File" name="<cfoutput>#variables.filename#</cfoutput>"><br>
        
        File Title<br />
        <input type="text" name="<cfoutput>fileLabel#i#</cfoutput>" size="75" /><br /><br />
     </cfloop>
 	
    <input type="Submit" name="upload" value="upload">
 	
    </form>
</cfif>