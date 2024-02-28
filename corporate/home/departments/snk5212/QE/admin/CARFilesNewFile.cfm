<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Quality Engineering Related Files">
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

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfif isDefined("Form.RevHistory")>

<!--- max ID for new record during file upload --->
<CFQUERY DataSource="Corporate" Name="MaxID"> 
SELECT MAX(ID)+1 as MaxID FROM CARFiles
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="NewDocNumber"> 
SELECT MAX(DocNumber)+1 as NewDocNumber FROM CARFiles
</CFQUERY>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="AttachA" 
DESTINATION="d:\webserver\corporate\home\departments\snk5212\QE\QEFiles\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.AttachA#">

<cfset NewFileName="Doc#NewDocNumber.NewDocNumber#Current.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="d:\webserver\corporate\home\departments\snk5212\QE\QEFiles\#NewFileName#">
	
<cflock scope="Session" timeout="6">
    <CFQUERY DataSource="Corporate" Name="FileSettingsAdd"> 
    INSERT INTO CARFiles(ID,CategoryID,DocNumber,RevNo, FileType, FileLabel, RevHistory, RevAuthor, RevDate)
    VALUES (#maxID.MAXID#,#Form.CategoryID#,#NewDocNumber.NewDocNumber#, 1, '#cffile.ClientFileExt#', '#Form.FileTitle#', '#Form.RevHistory#', '#SESSION.Auth.Name#', #CreateODBCDate(curdate)#)
    </cfquery>
</cflock>

<cfoutput>
	<!--- IQA Audit Plans require more info --->
	<cfif Form.CategoryID eq 3>
        <cflocation url="CARFilesNewFile2.cfm?DocNumber=#NewDocNumber.NewDocNumber#&Rev=1" addtoken="No">
    <cfelse>
        <cflocation url="CARFiles.cfm?uploaded=Yes&DocNumber=#NewDocNumber.NewDocNumber#&Rev=1" addtoken="No">
    </cfif>
</cfoutput>

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<CFQUERY DataSource="Corporate" Name="Categories">
SELECT * FROM CARFilesCategory
WHERE CategoryID > 0
ORDER BY CategoryName
</cfquery>

<CFQUERY DataSource="Corporate" Name="NewDocNumber"> 
SELECT MAX(DocNumber)+1 as NewDocNumber FROM CARFiles
</CFQUERY>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#">

File Title/Name<br>
<cfinput name="FileTitle" size="75" type="text" required="Yes" message="File Title/Name is Required"><br><br>

Category<br />
    <cfselect 
        name="CategoryID" 
        multiple="No" 
        query="Categories" 
        required="Yes"
        message="Category is Required"
        display="CategoryName" 
        value="CategoryID" 
        class="blog-content_dropdown">
    </cfselect><br><br>

<cfoutput>
    New File Upload (Doc ID #NewDocNumber.NewDocNumber#, Rev 1)<br>
    <cfINPUT NAME="AttachA" SIZE=50 TYPE="FILE" required="yes" message="File to Upload is Required"><br><br>
</cfoutput>

Revision History - <font color="Red">REQUIRED</font><br>
<textarea wrap="physical" name="RevHistory" rows="8" cols="60">Please document the current file revision</textarea>
<br><br>

<INPUT TYPE="submit" name="Submit" value="Upload New File"> 

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->