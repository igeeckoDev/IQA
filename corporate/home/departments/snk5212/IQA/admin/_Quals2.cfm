<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Corporate IQA Auditor Qualifications">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="Corporate">
SELECT ID, Auditor, Status
From AuditorList
WHERE IQA = 'Yes'
ORDER BY LastName
</CFQUERY>

<CFQUERY Name="Qualification" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, QualificationName
From Qualification
ORDER BY ID
</CFQUERY>

<cfset arrQuals = arrayNew(2)>

<cfset i = 1>
<b>Current List of Qualifications</b> <a href="_Quals_Manage.cfm">[Manage]</a><Br />
<cfloop query="Qualification">
	<cfset arrQuals[i] = arrayNew(1)>
    <cfset setID = arrayAppend(arrQuals[i],"#ID#")>
    <cfset setQual = arrayAppend(arrQuals[i],"#QualificationName#")>
		<cfoutput>
	        #i#. #QualificationName#<br />
        </cfoutput>
<cfset i = i + 1>
</cfloop><br />

<Table border="1">
<tr>
	<th align="center" colspan="2">Auditor Name</th>
	<cfoutput>
    	<cfloop index="i" from="1" to="#ArrayLen(arrQuals)#">
    		<th align="center">#arrQuals[i][2]#</th>
            <th align="center" width="15">
            	<a href="_Quals_Edit.cfm?ID=#arrQuals[i][1]#&Action=Qualification">
                	<img src="#IQADir#images/ico_article.gif" border="0" />
                </a>
            </th>
    	</cfloop>	
    </cfoutput>
</tr>

<!--- <cfset submitColspan = 2 + (2*ArrayLen(arrQuals))> --->

<cfoutput query="Auditors">
<tr>
	<td>#Auditor#</td>
    <td align="center" width="15">
    	<a href="_Quals_Edit.cfm?ID=#ID#&Action=Auditor">
    		<img src="#IQADir#images/ico_article.gif" border="0" />
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
	                <td align="center" colspan="2"><cfif qValue eq 1>Yes<cfelse>No</cfif></td>
    			</cfif>
            </cfloop>
		</cfloop>
</tr>
</cfoutput>
</Table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->