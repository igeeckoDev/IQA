<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">
<!--- /// --->

<cfquery name="qData" datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfoutput>
<!--- Create the file name --->
<cfset filename="Accreditations_#dateformat(now(), "yyyyMMMdd")#_#timeformat(now(), "hhmmsstt")#">

<!--- Write to the file --->
<cffile action="WRITE" file="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\admin\AccredLocations\xls\#filename#.cfm" output="
<cfcontent type='application/vnd.ms-excel'>
<table border='1'>
<tr align='center' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'> 
<td><b>Accreditor Name</b></td>
<td><b>Office Name</b></td>
<td><b>Type of Accreditation</b></td>
<td><b>Detailed Type of Accreditation</b></td>
<td><b>Status</b></td>
<td><b>Scope</b></td>
<td><b>Local Audit Conducted?</b></td>
<td><b>Accreditor Audit Frequency (Years)</b></td>
<td><b>Accreditor Requirements?</b></td>
<td><b>Accreditor Requirements Notes</b></td>
<td><b>Additional Notes</b></td>
<td><b>Change History</b></td>
</tr> " addnewline="Yes">
</cfoutput>

<!--- append the dynamic data to the file ---> 

<cfoutput query="qData">

<cfset Dump = #replace(IQANotes, "<br /><br />", " || ",  "All")#>
<cfset Dump1 = #replace(Dump, "<br />", " | ", "All")#>

<cffile action="APPEND" file="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\admin\AccredLocations\xls\#filename#.cfm" output=" 
<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td>#Accreditor#</td>
<td>#OfficeName#</td>
<td>#AccredType#</td>
<td>#AccredType2#</td>
<td>#Status#</td>
<td nowrap>#AccredScope#</td>
<td>#LocalAudit#</td>
<td>#AuditFrequency#</td>
<td>#AdditionalRequirements#</td>
<td nowrap>#AdditionalRequirementsNotes#</td>
<td nowrap>#Notes#</td>
<td nowrap>#Dump1#</td>
</tr> " addnewline="yes">
</cfoutput>

<!--- end your table in the file --->
<cfoutput>
<cffile action="Append" file="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\admin\AccredLocations\xls\#filename#.cfm" output="
</table> " addnewline="Yes">

#filename#.xls has been generated<br>
<a href="xls\#filename#.cfm" target="_blank"><img src="#IQARootDir#images/ico_article.gif" border="0"> View File</a><br><br>

NOTE: It may take 5-10 seconds to open the file in Excel.<br><br>

<u>Instructions to Save File</u><br>
1. Please save the excel spreadsheet in order to manipulate the data in any way.<br>
2. Select File->Save As-><br>
3. Type in a name for the file.<br>
4. Select 'Microsoft Excel Workbook' from 'Save as Type' drop down box.<br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->