<CFQUERY BLOCKFACTOR="100" NAME="ID" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE ID= #URL.ID#
	ORDER BY LastName
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor CV Upload - #ID.Auditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			  
<table width="650" border="0" cellpadding="1" cellspacing="1" valign="top">

<cfif isdefined("form.CVFile")>
 	<cfif form.CVFile is "">
		<cflocation url="AProfiles_CV.cfm?id=#url.id#&msg=No File Attached" ADDTOKEN="No">
	<cfelse>
    <cffile action="UPLOAD"
		filefield="CVFile"
		destination="#IQAPath#Auditors\#URL.ID#"
    	nameconflict="OVERWRITE">
		 
	<cfset FileName="#Form.CVFile#">
	<cfset NewFileName="CV.#cffile.ClientFileExt#">
	<cfset message = "CV File%20(#NewFileName#)%20was%20uploaded">
	
	<cffile
	    action="rename"
	    source="#FileName#"
	    destination="#IQAPath#Auditors\#URL.ID#\#NewFileName#">
	
    <cfif File.ServerFile NEQ NewFileName>
        <cffile
            action="delete"
            file="#IQAPath#Auditors\#URL.ID#\#file.serverfile#">
	</cfif>	
        
	<CFQUERY BLOCKFACTOR="100" NAME="ID" Datasource="Corporate">
	UPDATE AuditorList
	SET
	CV=1
	WHERE ID = #URL.ID#
	</cfquery>	
    
	<cflocation url="AProfiles_CV.cfm?id=#url.id#&msg=#variables.message#" ADDTOKEN="No">
 	</cfif>
 
<cfelse>

<cfoutput query="ID">
<br>
<a href="Aprofiles_detail.cfm?id=#id#">View Auditor Profile</a><br>
<cfif CV eq 1>
	<a href="#IQADir#Auditors\#ID#\CV.pdf">View</a> CV for #ID.Auditor#<br><Br>
<cfelse>
	<br>
</cfif>

<cfif isdefined("url.msg")>
	<font color="red">#url.msg#</font><br>
</cfif>

<script language="JavaScript">		
function check() {
  var ext = document.Audit.CVFile.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.CVFile.value.length!=0) || (document.Audit.CVFile.value!=null)) {
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

<form action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" enctype="multipart/form-data" method="post" name="Audit">
</cfoutput>

File to upload:<br>
<input type="File" name="CVFile" size="50"><br>
* - File Types Allowed: PDF<br><br>

<INPUT TYPE="button" value="Upload" name="Upload" onClick=" javascript:check(document.Audit.CVFile);">

</form>
</cfif>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->