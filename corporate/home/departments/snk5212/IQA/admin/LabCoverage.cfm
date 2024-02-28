<cfquery Datasource="Corporate" name="Details"> 
SELECT OfficeName
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Details.OfficeName# - Lab Coverage File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript">		
function check() {
  var ext = document.Audit.e_File.value;
  ext = ext.substring(ext.length-4,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_File.value.length!=0) || (document.Audit.e_File.value!=null)) {
	 if(ext != '.xls') {
	  if(ext != 'xlsx') {
		alert('You selected a '+ext+' file; Only xls/xlsx (MS Excel) files are accepted.');
	  return false; 
	  }
	 }
	}	
else
return true;
document.Audit.submit();
}
</script>

<cfif isdefined("url.msg")>
<br>
<cfoutput><font color="red">#url.msg#</font></cfoutput><br>
</cfif>

<cfoutput>
<Br>
<a href="Office_Details.cfm?ID=#URL.ID#">Return to Office Details</a> - #Details.OfficeName#<br><br>
  
<form action="LabCoverage_Submit.cfm?ID=#URL.ID#&Exist=#URL.Exist#" enctype="multipart/form-data" method="post" name="Audit">
</cfoutput>
  
Lab Coverage File to Upload: (MS Excel Only)<br />
<input type="File" size="50" name="e_File"><br><br />

<INPUT TYPE="button" value="Upload" name="Upload" onClick=" javascript:check(document.Audit.e_File);"> 
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->