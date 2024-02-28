<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset title = "AS Audit Reports - Upload Files for #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset numberoffields = 5>

<cfif isdefined("form.upload")>
  <cfset message = "">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif evaluate(variables.filename) neq "">
      <cffile action="UPLOAD"
         destination="#path#ASReports"
         nameconflict="OVERWRITE"
         filefield="#variables.filename#">

		<!--- add a row in table for every file uploaded --->
        <!--- update row with filename, filelabel, associated report # --->
      	<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
		SELECT MAX(rID)+1 as maxID FROM ASReportAttach
        </cfquery>

        <cfif maxID.recordcount eq 0>
        	<cfset rID = 1>
        <cfelse>
        	<cfset rID = #maxID.maxID#>
        </cfif>

        <cfset filelabel = #Evaluate("form.fileLabel#i#")#>

        <CFQUERY BLOCKFACTOR="100" NAME="AddID" DataSource="Corporate">
		INSERT INTO ASReportAttach(ID, Year_, rID, filename, fileLabel)
        VALUES(#URL.ID#, #URL.Year#, #rID#, '#file.serverfile#', '#fileLabel#')
        </CFQUERY>

      <cfset message = message & ",File%20#i#%20(#file.serverfile# (#filelabel#))%20was%20uploaded">
     <cfelse>
       <cfset message = message & ",File%20#i#%20was%20empty">
     </cfif>
   </cfloop>

   <cflocation url="ASReports_Details.cfm?#CGI.Query_String#&msg=#variables.message#" addtoken="No">

<cfelse>

  <cfoutput><Br>
  <a href="ASReports_Details.cfm?#CGI.Query_String#">Return</a> to Details View<br>

    <form action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post">
  </cfoutput>

     <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
     <cfset filename = "file" & #i#>
     <cfoutput><b>File #i#</b></cfoutput><br />
     	Add File to Upload:<br />
        <input type="File" name="<cfoutput>#variables.filename#</cfoutput>"><br>

        File Title<br />
        <input type="text" name="<cfoutput>fileLabel#i#</cfoutput>" size="75" /><br /><br />
     </cfloop>

    <input type="Submit" name="upload" value="Upload Files">

    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">d
<!--- / --->