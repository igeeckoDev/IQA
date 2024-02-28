<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Administrator Responsibility Matrix">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
    <script
        language="javascript"
        type="text/javascript"
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>

    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfif isDefined("Form.Comments")>

<CFQUERY DataSource="Corporate" Name="MaxID">
SELECT MAX(ID) as CurID, MAX(ID)+1 as MaxID FROM CARResponsibility
</CFQUERY>

<CFFILE Action="rename"
source="#CARRootPath#CARMatrix\CARAdministratorResponsibilityList.xls"
destination="#CARRootPath#CARMatrix\CARAdministratorResponsibilityListID#MaxID.CurID#.xls">

<CFFILE ACTION="UPLOAD"
FILEFIELD="e_AttachA"
DESTINATION="#CARRootPath#CARMatrix\"
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="CARAdministratorResponsibilityList.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#CARRootPath#CARMatrix\#NewFileName#">

<CFQUERY DataSource="Corporate" Name="FileSettingsAdd">
INSERT INTO CARResponsibility(ID)
VALUES (#maxID.MAXID#)
</cfquery>

<CFQUERY DataSource="Corporate" Name="FileSettings">
UPDATE CARResponsibility
SET
Uploaded=#CreateODBCDate(curdate)#,
Comments='#Form.Comments#'

WHERE ID = #MaxID.MaxID#
</cfquery>

<CFQUERY DataSource="Corporate" Name="Files">
SELECT * FROM CARResponsibility
ORDER BY ID DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files2">
SELECT MAX(ID) as MaxID FROM CARResponsibility
</CFQUERY>

<u>Revision History</u><br>
<cfoutput query="files">
Rev - #ID#<br>
Date - #dateformat(uploaded, "mm/dd/yyyy")#<br>
<cfif ID is NOT Files2.MaxID>
File - <a href="#CARRootDir#CARMatrix\CARAdministratorResponsibilityListID#ID#.xls">View</a><br>
<cfelse>
File - <a href="#CARRootDir#CARMatrix\CARAdministratorResponsibilityList.xls">View</a><br>
</cfif>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfoutput>

<a href="CARResponsibility.cfm">Upload</a> CAR Administrator Responsibility Matrix<br><br>

<cflocation url="CARResponsibility.cfm?Rev=#Files2.MaxID#&uploaded=Yes" addtoken="No">

</cfif>

<script language="JavaScript">
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'xls') {
    alert('You selected a .'+ext+' file; please select a xls file!');
    return false;
	  }
	}
else
return true;
document.Audit.submit();
}
</script>

<CFQUERY DataSource="Corporate" Name="Files">
SELECT * FROM CARResponsibility
ORDER BY ID DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files2">
SELECT MAX(ID) as MaxID FROM CARResponsibility
</CFQUERY>

<cfif isDefined("url.uploaded") AND isDefined("url.rev")>
	<cfoutput>
		<font color="red">
    	Revision <b>#URL.Rev#</b> of the CAR Administrator Responsibility Matrix has been uploaded
    	</font>
    </cfoutput><br /><br />
</cfif>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#">

CAR Administrator Responsibility Matrix (XLS format only):<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" DisplayName="Attachment A"><br><br>

Document this revision<br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Comments">Please add any comments about the changes made to the current List</textarea>
<br><br>

<INPUT TYPE="button" value="Upload List" onClick=" javascript:check(document.Audit.e_AttachA);"><br><br>

<u>Revision History</u><br>
<cfoutput query="files">
Rev - #ID#<br>
Date - #dateformat(uploaded, "mm/dd/yyyy")#<br>
<cfif ID is NOT Files2.MaxID>
File - <a href="#CARRootDir#CARMatrix\CARAdministratorResponsibilityListID#ID#.xls">View</a><br>
<cfelse>
File - <a href="#CARRootDir#CARMatrix\CARAdministratorResponsibilityList.xls">View</a><br>
</cfif>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfoutput>

</cfform>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->