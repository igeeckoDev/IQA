<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#URL.Year#-#URL.ID# - Audit Cancellation File Upload">
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
DESTINATION="#IQAPath#CancelFiles\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/msword">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#-CancelFile.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQAPath#CancelFiles\#NewFileName#">
      
        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		Update AuditSchedule 
		SET
		FileCancel = '#NewFileName#'
		
		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>
      
      <cfset message = "Cancellation File #NewFileName# was uploaded">
   
   <cflocation url="AuditCancel_FileUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">
<cfelse>

<script language="JavaScript">		
function check() {
  var ext = document.Audit.File.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.File.value.length!=0) || (document.Audit.File.value!=null)) {
	 if(ext != 'pdf') {
    alert('You selected a .'+ext+' file; Only PDF files are accepted.');
    return false; 
	 }
	}	
else
return true;
document.Audit.submit();
}
</script>

	<cfif isdefined("url.msg")>
  		<cfoutput>
        	<br />
            <font color="red"><b>#url.msg#</b></font><br /><br />
		</cfoutput>
	</cfif>

<cfoutput>
<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><Br /><Br />
  
<form name="Audit" action="AuditCancel_FileUpload.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
</cfoutput>

Audit Cancellation File to Upload:<br />
<input type="File" size="50" name="File"><br><br />

<INPUT TYPE="button" value="Upload" name="Upload" onClick=" javascript:check(document.Audit.File);"> 
</form>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->