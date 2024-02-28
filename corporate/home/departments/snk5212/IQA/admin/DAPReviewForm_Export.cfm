<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form - Export All Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
    DAPReviewForm_Users.ID,
	DAPReviewForm_Users.AuditorName,
    DAPReviewForm_Users.Posted,
    DAPReviewForm_Users.PostedBy,
	DAPReviewForm_Users.AuditorEmail,
    DAPReviewForm_Users.AuditorManagerEmail,
    DAPReviewForm_Users.ReviewerName,
	DAPReviewForm_Users.DAFileNumber,
	DAPReviewForm_Users.ProjectNumber,
	DAPReviewForm_Users.ProgramAudited,
	DAPReviewForm_Users.AuditType,
	DAPReviewForm_Users.RequiresReview,
	DAPReviewForm_Users.RequiresReviewComments,
	DAPReviewForm_Users.ResultsSent,
	DAPReviewForm_Users.ResultsSentDate,
	DAPReviewForm_Users.RequiresReview_Completed,
	DAPReviewForm_Users.RequiresReview_CompletedDate,
	DAPReviewForm_Users.RequiresReview_CompletedName

FROM DAPReviewForm_Users

WHERE ID <> 1

ORDER BY ID
</CFQUERY>

<!--- create file and row labels --->
<cfoutput>
<!--- Create the file name --->
<cfset filename="DAPReviewForm_#dateformat(now(), "yyyyMMMdd")#_#timeformat(now(), "hhmmsstt")#">

<!--- Write to the file --->
<cffile action="WRITE" file="d:\webserver\corporate\home\departments\snk5212\IQA\xls\DAPReviewForm\#filename#.cfm" output="
<cfcontent type='application/vnd.ms-excel'>
<table border='1'>
<tr align='center' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
	<th>Form Row ID</th>
	<th>Lead Auditor Name</th>
	<th>Lead Auditor Email</th>
	<th>Lead Auditor's Manager Email</th>
	<th>Reviewer Name</th>
	<th>Reviewer Email</th>
	<th>Date Posted</th>
	<th>DA File Number</th>
	<th>Project Number</th>
	<th>Program Audited</th>
	<th>Assessment Type</th>
	<th>Requires Review</th>
	<th>Review Status</th>
	<th>ROverall Status</th>
	<th>Review Comments</th>
	<th>Review Comments Date, Name</th>
</tr> " addnewline="Yes">
</cfoutput>

<!--- append the dynamic data to the file --->
<cfoutput query="Output">
<cffile action="APPEND" file="d:\webserver\corporate\home\departments\snk5212\IQA\xls\DAPReviewForm\#filename#.cfm" output="
<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td>#ID#</td>
	<td>#AuditorName#</td>
	<td>#AuditorEmail#</td>
	<td>#AuditorManagerEmail#</td>
	<td>#ReviewerName#</td>
	<td>#PostedBy#</td>
	<td>#dateformat(Posted, 'mm/dd/yyyy')#</td>
	<td>#DAFileNumber#</td>
	<td>#ProjectNumber#</td>
	<td>#ProgramAudited#</td>
	<td>#AuditType#</td>
	<td>
	<Cfif RequiresReview eq 'Yes'>
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td>
		<cfif RequiresReview eq 'Yes'>
			<cfif ResultsSent eq 'Yes'>
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td>
		<cfif ResultsSent eq 'Yes'>
			Results Sent (#dateformat(ResultsSentDate, 'mm/dd/yyyy')#)
		<cfelse>
			--
		</cfif>
	</td>
	<td><cfif Len(RequiresReviewComments)>#RequiresReviewComments#<cfelse>--</cfif></td>
	<td><cfif Len(RequiresReview_CompletedDate)>#dateformat(RequiresReview_CompletedDate, 'mm/dd/yyyy')#, by #RequiresReview_CompletedName#<cfelse>--</cfif></td>
</tr> " addnewline="yes">
</cfoutput>

<!--- end your table in the file --->
<cfoutput>
<cffile action="Append" file="d:\webserver\corporate\home\departments\IQA\xls\DAPReviewForm\#filename#.cfm" output="
</table> " addnewline="Yes">

#filename#.xls has been generated<br>
<a href="xls\DAPReviewForm\#filename#.cfm" target="_blank"><img align="absmiddle" src="#SiteDir#SiteImages/table_column_add.png" border="0" alt="View File" /></a> - <a href="xls\DAPReviewForm\#filename#.cfm" target="_blank">View File</a><br><br>

NOTE: It may take 5-10 seconds to open the file in Excel.<br><br>

<u>Instructions to Save File</u><br>
1. Please save the excel spreadsheet in order to manipulate the data in any way.<br>
2. Select File->Save As-><br>
3. Type in a name for the file.<br>
4. Select 'Microsoft Excel Workbook' from 'Save as Type' drop down box.<br>
</cfoutput>

<!---
<Table border=1>
<tr>
	<th>Form Row ID</th>
	<th>Lead Auditor Name</th>
	<th>Lead Auditor Email</th>
	<th>Lead Auditor's Manager Email</th>
	<th>Reviewer Name</th>
	<th>Reviewer Email</th>
	<th>Date Posted</th>
	<th>DA File Number</th>
	<th>Project Number</th>
	<th>Program Audited</th>
	<th>Assessment Type</th>
	<th>Requires Review</th>
	<th>Review Status</th>
	<th>ROverall Status</th>
	<th>Review Comments</th>
	<th>Review Comments Date, Name</th>
	<cfloop index=i from=1 to=9>
		<cfoutput>
			<th>Question #i#</th>
			<th>Answer #i#</th>
		</cfoutput>
	</cfloop>
</tr>
<cfoutput query="Output">
<tr>
	<td>#ID#</td>
	<td>#AuditorName#</td>
	<td>#AuditorEmail#</td>
	<td>#AuditorManagerEmail#</td>
	<td>#ReviewerName#</td>
	<td>#PostedBy#</td>
	<td>#dateformat(Posted, "mm/dd/yyyy")#</td>
	<td>#DAFileNumber#</td>
	<td>#ProjectNumber#</td>
	<td>#ProgramAudited#</td>
	<td>#AuditType#</td>
	<td>
	<Cfif RequiresReview eq "Yes">
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td>
		<cfif RequiresReview eq "Yes">
			<cfif ResultsSent eq "Yes">
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td>
		<cfif ResultsSent eq "Yes">
			Results Sent (#dateformat(ResultsSentDate, "mm/dd/yyyy")#)
		<cfelse>
			--
		</cfif>
	</td>
	<td><cfif Len(RequiresReviewComments)>#RequiresReviewComments#<cfelse>--</cfif></td>
	<td><cfif Len(RequiresReview_CompletedDate)>#dateformat(RequiresReview_CompletedDate, "mm/dd/yyyy")#, by #RequiresReview_CompletedName#<cfelse>--</cfif></td>
	<cfloop index=i from=1 to=9>
		<CFQUERY Name="AnswerOutput" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT
		    DAPReviewForm_Answers.Answer,
		    DAPReviewForm_Answers.Notes
		FROM
			DAPReviewForm_Answers
		WHERE
			USERID = #ID#
			AND qID = #i#
		</cfquery>

		<td>#AnswerOutput.Answer#</td>
		<td>#AnswerOutput.Notes#</td>
	</cfloop>
</tr>
</cfoutput>
</table>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->