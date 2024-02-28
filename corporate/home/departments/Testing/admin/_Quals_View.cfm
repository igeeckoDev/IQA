<cfif URL.Action is "Qualification">
    <CFQUERY Name="qEdit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, QualificationName as EditItem
    From Qualification
    WHERE ID = #URL.ID#
    </CFQUERY>
<cfelseif URL.Action is "Auditor">
    <CFQUERY Name="qEdit" Datasource="Corporate">
    SELECT ID, Auditor as EditItem
    From AuditorList
    WHERE ID = #URL.ID#
    </CFQUERY>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Corporate IQA Auditor Qualifications - #qEdit.EditItem#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- Output Quals Table --->
<cfif URL.Action is "Qualification">
    <CFQUERY Name="qEdit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, QualificationName as EditItem
    From Qualification
    WHERE ID = #URL.ID#
    </CFQUERY>

	<CFQUERY Name="qList" Datasource="Corporate">
	SELECT ID, Auditor as qListItem
	From AuditorList
	WHERE IQA = 'Yes'
	AND (Status = 'Active' OR Status = 'In Training')
	AND Auditor <> 'James Kurtz'
	AND Auditor <> 'John Carlin'
	ORDER BY Status, LastName
	</CFQUERY>

    <cfset heading = "Auditor Name">
    <cfset field = "Auditor">
<cfelseif URL.Action is "Auditor">
    <CFQUERY Name="qEdit" Datasource="Corporate">
    SELECT ID, Auditor as EditItem
    From AuditorList
    WHERE ID = #URL.ID#
    </CFQUERY>

    <CFQUERY Name="qList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, QualificationName as qListItem
    From Qualification
	WHERE Status IS NULL
    ORDER BY ID
    </CFQUERY>

    <cfset heading = "Qualification Name">
    <cfset field = "Qualification">
</cfif>

<cfoutput>
<u>Options</u><br />
<!--- :: View <a href="_Quals.cfm">Auditor Qualifications Table</a><br />--->
:: Edit <a href="_Quals_Edit.cfm?#CGI.Query_String#">Auditor Qualifications</a><br />
:: View <a href="Aprofiles_detail.cfm?ID=#URL.ID#">Auditor Profile</a><br /><br />

<Table border="1">
<tr>
	<th align="center" colspan="4">Auditor: #qEdit.EditItem#</th>
</tr>
<tr>
	<th>#heading#</th>
    <th>Yes/No (Date)</th>
	<th>Notes</th>
	<!---
	<th>View Rev History</th>
	--->
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
        <cfif URL.Action is "Auditor">
            AuditorQualification.aID = #qEdit.ID#
            AND Qualification.ID = #ID#
            <cfset value = "#ID#">
        <cfelseif URL.Action is "Qualification">
            AuditorQualification.aID = #ID#
            AND Qualification.ID = #qEdit.ID#
            <cfset value = "#ID#">
        </cfif>
        AND AuditorQualification.qID = Qualification.ID
        ORDER BY AuditorQualification.qID
        </CFQUERY>

        <cfif Quals.qValue eq 1>
        	<strong>Yes</strong>
        <cfelse>
        	No
        </cfif>
        <cfif len(Quals.qDate)>
        	<br>#Quals.qDate#
        </cfif>
    </td>
	<td>
    	<cfif len(Quals.Notes)>#Quals.Notes#<cfelse>No Notes Added</cfif>
    </Td>
    <!---
	<td align="center">
    	<cfif len(Quals.ID)>
        	<a href="_Quals_ViewItemHistory.cfm?ID=#Quals.ID#">View</a>
        <cfelse>
        	--
        </cfif>
    </td>
	--->
</tr>
</cfoutput>
</Table>
<Br /><br />
<!--- /// --->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->