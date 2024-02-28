<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Aprofiles.cfm'>Auditor List</a> - Corporate IQA Auditor Training Table">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="Corporate">
SELECT ID, Auditor, Status
From AuditorList
WHERE IQA = 'Yes'
AND (Status = 'Active' OR Status = 'In Training')
AND Auditor <> 'James Kurtz'
AND Auditor <> 'John Carlin'

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

<Table border="1" style="border-collapse: collapse;">
<tr>
	<td align="center" colspan=2 bgcolor="CCCCCC"></td>
	<cfoutput>
    	<cfloop index="i" from="1" to="#ArrayLen(arrQuals)#">
    		<td bgcolor="CCCCCC" align="center">
				<table border=0>
					<tr>
						<td align="center" bgcolor="CCCCCC">
							#arrQuals[i][2]#
						</td>
					</tr>
					<tr>
						<td align="center" bgcolor="CCCCCC">
							<a href="AuditorQualifications2.cfm?ID=#i#&Action=Qualification">View</a>
						</td>
					</tr>
				</table>
	   		</td>
		</cfloop>
    </cfoutput>
</tr>

<!--- <cfset submitColspan = 2 + (2*ArrayLen(arrQuals))> --->

<cfoutput query="Auditors">
<tr>
	<td bgcolor=CCCCCC>#Auditor#<br />
		<cfif Status NEQ "Active">(#Status#)</cfif>
    </td>
	<td align="center" bgcolor=CCCCCC>
    	<a href="AuditorQualifications2.cfm?ID=#ID#&Action=Auditor">
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

        <cfloop index="i" from="1" to="#ArrayLen(arrQuals)#">
        	<td align="center">
				<cfloop query="AuditorQuals">
	            	<cfif qID eq i>
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