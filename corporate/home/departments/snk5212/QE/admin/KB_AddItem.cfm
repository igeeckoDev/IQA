<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Quality Engineering Knowledge Base - Add Article">
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

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBTopics"> 
SELECT KBTopics FROM KBTopics
WHERE KBTopics <> 'test'
ORDER BY KBTopics
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
			  
<cfif isDefined("Form.File")>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBID"> 
SELECT MAX(ID) + 1 AS newid FROM KB
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBIDAdd"> 
INSERT INTO KB(ID)
VALUES (#KBID.newid#)
</CFQUERY>

<cfif Form.File is "">

<cfelse>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#IQARootPath#KB\attachments\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#KBID.newid#.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#KB\attachments\#NewFileName#">

</cfif>	
	
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddKB"> 
UPDATE KB
SET 
<cfif Form.CAR is "Yes">
CAR='Yes',
<cfelseif Form.CAR is "No">
CAR='No',
</cfif>
Subject='#Form.Subject#',
Posted=#CreateODBCDate(Form.Posted)#,
Author='#Form.Author#',
Added='#form.added#',
<cfset D1 = #ReplaceNoCase(Form.Details,chr(13),"<br>", "ALL")#>
Details='#D1#',
<cfif Form.File is ""><cfelse>
File_='#NewFileName#',</cfif>
KBTopics='#Form.KBTopics#',
Status=null

WHERE ID=#KBID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE ID = #KBID.newid#
</CFQUERY>

<cfinclude template="KBEmailList.cfm">

<cfmail query="Show" to="#Emails#, #Emails2#" from="IQA.CAR.Knowledge.Base@ul.com" Mailerid="KBArticle" subject="New IQA/CAR Knowledge Base Article">
A new IQA/CAR Knowledge Base Article has been posted by #Added#.

Details:
"#Subject#" by #Author# listed under #KBTopics#.
 
Knowledge Base articles can be viewed on both the IQA and CAR Process Websites

#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/KB.cfm?ID=#KBID.newID#
</cfmail>

<cflocation url="#CARRootDir#KB.cfm?id=#KBID.newID#" addtoken="No">

<cfelse>
<cfform METHOD="POST" ENCTYPE="multipart/form-data" name="AddKB" action="#CGI.SCRIPT_NAME#">

Choose Category:<br>
<SELECT NAME="KBTopics" displayname="Main Topic">
		<OPTION VALUE="">Select Category
			<OPTION VALUE="">---
<CFOUTPUT QUERY="KBTopics">
		<OPTION VALUE="#KBTopics#">#KBTopics#
</CFOUTPUT>
</SELECT>
<br><br>

Author:<br>
<cfinput name="Author" type="text" value="" size="70" required="Yes" message="Author Name is Required"><br><br>

Added to KB By:<br>
<cflock scope="SESSION" timeout="60">
<cfoutput>
#SESSION.AUTH.Name#
<input name="Added" type="hidden" value="#SESSION.AUTH.Name#">
</cfoutput>
</cflock>
<br><br>

Date Posted: (mm/dd/yyyy)<br>
<cfoutput>
	<cfinput name="Posted" type="Text" size="30" value="#curdate#" required="Yes" message="Posted Date is Required" validate="date">
</cfoutput>
<br><br>

Subject:<br>
<cfinput name="Subject" type="Text" size="70" value="" required="yes" message="Subject is Required">
<br><br>

Details:<br>
<textarea name="Details" WRAP="PHYSICAL" ROWS="10" COLS="60">Please add Comments.</textarea>
<br><br>

Attach a File: (Optional)<br>
File Types Allowed: zip, xls, ppt, doc, pdf)<br>
<input name="File" type="File" size="50">
<br><br>

CAR Process/Database Related?<br>
Yes <input name="CAR" type="Radio" value="Yes"> 
No <input name="CAR" type="Radio" value="No" checked><br><br>

<input type="submit" value="submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->