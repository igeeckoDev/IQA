<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT OfficeName FROM IQAtblOffices
WHERE ID = #URL.OfficeID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#URL.Year#-#URL.ID#-IQA - #OfficeName.OfficeName# - International Certification Form Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset numberoffields = 1>

<cfif isdefined("form.upload")>
    <CFFILE ACTION="UPLOAD"
        DESTINATION="#IQARootPath#ICForm\Temp"
        NAMECONFLICT="OVERWRITE"
        filefield="form.File">

    <cfset FileName="#form.file#">

    <cfset NewFileName="#URL.Year#-#URL.ID#-#URL.OfficeID#-ICForm.#cffile.ClientFileExt#">

    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQARootPath#ICForm\Temp\#NewFileName#">

    <cffile
    	action="move"
        source="#IQARootPath#ICForm\Temp\#NewFileName#"
        destination="#IQARootPath#ICForm\">

	<CFQUERY BLOCKFACTOR="100" NAME="ICFormList" Datasource="Corporate">
	SELECT ICForm FROM AuditSchedule
    WHERE ID = #URL.ID# AND Year_ = #URL.Year#
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
    Update AuditSchedule
    SET
    ICForm = '#NewFileName#'

    WHERE ID = #URL.ID# AND Year_ = #URL.Year#
    </CFQUERY>

	<cfset message = "#NewFileName# was uploaded">

	<cflocation url="ICForm_Upload.cfm?#CGI.QUERY_STRING#&msg=#message#" addtoken="no">

<cfelse>

  <cfif isdefined("url.msg")>
  <br>
      <cfloop list="#url.msg#" index="i">
        <cfoutput>#i#</cfoutput><br>
      </cfloop>
   </cfif>

<cfoutput><Br>

Upload IC Form for <b>#OfficeName.OfficeName#</b><Br><Br>

<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><br>

<form action="ICForm_Upload.cfm?#CGI.Query_String#" enctype="multipart/form-data" method="post">
</cfoutput>
<br />

    <b>IC Form to Upload</b>:<br />
    <input type="File" size="50" name="File"><br><br />

    <input type="Submit" name="upload" value="upload">

    </form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->