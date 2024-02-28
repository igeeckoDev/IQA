<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Error Reporting">
<cfinclude template="SOP.cfm">

<!--- / --->
						  
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<br><p>Please complete the form below with any errors found on the Audit Database site.<br>Each field is required, so we can contact you for further clarification if necessary.</p>

<FORM ACTION="email_submit.cfm" METHOD="POST" name="Audit">
<input type="hidden" name="emaillink" value="<cfoutput>#link#</cfoutput>">
						  
<table width="650" border="0" cellpadding="1" cellspacing="1" valign="top">
<tr align="center">
<TR>
<TD class="blog-title"><P>Your name</P></TD>
<TD><input type="Text" name="e_Name" size="30" class="textbox" displayname="Name"></TD></TR>
<TR>
<TD class="blog-title"><P>Your email</P></TD>
<TD><input type="Text" name="e_Email" size="30" class="textbox" displayname="Email"></TD></TR>
<TR>
<TD class="blog-title"><P>Please explain <br>the issue:</P></TD>
<TD><textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="e_input" Value="" displayname="Explanation of Error or Issue"></textarea>
</TD></TR>
</table>

<INPUT TYPE="button" value="Submit Error Report" onClick="javascript:checkFormValues(document.all('Audit'));">
</FORM>

<br>
<p><b>Referring URL:</b><br>
<a href="<cfoutput>#link#</cfoutput>"><cfoutput>#link#</cfoutput></p>
<br>						  					  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->