<cfif isDefined("URL.CategoryID")>
	<cfif URL.CategoryID eq 14>
		<cfset subTitleNew = "Auditor In Training Records - File Upload">
	<cfelseif URL.CategoryID eq 19>
		<cfset subTitleNew = "<a href=DAPLeadAuditorOversightRecords.cfm>DAP Lead Auditor Oversight Records</a> - File Upload">
	<cfelse>
		<cfset subTitleNew = "Quality Engineering Related Files - File Upload">
	</cfif>
<cfelse>
	<cfset subTitleNew = "Quality Engineering Related Files - File Upload">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - #subTitleNew#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfif isDefined("Form.Submit")>

<CFQUERY DataSource="Corporate" Name="Check">
SELECT ID, FileLabel
FROM CARFiles
WHERE FileLabel = '#Form.FileTitle#'
</cfquery>

<cfif Check.recordCount GT 0>
	<cflocation url="CARFilesNewFile.cfm?#CGI.Query_String#&msg=Duplicate Name&msgValue=#Form.FileTitle#" addtoken="no">
<cfelse>
	<!--- max ID for new record during file upload --->
	<CFQUERY DataSource="Corporate" Name="MaxID">
	SELECT MAX(ID)+1 as MaxID FROM CARFiles
	</CFQUERY>

	<CFQUERY DataSource="Corporate" Name="NewDocNumber">
	SELECT MAX(DocNumber)+1 as NewDocNumber FROM CARFiles
	</CFQUERY>

	<CFFILE ACTION="UPLOAD"
	FILEFIELD="AttachA"
	DESTINATION="#request.applicationFolder#\corporate\home\departments\snk5212\QE\QEFiles\"
	NAMECONFLICT="OVERWRITE">

	<cfset FileName="#Form.AttachA#">

	<cfset NewFileName="Doc#NewDocNumber.NewDocNumber#Current.#cffile.ClientFileExt#">

	<cffile
	    action="rename"
	    source="#FileName#"
	    destination="#request.applicationFolder#\corporate\home\departments\snk5212\QE\QEFiles\#NewFileName#">

	<cflock scope="Session" timeout="6">
	    <CFQUERY DataSource="Corporate" Name="FileSettingsAdd">
	    INSERT INTO CARFiles(ID, CategoryID, DocNumber, RevNo, FileType, FileLabel, RevHistory, RevAuthor, RevDate)
	    VALUES (#maxID.MAXID#, #Form.CategoryID#, #NewDocNumber.NewDocNumber#, 1, '#cffile.ClientFileExt#', '#Form.FileTitle#', '#Form.RevHistory#', '#SESSION.Auth.Name#', #CreateODBCDate(curdate)#)
	    </cfquery>
	</cflock>

	<cfoutput>
	<cfif Form.CategoryID eq 14>
		<cfmail to="Mark.D.Jessen@ul.com" bcc="Kai.Huang@ul.com" From="do_not_reply_IQA@ul.com" subject="Auditor In Training Form Updated">
			AIT Form named "#Form.FileTitle#" has been uploaded to the IQA Site by #SESSION.Auth.Name#.
		</cfmail>
	</cfif>

		<!--- IQA Audit Plans require more info --->
		<cfif Form.CategoryID eq 3>
	        <cflocation url="CARFilesNewFile2.cfm?CategoryID=#Form.CategoryID#&DocNumber=#NewDocNumber.NewDocNumber#&Rev=1&DocName=#Form.FileTitle#" addtoken="No">
	    <cfelse>
	        <cfif Form.CategoryID eq 14>
				<cflocation url="AuditorInTrainingRecords.cfm?CategoryID=#Form.CategoryID#&uploaded=Yes&DocNumber=#NewDocNumber.NewDocNumber#&Rev=1&DocName=#Form.FileTitle#" addtoken="No">
			<cfelseif Form.CategoryID eq 19>
				<cflocation url="DAPLeadAuditorOversightRecords.cfm?CategoryID=#Form.CategoryID#&uploaded=Yes&DocNumber=#NewDocNumber.NewDocNumber#&Rev=1&DocName=#Form.FileTitle#" addtoken="No">
			<cfelse>
				<cflocation url="ViewFiles.cfm?CategoryID=#Form.CategoryID#&uploaded=Yes&DocNumber=#NewDocNumber.NewDocNumber#&Rev=1&DocName=#Form.FileTitle#" addtoken="No">
	    	</cfif>
		</cfif>
	</cfoutput>
</cfif>

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<cfoutput>
	<cfif isDefined("url.msg")>
		<b>Validation Error</b>: <font class="warning">Duplicate File Name</font><br><br>
		File Title <b>#url.msgValue#</b> already exists.<br>
		Please ensure the "File Label" value is unique.<br><br>

		<hr width="75%" align="left"><br><Br>
	</cfif>
</cfoutput>

<CFQUERY DataSource="Corporate" Name="Categories">
SELECT * FROM CARFilesCategory
WHERE CategoryID > 0
ORDER BY CategoryName
</cfquery>

<CFQUERY DataSource="Corporate" Name="NewDocNumber">
SELECT MAX(DocNumber)+1 as NewDocNumber FROM CARFiles
</CFQUERY>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" id="myform" name="myform" ACTION="#CGI.SCRIPT_NAME#?CategoryID=#URL.CategoryID#">

File Label<br>
<cfinput name="FileTitle" size="75" type="text" required="Yes" message="File Title/Name is Required"><br><br>

<cfif isDefined("URL.CategoryID")>
	<cfif URL.CategoryID eq 14>
		<cfinput name="CategoryID" value="14" type="hidden">
	<cfelseif URL.CategoryID eq 19>
		<cfinput name="CategoryID" value="19" type="hidden">
	<cfelse>

	Category<br />
	    <cfselect
	        name="CategoryID"
	        multiple="No"
	        query="Categories"
	        required="Yes"
	        message="Category is Required"
	        display="CategoryName"
	        value="CategoryID"
	        class="blog-content_dropdown" selected="#URL.CategoryID#">
	    </cfselect><br><br>
	</cfif>
</cfif>

<cfoutput>
New File Upload (Doc ID #NewDocNumber.NewDocNumber#, Rev 1)<br>
<cfINPUT NAME="AttachA" SIZE=50 TYPE="FILE" required="yes" message="File to Upload is Required"><br><br>
</cfoutput>

Revision History - <font color="Red">REQUIRED</font><br>
<textarea wrap="physical" name="RevHistory" rows="8" cols="60">Please document the current file revision</textarea>
<br><br>

<input type="submit" name="Submit" value="Submit Form">
<input type="reset" value="Reset Form"><br /><br />

</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->