<!--- Start of Page File --->
<cfset subTitle = "#Request.SiteTitle# - Send Email - Compose and Verify Email Addresses">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language=javascript>
	window.name = "doUpLoadProc";
</script>

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
// End -->
</script>

<cfif isDefined("Form.Submit")>

<!--- check SendTo Address --->	
	<cfset myArrayList = ListToArray(Form.SendTo)>
	
	<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#myArrayList[i]#'
	</CFQUERY>
	
	<b>To</b>: 
	<cfoutput>
	#myArrayList[i]# - 
	<cfif NameLookup.RecordCount eq 1>
		<u>Verified</u>
	<cfelseif NameLookup.RecordCount gt 1>
		<span class="warning">Multiple Emails Found</span> (#namelookup.recordcount#)
	<cfelse>
		<span class="warning">Email Not Found</span>
	</cfif>
	</cfoutput><br>
	</cfloop>
	
<cfif len(Form.SendCC)>	
<!--- Check SendCC Addresses --->
	<cfset myArrayList = ListToArray(Form.SendCC)>
	
	<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_email = '#myArrayList[i]#'
	</CFQUERY>

	<b>CC</b>: 
	<cfoutput>
	#myArrayList[i]# - 
	<cfif NameLookup.RecordCount eq 1>
		<u>Verified</u>
	<cfelseif NameLookup.RecordCount gt 1>
		<span class="warning">Multiple Emails Found</span> (#namelookup.recordcount#)
	<cfelse>
		<span class="warning">Email Not Found</span>
	</cfif>
	</cfoutput><br>
	</cfloop>
</cfif>

<cfoutput>
<b>Date Sent</b> - #dateformat(Form.SendDate, "mm/dd/yyyy")#<br />
<b>From</b> (BCC) - 
    <cflock scope="SESSION" timeout="5">
    #SESSION.Auth.Email#
    <cfset Author = "#SESSION.Auth.Email#">
    </cflock><br />
<b>Subject</b> - #Form.Subject#<br /><br />

<b>Message Text</b><br />
<cfset Dump = #replace(Form.EmailBody, "<p>", "", "All")#>
#replace(Dump, "</p>", "<br /><br />", "All")#

    <cfform name="SendEmail" action="SendEmail_Submit.cfm" method="post">
    <input type="hidden" name="SendDate" value="#Form.SendDate#" />
    <input type="hidden" name="SendTo" value="#Form.SendTo#" />
    <input type="hidden" name="SendCC" value="#Form.SendCC#" />
    <input type="hidden" name="Subject" value="#Form.Subject#" />
    <input type="hidden" name="Author" value="#Author#" />
    <input type="hidden" name="EmailBody" value="#Form.EmailBody#" />
    
    <b>Attachments</b><br />
    <input type="file" name="FileAttach" size="35" /><br /><br />
    
    <input type="submit" name="Edit" Value="Edit Contents" /> <input type="submit" name="Send" value="Send Email" />
    </cfform>
</cfoutput>

<cfelse>

<cfform name="SendEmail" action="SendEmail.cfm" method="post">

<b>Date Sent</b><br />
<cfinput type="datefield" name="SendDate" value="#dateformat(curdate, "mm/dd/yyyy")#" required="yes" size="25">
<br /><br />

<cfif isDefined("Form.SendTo")>
	<cfset SendToValue = "#Form.SendTo#">
<cfelse>
	<cfset SendToValue = "">
</cfif>

<B>To</B>:<br>
<cfinput type="text" name="SendTo" value="#SendToValue#" message="Required Field - To: (UL External Email Address Only)" required="Yes" size="75"><br>
<span class="warning">External UL Email Addresses Only</span><br>
<a href="javascript:popUp('EmailLookup.cfm?ID=To')">Lookup</a> Email Addresses<br><br>

<cfif isDefined("Form.SendCC")>
	<cfset SendCCValue = "#Form.SendCC#">
<cfelse>
	<cfset SendCCValue = "">
</cfif>

<B>CC</B>:<br>
<cfinput type="text" name="SendCC" value="#SendCCValue#" message="Required Field - CC: (UL External Email Address Only)" required="yes" size="75"><br>
<span class="warning">External UL Email Addresses Only</span><br>
<a href="javascript:popUp('EmailLookup.cfm?ID=CC')">Lookup</a> Email Addresses<br><br>
	
<B>Subject</B>:<br>
<cfinput type="text" name="Subject" value="" message="Required Field - Subject" required="Yes" size="75"><br><br>

<!---
<b>Reference</b>:<br />
<cfinput type="text" name="Reference" value="" message="Required Field - Reference" required="yes" size="75"><br /><br />
--->

<b>Text Box Use</b><br />
<u>Text Only</u> - no screenshots or images. Use formatting buttons included in text box.<br />
<u>Preferred method of use</u> - either type into this text box and format as you go OR copy/paste contents from notepad. If your source is in Notes/Word/Etc, copy/paste into notepad, then into this text box.<br />
<u>Figures and complex tables</u> - included as file attachments, not as text.<Br />
<u>Spacing</u> - Control+Enter for single space/carriage return, Enter for new paragraph.<Br /><br />
  
<b>Email Text</B>:<br>
<cftextarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="EmailBody" required="yes" message="Required Field - Email Text"></cftextarea><br><br>

<b>Attachments</b>:<br />
Can be attached after addresses are validated. (Next Page)<br /><br />
	
<input type="submit" name="Submit" value="Submit">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->