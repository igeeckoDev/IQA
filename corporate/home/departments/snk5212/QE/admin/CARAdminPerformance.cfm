<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Administrator Performance">
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
SELECT MAX(ID) as CurID, MAX(ID)+1 as MaxID FROM CARAdminPerformance
</CFQUERY>

<CFFILE Action="rename" 
source="d:\webserver\corporate\home\departments\snk5212\QE\admin\CARAdminPerformance\CARAdminPerformance.xls" 
destination="d:\webserver\corporate\home\departments\snk5212\QE\admin\CARAdminPerformance\CARAdminPerformance#MaxID.CurID#.xls">

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="d:\webserver\corporate\home\departments\snk5212\QE\admin\CARAdminPerformance\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="CARAdminPerformance.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="d:\webserver\corporate\home\departments\snk5212\QE\admin\CARAdminPerformance\#NewFileName#">
    
<CFQUERY DataSource="Corporate" Name="FileSettingsAdd">
INSERT INTO CARAdminPerformance(ID)
VALUES (#maxID.MAXID#)
</cfquery>	
	
<CFQUERY DataSource="Corporate" Name="FileSettings">
UPDATE CARAdminPerformance
SET
Uploaded=#CreateODBCDate(curdate)#,
Comments='#Form.Comments#'

WHERE ID = #MaxID.MaxID#
</cfquery>

<cflocation url="CARAdminPerformance.cfm" addtoken="no">

<cfelse>

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
SELECT * FROM CARAdminPerformance
WHERE ID > 0
ORDER BY ID DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files2">
SELECT MAX(ID) as MaxID FROM CARAdminPerformance
</CFQUERY>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#">

CAR Administrator Performance (XLS format only):<br>
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
File - <a href="#CARAdminDir#CARAdminPerformance/CARAdminPerformance#ID#.xls">View</a><br>
<cfelse>
File - <a href="#CARAdminDir#CARAdminPerformance/CARAdminPerformance.xls">View</a><br>
</cfif>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfoutput>

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->