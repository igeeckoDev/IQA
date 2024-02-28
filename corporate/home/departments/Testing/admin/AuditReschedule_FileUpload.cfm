<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<cfoutput>#URL.Year#-#URL.ID#-IQA</cfoutput> - Audit Reschedule File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.File")>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Form.File" 
DESTINATION="#IQARootPath#RescheduleFiles\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/msword">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#-RescheduleFile.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#RescheduleFiles\#NewFileName#">
      
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		Update AuditSchedule 
		SET
		FileReschedule = '#NewFileName#'
		
		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>
      
      <cfset message = "Reschedule File #NewFileName# was uploaded">
   
   <cflocation url="AuditReschedule_FileUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">
 
<cfelse>

  <cfif isdefined("url.msg")>
  <br>
    <cfoutput><font color="red"><b>#url.msg#</b></font></cfoutput><br>
   </cfif>
  <cfoutput><Br>

<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><br>
  
<form action="AuditReschedule_FileUpload.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
  </cfoutput>
  
     	Audit Reschedule File to Upload:<br />
        <input type="File" size="50" name="File"><br><br />
 	
	<input type="Submit" name="upload" value="upload">
 	
    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->