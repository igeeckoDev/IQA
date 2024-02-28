<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query.DB# Calibration Meeting - File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<cfoutput query="Query">
<cfif StartDate eq EndDate>
	<cfset Date = "#dateformat(startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(startdate, "mmmm d")#-#dateformat(enddate, "d, yyyy")#">
</cfif>

<u>Meeting Dates</u> - #Date#<br>
<u>Meeting Type</u> - #DB#<br />
</cfoutput>

<cfset numberoffields = 5>

<cfif isdefined("form.upload")>
  <cfset message = "<br>">
  <cfloop index="i" from="1" to="#variables.numberoffields#" step="1">
    <cfset filename = "form.file" & #i#>
    <cfif len(evaluate(variables.filename))>
      <cffile action="UPLOAD"
         destination="#IQARootPath#calibration"
         nameconflict="OVERWRITE"
         filefield="#variables.filename#">
		
		<!--- add a row in table for every file uploaded --->
        <!--- update row with filename, filelabel, associated report # --->  
      	<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="Corporate">
		SELECT MAX(ID)+1 as maxID FROM CalibrationMeetings_Attach
        </cfquery>
        
        <cfif maxID.recordcount eq 0>
        	<cfset nID = 1>
        <cfelse>
        	<cfset nID = #maxID.maxID#>
        </cfif>
        
        <cfset filelabel = #Evaluate("form.fileLabel#i#")#>
        
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		INSERT INTO CalibrationMeetings_Attach(ID, MeetingID, filename, fileLabel)
        VALUES(#nID#, #URL.ID#, '#file.serverfile#', '#fileLabel#')
        </CFQUERY>
      
      <cfset message = message & "File%20#i#%20(#file.serverfile#)%20was%20uploaded<br>">
     <cfelse>
       <cfset message = message & "File%20#i#%20was%20empty<br>">
     </cfif>
   </cfloop>
   
   <cflocation url="Calibration_Details.cfm?ID=#URL.ID#&msg=#variables.message#" addtoken="no">
 
<cfelse>

  <cfif isdefined("url.msg")>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>
  <cfoutput><Br>
  <a href="Calibration_Details.cfm?ID=#URL.ID#">Return to Calibration Meeting Detail</a><br><br />
  
    <form action="Calibration_FileUpload.cfm?ID=#URL.ID#" enctype="multipart/form-data" method="post">
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
<!--- / --->