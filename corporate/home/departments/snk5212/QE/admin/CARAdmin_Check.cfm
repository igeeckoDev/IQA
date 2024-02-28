<CFQUERY BLOCKFACTOR="100" NAME="CARAdmin" DataSource="Corporate">
SELECT * FROM CARAdminList
ORDER BY Status, LastName
</cfquery>

<table border=1>
<tr>
<td>&nbsp;</td>
<td>Status</td>
<td>Last Name</td>
<td>Name</td>
<td>65</td>
<td>17020</td>
<td>17025</td>
<td>Corp CAR Admin</td>
<td>Trainer</td>
<td>DCQR</td>
</tr>
<cfoutput query="CARAdmin">
<tr>
<td>#ID#</td>
<td>#Status#</td>
<td>#LastName#</td>
<td>#Name#</td>
<td><cfif x65 eq "Yes">Yes</cfif>&nbsp;</td>
<td><cfif x17020 eq "Yes">Yes</cfif>&nbsp;</td>
<td><cfif x17025 eq "Yes">Yes</cfif>&nbsp;</td>
<td><cfif CorpCARAdmin eq "Yes">Yes</cfif>&nbsp;</td>
<td><cfif Trainer eq "Yes">Yes</cfif>&nbsp;</td>
<td><cfif DCQR eq "yes">Yes</cfif>&nbsp;</td>
</tr>
</cfoutput>
</table>