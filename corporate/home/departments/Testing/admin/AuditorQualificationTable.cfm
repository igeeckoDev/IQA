<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Aprofiles.cfm?View=All'>Auditor List</a> - Corporate IQA Auditor Training Table">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="Corporate">
SELECT ID, Auditor, Status
From AuditorList
WHERE IQA = 'Yes'
AND (Status = 'Active' OR Status = 'In Training')

<!---
AND (Auditor <> 'Jennifer E Murrill' AND Auditor <> 'Michelle S. Lee'
AND Auditor <> 'Linda Ziemnick' AND Auditor <> 'James Kurtz')
--->

ORDER BY Status, LastName
</CFQUERY>

<CFQUERY Name="Qualification" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, QualificationName
From Qualification
WHERE Status IS NULL
ORDER BY ID
</CFQUERY>

<cfset arrQuals = arrayNew(2)>

<cfset i = 1>
<cfloop query="Qualification">
	<cfset arrQuals[i] = arrayNew(1)>
    <cfset setID = arrayAppend(arrQuals[i],"#ID#")>
    <cfset setQual = arrayAppend(arrQuals[i],"#QualificationName#")>
<cfset i = i + 1>
</cfloop><br />

<Table border="1">
<tr>
	<th align="center" colspan=2>Auditor Name</th>
	<cfoutput>
    	<cfloop index="i" from="1" to="#ArrayLen(arrQuals)#">
    		<th align="center">#arrQuals[i][2]#</th>
    	</cfloop>
    </cfoutput>
</tr>

<!--- <cfset submitColspan = 2 + (2*ArrayLen(arrQuals))> --->

<cfoutput query="Auditors">
<tr>
	<td>#Auditor#<br />
		<cfif Status NEQ "Active">(#Status#)</cfif>
    </td>
	<td align="center" width="15">
    	<a href="AuditorQualifications.cfm?ID=#ID#">
    		View
    	</a>
    </td>

        <CFQUERY Name="AuditorQuals" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT AuditorQualification.ID, AuditorQualification.aID, AuditorQualification.qID, AuditorQualification.qValue, AuditorQualification.qDate, Qualification.QualificationName
        FROM AuditorQualification, Qualification
        WHERE AuditorQualification.aID = #ID#
        AND AuditorQualification.qID = Qualification.ID
        ORDER BY AuditorQualification.qID
        </CFQUERY>

        <cfloop index="i" from="1" to="#ArrayLen(arrQuals)#">
        	<cfloop query="AuditorQuals">
            	<cfif qID eq i>
	                <td align="center"><cfif qValue eq 1>Yes <cfif len(qDate)>(#qDate#)</cfif><cfelse>No</cfif></td>
				</cfif>
            </cfloop>
		</cfloop>
</tr>
</cfoutput>
</Table><br><br>

<cfset i = 1>
<b>Current List of Qualifications</b><Br />
<cfloop query="Qualification">
	<cfoutput>
        #i#. #QualificationName#<br />
     </cfoutput>
<cfset i = i + 1>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->