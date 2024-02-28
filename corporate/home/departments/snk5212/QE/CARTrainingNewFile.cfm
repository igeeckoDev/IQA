<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Training Files">
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

<CFQUERY DataSource="Corporate" Name="NewDocNumber"> 
SELECT MAX(DocNumber)+1 as NewDocNumber FROM CARTraining
</CFQUERY>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#request.applicationFolder#\corporate\home\departments\snk5212\QE\CARTraining\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="CT#NewDocNumber.NewDocNumber#Current.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#request.applicationFolder#\corporate\home\departments\snk5212\QE\CARTraining\#NewFileName#">
	
<CFQUERY DataSource="Corporate" Name="FileSettingsAdd"> 
INSERT INTO CARTraining(ID,DocNumber,Rev)
VALUES (#maxID.MAXID#,#NewDocNumber.NewDocNumber#,1)
</cfquery>	
	
<CFQUERY DataSource="Corporate" Name="FileSettings"> 
UPDATE CARTraining
SET
FileTitle='#Form.e_FileTitle#',
FileType='#cffile.ClientFileExt#',
Uploaded=#CreateODBCDate(curdate)#,
Comments='#Form.Comments#'

WHERE ID = #MaxID.MaxID#
</cfquery>

<cflocation url="CARTrainingFiles.cfm" addtoken="No">

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#">

File Name<br>
<input name="e_FileTitle" size="75" type="text" displayname="Training File Name"><br><br>

<cfoutput>
New File Upload<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" displayname="Training File"><br><br>
</cfoutput>

Comments - Please document the current file revision - <font color="Red">REQUIRED</font><br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Comments" displayname="Comments - Please document the current file revision"></textarea>
<br><br>

<INPUT TYPE="button" value="Upload New Revision" onClick="javascript:checkFormValues(document.all('Audit'));"> 

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->