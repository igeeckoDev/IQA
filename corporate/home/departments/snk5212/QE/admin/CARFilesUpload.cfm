<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - Quality Engineering Related Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<script 
	language="javascript" 
	type="text/javascript" 
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfif isDefined("Form.RevHistory")>

<!--- max ID for new record during file upload --->
<CFQUERY DataSource="Corporate" Name="MaxID"> 
SELECT MAX(ID)+1 as MaxID FROM CARFiles
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files"> 
SELECT * FROM CARFiles
WHERE RevNo = (SELECT MAX(RevNo) as MaxRev FROM CARFiles WHERE DocNumber = #URL.DocNumber#) 
AND DocNumber = #URL.DocNumber#
</CFQUERY>

<cfset NewRev = #Files.RevNo# +1>

<CFFILE Action="rename" 
source="#CARRootPath#QEFiles\Doc#URL.DocNumber#Current.#Files.FileType#" 
destination="#CARRootPath#QEFiles\Doc#URL.DocNumber#Rev#Files.RevNo#.#Files.FileType#">

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#CARRootPath#QEFiles\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="Doc#Files.DocNumber#Current.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#CARRootPath#QEFiles\#NewFileName#">
	
<CFQUERY DataSource="Corporate" Name="FileSettingsAdd"> 
INSERT INTO CARFiles(ID, FileLabel, DocNumber, CategoryID)
VALUES (#maxID.MAXID#, '#Files.FileLabel#', #Files.DocNumber#, #Files.CategoryID#)
</cfquery>	

<cflock scope="Session" timeout="6">
<CFQUERY DataSource="Corporate" Name="FileSettings"> 
UPDATE CARFiles
SET

FileType='#cffile.ClientFileExt#',
PlanType='#Files.PlanType#',
RevNo=#NewRev#,
RevDate=#CreateODBCDate(curdate)#,
RevAuthor='#SESSION.Auth.Name#',
RevHistory='#Form.RevHistory#'

WHERE ID = #MaxID.MaxID#
</cfquery>
</cflock>

	<cflocation url="CARFiles.cfm?Rev=#NewRev#&uploaded=Yes&DocName=#Files.FileLabel#" addtoken="No">

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<CFQUERY DataSource="Corporate" Name="Files"> 
SELECT * FROM CARFiles
WHERE DocNumber = #URL.DocNumber#
ORDER BY RevNo DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files2"> 
SELECT MAX(RevNo) as MaxRev FROM CARFiles
WHERE DocNumber = #URL.DocNumber#
</CFQUERY>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#?#CGI.Query_String#">

<cfset NewRev = #Files2.MaxRev# +1>

<cfoutput>
File - <b>#Files.FileLabel#</b><br />
Revision Number - <b>RevNo #NewRev#</b><br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" displayname="File Upload - #Files.FileLabel# RevNo #NewRev#"><br><br>
</cfoutput>

Comments - Please document the current file revision - <font color="Red">REQUIRED</font><br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="RevHistory" displayname="Comments - Please document the current file revision"></textarea>
<br><br>

<INPUT TYPE="button" value="Upload New Revision" onClick="javascript:checkFormValues(document.all('Audit'));"> 
</cfform>

<u>Revision History</u><br>
<cfoutput query="files">
<u>Revision: #RevNo#</u><br>
Upload Date: #dateformat(RevDate, "mm/dd/yyyy")#<br>
Revision Author: #RevAuthor#<br>
<cfif RevNo is NOT Files2.MaxRev>
File: <a href="#CARRootDir#QEFiles\Doc#DocNumber#Rev#RevNo#.#FileType#">View</a><br>
<cfelse>
File: <a href="#CARRootDir#QEFiles\Doc#DocNumber#Current.#FileType#">View</a><br>
</cfif>
<cfset Dump = #replace(RevHistory, "<p>", "", "All")#>
Revision Comments: #Dump#<br><br>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->