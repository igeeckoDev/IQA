<CFQUERY Name="Auditor" Datasource="Corporate">
SELECT ID, Auditor
From AuditorList
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditorQualificationTable.cfm'>Corporate IQA Auditor Training</a> - <a href='AuditorQualificationTable.cfm'>Corporate IQA Auditor Training Table</a> - #Auditor.Auditor# Qualifications">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="qEdit" Datasource="Corporate">
SELECT ID, Auditor as EditItem
From AuditorList
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY Name="qList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, QualificationName as qListItem
From Qualification
ORDER BY ID
</CFQUERY>

<cfset heading = "Subject">
<cfset field = "Qualification">


<cfoutput>
<u>Auditor Name</u>: #qEdit.EditItem#<Br><Br>

<Table border="1" width="650"
<tr>
	<th>#heading#</th>
    <th>Training Taken Yes/No</th>
	<th>Date Taken</th>
    <th width="200">Notes</th>
</tr>
</cfoutput>

<cfoutput query="qList">
<tr>
	<td>#qListItem#</td>
    <td align="center">
    	<CFQUERY Name="Quals" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT AuditorQualification.ID, AuditorQualification.aID, AuditorQualification.qID,
        AuditorQualification.qValue, AuditorQualification.qDate, Qualification.QualificationName,
        AuditorQualification.Notes, AuditorQualification.qHistory

        FROM AuditorQualification, Qualification
        WHERE
        AuditorQualification.aID = #qEdit.ID#
        AND Qualification.ID = #ID#
        <cfset value = "#ID#">
        AND AuditorQualification.qID = Qualification.ID
        ORDER BY AuditorQualification.qID
        </CFQUERY>

        <cfif Quals.qValue eq 1>
        	Yes
        <cfelse>
        	No
        </cfif>
    </td>
	<td>
		<cfif len(Quals.qDate)>
        	#Quals.qDate#
        <cfelse>
			--
		</cfif>
	</td>
    <td>
	    <cfif len(Quals.Notes)>#Quals.Notes#<cfelse>&nbsp;</cfif>
    </td>
</tr>
</cfoutput>
</Table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->