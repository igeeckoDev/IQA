<CFQUERY BLOCKFACTOR="100" NAME="output" DataSource="Corporate">
SELECT * FROM CAR_ERROR
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Error Reporting">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFOUTPUT query="output">
<b>Error Number:</b> #ID#<br>
<b>Date/Time:</b> #Logged#<br>
<b>Sent By:</b> #Name# (#Email#)<br>
<b>Referring URL:</b> #URL#<br><br>

<b>Details:</b> #Details#<br><br>

<b><u>Status</u></b>
<cfif Response is "">
No CA/PA entered.
<cfelseif Response is "Entered">
CA/PA entered, not sent.<br>
<a href="error_send.cfm?id=#id#"><b>Send</b></a> error report to IQA Mailbox and #Name#.
<cfelseif Response is "Sent">
Report Sent to #Name#.<br>
#Dateformat(ResponseDate, "mm/dd/yyyy")# #TimeFormat(ResponseDate, "hh:MM ttt")#
</cfif><br><br>

<cfif response is "Sent">
<b>Issue</b><br>
#Issue#<br><br>

<b>Corrective Action (included in email)</b><br>
#CAShort#<br><br>

<b>Corrective Action (long)</b><br>
#CALong#<br><br>

<b>Preventive Action (included in email)</b><br>
#PAShort#<br><br>

<b>Preventive Action (long)</b><br>
#PALong#<br><br>

<cfelse>

<FORM ACTION="error_capa.cfm?id=#id#" METHOD="POST" name="Audit">
<b>Issue</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="e_Issue" Value="" displayname="Description of Issue"><cfset S1 = #ReplaceNoCase(Issue, "<br>", chr(13), "ALL")#>#S1#</textarea><br><br>

<b>Corrective Action (email)</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="e_CAShort" Value="" displayname="Corrective Action (short)"><cfset S2 = #ReplaceNoCase(CAShort, "<br>", chr(13), "ALL")#>#S2#</textarea><br><br>

<b>Corrective Action (long)</b><br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="e_CALong" Value="" displayname="Corrective Action (long)"><cfset S3 = #ReplaceNoCase(CALong, "<br>", chr(13), "ALL")#>#S3#</textarea><br><br>

<b>Preventive Action (email)</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="e_PAShort" Value="" displayname="Preventive Action (short)"><cfset S4 = #ReplaceNoCase(PAShort, "<br>", chr(13), "ALL")#>#S4#</textarea><br><br>

<b>Preventive Action (long)</b><br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="e_PALong" Value="" displayname="Preventive Action (long)"><cfset S5 = #ReplaceNoCase(PALong, "<br>", chr(13), "ALL")#>#S5#</textarea><br><br>

<INPUT TYPE="button" value="Submit/Update Responses" onClick="javascript:checkFormValues(document.all('Audit'));">
</FORM>
</cfif>

</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->