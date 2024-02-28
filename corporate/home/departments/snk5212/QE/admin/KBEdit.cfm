<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Quality Engineering Knowledge Base - Edit Article">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KB"> 
SELECT * FROM KB
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBTopics"> 
SELECT * FROM KBTopics
ORDER BY KBTopics
</CFQUERY>

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
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<CFOUTPUT QUERY="KB">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" action="kbedit_update.cfm?ID=#ID#" onSubmit="return validateForm();">

Choose Main Topic:<br>
<SELECT NAME="KBTopics">
		<OPTION VALUE="#KBTopics#">#KBTopics#
</SELECT>
<br><br>

Author:<br>
#Author#
<input name="e_Author" type="hidden" value="#Author#" displayname="Author">
<br><br>

Added By:<br>
#Added#
<input name="Added" type="hidden" value="#Added#" displayname="KB Article added by">
<br><br>

Posted:<br>
<input name="e_Posted" type="Text" size="30" value="#Posted#" onchange="return Validate_e_Posted()">
<br><br>

Subject:<br>
<input name="e_Subject" type="Text" size="70" value="#Subject#" displayname="KB Subject">
<br><br>

<cfset selValue=#KB.CAR#>
CAR Process/Database Related?<br>
Yes <input type="radio" name="CAR" value="Yes" checked="#iif(selValue eq "Yes", de("true"), de("false"))#">
No <input type="radio" name="CAR" value="No" checked="#iif(selValue eq "No", de("true"), de("false"))#"><br><br>

Details:<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Details" Value="">#Details#</textarea>
<br><br>

Attach a File:<br>
<input name="File" type="File" size="50">
<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</form>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->