<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY Name="qExistingData_Process" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditPlanning2011.pID, AuditPlanning2011.Type, AuditPlanning2011.ID, AuditPlanning2011.Quality, Corporate.GlobalFunctions.Function
FROM AuditPlanning2011, Corporate.GlobalFunctions
WHERE AuditPlanning2011.pID <> 0
AND AuditPlanning2011.Type = 'Process'
AND AuditPlanning2011.pID = Corporate.GlobalFunctions.ID
ORDER BY AuditPlanning2011.Type, Corporate.GlobalFunctions.Function
</CFQUERY>

<CFQUERY Name="qExistingData_Site" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditPlanning2011.pID, AuditPlanning2011.Type, AuditPlanning2011.ID, AuditPlanning2011.Quality, Corporate.IQAtblOffices.OfficeName
FROM AuditPlanning2011, Corporate.IQAtblOffices
WHERE AuditPlanning2011.pID <> 0
AND AuditPlanning2011.Type = 'Site'
AND AuditPlanning2011.pID = Corporate.IQAtblOffices.ID
ORDER BY AuditPlanning2011.Type, Corporate.IQAtblOffices.OfficeName
</CFQUERY>

<CFQUERY Name="qExistingData_Program" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditPlanning2011.pID, AuditPlanning2011.Type, AuditPlanning2011.ID, AuditPlanning2011.Quality, Corporate.ProgDev.Program
FROM AuditPlanning2011, Corporate.ProgDev
WHERE AuditPlanning2011.pID <> 0
AND AuditPlanning2011.Type = 'Program'
AND AuditPlanning2011.pID = Corporate.ProgDev.ID
ORDER BY AuditPlanning2011.Type, Corporate.ProgDev.Program
</CFQUERY>

<CFQUERY Name="qNewData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM AuditPlanning2011
WHERE pID = 0
ORDER BY Type, New_PName
</CFQUERY>

<link rel="stylesheet" type="text/css" media="screen" href="../css.css" />

<!--- Existing Data Programs --->
<table border="1" cellpadding="1" cellspacing="1">
 <tr valign="top">
	<td class="sched-title" colspan="2" width="600">Programs</td>
 </tr>
 <tr>
	<td class="sched-title" width="400">Program Name</td>
	<td class="sched-title">View Details</td>
 </tr>
<cfoutput query="qExistingData_Program">
 <tr>
	<td class="sched-content" valign="top">#Program#</td>
    <td class="sched-content" valign="top" align="center">
    	<cfif Quality eq "Yes">
        	<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        <cfelse>
    		<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        </cfif>
    </td>
 </tr>
</cfoutput>
</Table>

<br /><br />

<!--- Existing Data Process --->
<table border="1" cellpadding="1" cellspacing="1">
 <tr valign="top">
	<td class="sched-title" colspan="2" width="600">Process</td>
 </tr>
 <tr>
	<td class="sched-title" width="400">Process Name</td>
	<td class="sched-title">View Details</td>
 </tr>
<cfoutput query="qExistingData_Process">
 <tr>
	<td class="sched-content" valign="top">#Function#</td>
    <td class="sched-content" valign="top" align="center">
    	<cfif Quality eq "Yes">
        	<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        <cfelse>
    		<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        </cfif>
    </td>
 </tr>
</cfoutput>
</Table>

<br /><br />

<!--- Existing Data Site --->
<table border="1" cellpadding="1" cellspacing="1">
 <tr valign="top">
	<td class="sched-title" colspan="2" width="600">UL Sites</td>
 </tr>
 <tr>
	<td class="sched-title" width="400">Site Name</td>
	<td class="sched-title">View Details</td>
 </tr>
<cfoutput query="qExistingData_Site">
 <tr>
	<td class="sched-content" valign="top">#OfficeName#</td>
    <td class="sched-content" valign="top" align="center">
    	<cfif Quality eq "Yes">
        	<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        <cfelse>
    		<a href="AuditPlanning_Details_Review.cfm?ID=#ID#&View=Browse">View</a>
        </cfif>
    </td>
 </tr>
</cfoutput>
</Table>

<br /><br />

<!--- new data --->
<cfset TypeHolder = "">
<table border="1" cellpadding="1" cellspacing="1">
 <tr valign="top" width="600">
	<td class="sched-title" colspan="2" width="600">New Programs / Processes</td>
 </tr>
 <tr>
	<td class="sched-title" width="400">Program / Process Name</td>
	<td class="sched-title">View Details</td>
 </tr>
<cfif qNewData.recordCount gt 0>
	<cfoutput query="qNewData">
    <cfif TypeHolder IS NOT Type> 
        <cfif len(Type)><br></cfif>
        </td></tr><tr><td class="sched-title" colspan="2" align="center"><b>#Type#</b><a name="#Type#"></a>
    </cfif>
    
     <tr>
        <td class="sched-content" valign="top">#New_PName#</td>
        <td class="sched-content" valign="top" align="center"><a href="AuditPlanning_New_Details_Review.cfm?ID=#ID#&View=Browse">View</a></td>
     </tr>
    <cfset TypeHolder = Type>
    </cfoutput>
<cfelse>
<tr>
	<td class="sched-content" colspan="2" width="600" align="center">There are no records.</td>
</tr>
</cfif>
</Table>


<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->