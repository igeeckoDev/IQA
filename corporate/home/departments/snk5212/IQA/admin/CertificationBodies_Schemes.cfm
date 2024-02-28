<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Certification Bodies and Associated Schemes">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- CB Audits - list programs --->
<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Corporate.ProgDev.Program, CBAudits.Name, CBAudits.ID, Corporate.ProgDev.ID as ProgID

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
<b><u>#Name#</u></b><br>
</cfif>

 :: #Program#<br>
 
<cfset CBholder = Name>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->