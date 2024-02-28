<!--- Start of Page File --->
<cfset subTitle = "Quality Engineering Knowledge Base">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- /// --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBTopics"> 
SELECT KBTopics 
FROM KBTopics
ORDER BY KBTopics
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
	
<cfinclude template="KBMenu.cfm">				  
						  
<br><br>						  

<b>Knowledge Base - Add new Article</b>
<br><br>						  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" action="AddKBItem_update.cfm">

Choose Main Topic:<br>
<SELECT NAME="e_KBTopics" displayname="Main Topic">
		<OPTION VALUE="">Select Main Topic Below
			<OPTION VALUE="">---
<CFOUTPUT QUERY="KBTopics">
		<OPTION VALUE="#KBTopics#">#KBTopics#
</CFOUTPUT>
</SELECT>
<br><br>

Author:<br>
<input name="e_Author" type="text" value=""><br><br>

Added to KB By:<br>
<cflock scope="SESSION" timeout="60">
<cfoutput>
#SESSION.AUTH.Name#
<input name="Added" type="hidden" value="#SESSION.AUTH.Name#">
</cfoutput>
</cflock>
<br><br>

Date Posted: (mm/dd/yyyy)<br>
<input name="e_Posted" type="Text" size="30" value="" displayname="Date Posted" onchange="return Validate_e_Posted()">
<br><br>

Subject:<br>
<input name="e_Subject" type="Text" size="70" value="" displayname="Subject">
<br><br>

CAR Training Related?<br>
Yes <input type="radio" name="CAR" value="1"> 
No <input type="radio" name="CAR" value="0" checked>
<br><br>

Details:<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="e_Details" displayname="Details" Value=""></textarea>
<br><br>

Attach a File: (Optional)<br>
File Types Allowed: zip, xls, ppt, doc, pdf<br>
<input name="File" type="File" size="50" onchange="return checkfile();">
<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->