<cfquery Datasource="Corporate" name="qEmailQualityList">
SELECT Name, Email, Region, SubRegion, ID
From IQADB_LOGIN
WHERE AccessLevel = 'RQM'
AND Status IS NULL
ORDER BY Region, SubRegion
</cfquery>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "James.E.Feth@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Walter.E.Ballek@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Rodney.E.Morton@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Harish.Patel@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Michael.Schneider@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "John.Carlin@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Dale.C.Hendricks@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "JanBehrendt.Ibsoe@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Hiromi.Yamaoka@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Erica.Qin@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Kila.Yang@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Vinutha.mu@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Siddharth.S@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Balina.Ling@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Joey.Cheng@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Keith.A.Mowry@ul.com")>

<cfset temp = QueryAddRow(qEmailQualityList)>
<cfset Temp = QuerySetCell(qEmailQualityList, "Email", "Rick.A.Titus@ul.com")>
		
<cfset i = 1>
Recipients:<br />
<cfoutput query="qEmailQualityList">
<cfif len(Email)>
#i# #Email#<br>

<!---
<cfmail
	to="#Email#"
	from="global.internalquality@ul.com"
    failto="Christopher.J.Nicastro@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    subject="2017 Audit Planning - Internal Quality Audits"
    type="html">
Quality Staff:<br><br>

Preparation for 2017 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for the 2017 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for UL Sites, Programs/Schemes, Certification Bodies, and Processes:<br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=Quality">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/getEmpNo.cfm?UserID=Quality</a><br><br>

<u>Note</u> - You can reuse the link above to add information for multiple Sites, Processes, Programs/Schemes, and Certification Bodies.<br><br>

If you have additional audit requests specific to Certification Bodies, Certification Schemes, accredited testing laboratories, or calibration laboratories, please include this information in the survey responses.<br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

To view the distribution lists, please use the following link:<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Quality">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/Distribution_2017.cfm?Type=Quality</a><br /><br />

You can add information for any of the categories listed in the link above by using the "Open Blank Survey" links. This includes Processes, Programs, as well as any UL location.<br><br>

Please respond by <b>December 23, 2016</b>.<br><br>

Please contact me if you have any questions, comments, or requests not covered in the above survey.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Email: global.internalquality@ul.com
</cfmail>
--->

<cfset i = i+1>
</cfif>
</cfoutput>