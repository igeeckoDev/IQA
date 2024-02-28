<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning - Quality Staff">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="Quality">
SELECT Name, Email, Region, SubRegion, ID
From IQADB_LOGIN
WHERE AccessLevel = 'RQM'
AND Status IS NULL
ORDER BY Region, SubRegion
</cfquery>

<table border="1">
<tr>
	<th>Name</th>
    <th>Email</th>
    <th>Region/SubRegion</th>
</tr>
<cfset i = 1>
<cfoutput query="Quality">
<tr>
	<td valign="top">#Name#</td>
    <Td valign="top">#Email#</Td>
    <Td valign="top">#Region# / #SubRegion#</Td>
</tr>
<cfset i = i+1>
</cfoutput>
<tr>
	<td valign="top">Stephanie Schiller</td>
    <Td valign="top">Stephanie Schiller@ul.com</Td>
    <Td valign="top">ULE</Td>
</tr>
<tr>
	<td valign="top">John Newell</td>
    <Td valign="top">John.Newell@ul.com</Td>
    <Td valign="top">RFI Global / WiSE</Td>
</tr>
<tr>
	<td valign="top">Matt Marotto</td>
    <Td valign="top">Matthew.J.Marotto@ul.com</Td>
    <Td valign="top">EMC / NEBS / WiSE</Td>
</tr>
<tr>
	<td valign="top">Jim Feth</td>
    <Td valign="top">James.E.Feth@ul.com</Td>
    <Td valign="top">CPO</Td>
</tr>
<tr>
	<td valign="top">Walt Ballek</td>
    <Td valign="top">Walter.E.Ballek@ul.com</Td>
    <Td valign="top">CPO</Td>
</tr>
<tr>
	<td valign="top">Rod Morton</td>
    <Td valign="top">Rodney.E.Morton@ul.com</Td>
    <Td valign="top">CPO</Td>
</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->