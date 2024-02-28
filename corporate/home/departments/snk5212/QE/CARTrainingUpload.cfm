<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - CAR Training Files - Upload">
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

<cfif isDefined("Form.Comments")>

<!--- max ID for new record during file upload --->
<CFQUERY DataSource="Corporate" Name="MaxID"> 
SELECT MAX(ID)+1 as MaxID FROM CARTraining
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files"> 
SELECT * FROM CARTraining
WHERE Rev = (SELECT MAX(Rev) as MaxRev FROM CARTraining WHERE DocNumber = #URL.DocNumber#) 
AND DocNumber = #URL.DocNumber#
ORDER BY Rev
</CFQUERY>

<cfset NewRev = #Files.Rev# +1>

<CFFILE Action="rename" 
source="#CARRootPath#CARTraining\CT#URL.DocNumber#Current.#Files.FileType#" 
destination="#CARRootPath#CARTraining\CT#URL.DocNumber#Rev#Files.Rev#.#Files.FileType#">

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#CARRootPath#CARTraining\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="CT#Files.DocNumber#Current.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#CARRootPath#CARTraining\#NewFileName#">
	
<CFQUERY DataSource="Corporate" Name="FileSettingsAdd"> 
INSERT INTO CARTraining(ID)
VALUES (#maxID.MAXID#)
</cfquery>	
	
<CFQUERY DataSource="Corporate" Name="FileSettings"> 
UPDATE CARTraining
SET
Type='#URl.Type#',
FileTitle='#Files.FileTitle#',
DocNumber=#Files.DocNumber#,
Rev=#NewRev#,
<cfif Files.FileType neq cffile.ClientFileExt>
FileType='#cffile.ClientFileExt#',
<cfelse>
FileType='#Files.FileType#',
</cfif>
Uploaded=#CreateODBCDate(curdate)#,
Comments='#Form.Comments#'

WHERE ID = #MaxID.MaxID#
</cfquery>

<cflocation url="CARTrainingFiles.cfm?Rev=#NewRev#&uploaded=Yes&DocName=#Files.FileTitle#" addtoken="No">

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<CFQUERY DataSource="Corporate" Name="Files"> 
SELECT * FROM CARTraining
WHERE DocNumber = #URL.DocNumber#
AND Rev <> 0
ORDER BY Rev DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="Files2"> 
SELECT MAX(Rev) as MaxRev FROM CARTraining
WHERE DocNumber = #URL.DocNumber#
</CFQUERY>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#?#CGI.Query_String#">

<cfset NewRev = #Files2.MaxRev# +1>

<cfoutput>
#Files.FileTitle# <b>Rev #NewRev#</b> upload<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" displayname="File Upload - #Files.FileTitle# Rev #NewRev#"><br><br>
</cfoutput>

Comments - Please document the current file revision - <font color="Red">REQUIRED</font><br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Comments" displayname="Comments - Please document the current file revision"></textarea>
<br><br>

<INPUT TYPE="button" value="Upload New Revision" onClick="javascript:checkFormValues(document.all('Audit'));"> 
</cfform>

<u>Revision History</u><br>
<cfoutput query="files">
Revision - #Rev#<br>
Revision Date - #dateformat(uploaded, "mm/dd/yyyy")#<br>
<cfif Rev is NOT Files2.MaxRev>
File - <a href="#CARRootDir#CARTraining\CT#DocNumber#Rev#Rev#.#FileType#">View</a><br>
<cfelse>
	<cfif FileType is "DC">
		File - <a href="#DCLink#">View</a><br>
	<cfelse>
		File - <a href="#CARRootDir#CARTraining\CT#DocNumber#Current.#FileType#">View</a><br>
	</cfif>
</cfif>
<cfset Dump = #replace(Comments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
Comments - #Dump2#
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->