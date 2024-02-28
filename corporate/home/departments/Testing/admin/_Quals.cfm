<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Aprofiles.cfm'>Auditor List</a> - Corporate IQA Auditor Training Table">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Qualification" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID as QualificationID, QualificationName
From Qualification
WHERE Status IS NULL
ORDER BY ID
</CFQUERY>

<b>Current List of Qualifications</b> <a href="_Quals_Manage.cfm">[Manage]</a><Br />
<cfloop query="Qualification">
	<cfoutput>
        #QualificationName#<br />
     </cfoutput>
</cfloop><br><br>

<CFQUERY Name="Auditors" Datasource="Corporate">
SELECT ID, Auditor, Status
From AuditorList
WHERE IQA = 'Yes'
AND (Status = 'Active' OR Status = 'In Training' OR Status = 'Inactive')
AND Auditor <> 'James Kurtz'
AND Auditor <> 'John Carlin'

ORDER BY Status, LastName
</CFQUERY>

<Table border="1" style="border-collapse: collapse;">
<tr>
	<td align="center" bgcolor="CCCCCC" colspan="2">Auditor Name</td>
	<cfoutput>
    	<cfloop query="Qualification">
    		<td bgcolor="CCCCCC" align="center">#QualificationName#<br><br>
				<a href="_Quals_View.cfm?ID=#QualificationID#&Action=Qualification">
		           	View
	            </a>
			</td>
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
    	<a href="_Quals_View.cfm?ID=#ID#&Action=Auditor">
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

		<cfset valueSet = "No">

        <cfloop query="Qualification">
        	<td align="center">
				<cfloop query="AuditorQuals">
	            	<cfif qID eq Qualification.QualificationID>
		                <cfif qValue eq 1>Yes (#qDate#)<cfelse>No</cfif>
		                <cfset valueSet = "Yes">
					</cfif>
	            </cfloop>
		        <cfif valueSet eq "No">
		        	No
		        </cfif>
			</td>
		</cfloop>
</tr>
</cfoutput>
</Table><br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->