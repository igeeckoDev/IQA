<cfset numberoffields = 10>
<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif len(evaluate(variables.filename))>
      <cffile action="UPLOAD"
         destination="#basedir#KB\attachments\"
         nameconflict="OVERWRITE"
          filefield="#variables.filename#">
       <cfset message = message & ",File%20#i#%20(#file.serverfile#)%20was%20uploaded">
     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>
   <cflocation url="multi.cfm?msg=#variables.message#" addtoken="no">
 
<cfelse>
  <h2>File Upload</h2>20    <cfif isdefined("url.msg")>
      <div style="color:#FF0000;">
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
     </div>
   </cfif>
  <form action="multi.cfm.cfm" enctype="multipart/form-data" method="post">
     <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
     <cfset filename = "file" & #i#>
     <input type="File" name="<cfoutput>#variables.filename#</cfoutput>" /><br>
     </cfloop>
 <input type="Submit" name="upload" value="upload">
 </form>
</cfif>