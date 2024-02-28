<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- CB Audits - list programs --->
<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Corporate.ProgDev.Program, CBAudits.Name, Corporate.ProgDev.ID, CBAudits.ID as CB_ID
FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
AND CBAudits_SchemeAssignment.status IS NULL
ORDER BY CBAudits.Name, Corporate.ProgDev.Program
</cfquery>

<cfset CBholder = "">

<cfoutput query="CBSchemes">
<cfif CBHolder IS NOT Name>
<cfIf CBHolder is NOT ""><br></cfif>
<b><u>#Name# (CB ID: #CB_ID#)</u></b><br>
</cfif>

 :: #Program# (Program ID: #ID#)<br>

<cfset CBholder = Name>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->