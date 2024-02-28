<cfoutput>
<table border="1" width="600">
<tr align="left">
<th>Office Name</th>
</tr>

<tr align="left">
<td>#OfficeName#</td>
</tr>

<tr align="left">
<th>Accreditor</th>
</tr>

<tr align="left">
<td>#Accreditor#</td>
</tr>

<tr align="left">
<th>Type of Accreditation</th>
</tr>

<tr align="left">
<td>#AccredType# <cfif len(AccredType2)>(#AccredType2#)</cfif></td>
</tr>

<tr align="left">
<th>Status</th>
</tr>

<tr align="left">
<td><cfif NOT len(Status)>Active<cfelse>#Status#</cfif></td>
</tr>

<tr align="left">
<th>Scope</th>
</tr>

<tr align="left">
<td>#AccredScope#</td>
</tr>

<tr align="left">
<th>Local Audit Conducted?</th>
</tr>

<tr align="left">
<td>#LocalAudit#</td>
</tr>

<tr align="left">
<th>Accreditor Audit Frequency</th>
</tr>

<tr align="left">
<td><cfif AuditFrequency neq 0>#AuditFrequency# Year<cfif AuditFrequency neq 1>s</cfif><cfelse>Unknown</cfif></td>
</tr>

<tr align="left">
<th>Does the Accreditor have their own requirements for this accreditation?</th>
</tr>

<tr align="left">
<td>#AdditionalRequirements#
<cfif AdditionalRequirements eq "Yes">
<br />
Details: #AdditionalRequirementsNotes#
</cfif>
</td>
</tr>

<tr align="left">
<th>Additional Notes</th>
</tr>

<tr align="left">
<td>#Notes#</td>
</tr>

<tr align="left">
<th>Change History</th>
</tr>

<tr align="left">
<td>#IQANotes#</td>
</tr>
</table>
</cfoutput>