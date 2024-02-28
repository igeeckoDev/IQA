<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#URL.Year#-#URL.ID#-IQA - Pathnotes Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

    <CFFILE ACTION="UPLOAD" 
    FILEFIELD="Form.File" 
    DESTINATION="#IQARootPath#Pathnotes\Temp" 
    NAMECONFLICT="OVERWRITE">
    
    <cfset FileName="#Form.File#">
    
    <cfset NewFileName="#URL.Year#-#URL.ID#-Pathnotes.#cffile.ClientFileExt#">
     
    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQARootPath#Pathnotes\Temp\#NewFileName#">
      
    <cffile
    	action="move"
        source="#IQARootPath#Pathnotes\Temp\#NewFileName#"
        destination="#IQARootPath#Pathnotes\">
      
    <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
    Update AuditSchedule 
    SET
    PathNotesFile = '#NewFileName#',
    PathNotesDate = #createODBCDate(curdate)#
    
    WHERE ID = #URL.ID# AND Year_ = #URL.Year#
    </CFQUERY>
      
	<cfset message = "Pathnotes file #NewFileName# was uploaded">
   
  <cfif isdefined("message")>
  <br>
    <cfoutput><font color="red">#message#</font></cfoutput><br>
   </cfif><Br>

<cfoutput>
	<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->