<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator Profiles - Upload Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfset numberoffields = 5>

<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif evaluate(variables.filename) neq "">
      <cffile action="UPLOAD"
         destination="#REQUEST.CARAdminFilesPath#"
         nameconflict="OVERWRITE"
         filefield="#variables.filename#">
		
		<!--- add a row in table for every file uploaded --->
        <!--- update row with filename, filelabel, associated report # --->  
      	<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="Corporate">
		SELECT MAX(ID)+1 as maxID FROM CARAdminFiles
        </cfquery>
        
        <cfif maxID.recordcount eq 0>
        	<cfset newID = 1>
        <cfelse>
        	<cfset newID = #maxID.maxID#>
        </cfif>
        
        <cfset filelabel = #Evaluate("form.fileLabel#i#")#>
        
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		INSERT INTO CARAdminFiles(ID, CARAdminID, filename, fileLabel, DateAdded)
        VALUES(#newID#, #URL.ID#, '#file.serverfile#', '#fileLabel#', #CreateODBCDate(curdate)#)
        </CFQUERY>
      
      <cfset message = message & ",File%20#i#%20(#file.serverfile#)%20was%20uploaded">
     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>
   <cflocation url="CARAdminFiles.cfm?ID=#URL.ID#&msg=#variables.message#" addtoken="No">
 
<cfelse>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>
  <cfoutput><Br>
  <a href="CARAdminView.cfm?ID=#URL.ID#">Return to CAR Administrator Profile</a><br><br />
  
    <form action="CARAdminFiles.cfm?ID=#URL.ID#" enctype="multipart/form-data" method="post">
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

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->