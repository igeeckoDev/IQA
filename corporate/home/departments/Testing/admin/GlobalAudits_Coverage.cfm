<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Global Audit Coverage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- query of url.year global audits --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="GlobalAudits"> 
SELECT ID, Year_, Area , AuditArea
FROM AuditSchedule
WHERE AuditType2 = 'Global Function/Process'
AND Status IS NULL
AND AuditArea NOT LIKE 'SNAP/Data Acceptance Program%'
AND Year_ = #URL.Year#
ORDER BY Area
</CFQUERY>

<!--- query of 17025 and 65 clauses --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025"> 
SELECT ISO_17025_2005
FROM Clauses_2010SEPT1
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ISO_17025_2005
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO65"> 
SELECT ISO_65_1996
FROM Clauses_2010SEPT1
WHERE ISO_65_1996 <> 'N/A'
AND ISO_65_1996 NOT LIKE 'Clause 1%'
ORDER BY ISO_65_1996
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO65B"> 
SELECT ISO_65_1996
FROM Clauses_2010SEPT1
WHERE ISO_65_1996 LIKE 'Clause 1%'
ORDER BY ISO_65_1996
</CFQUERY>

<!--- drop down of global audits --->
<cfoutput query="GlobalAudits">
#Year_#-#ID#: #Area# (#AuditArea#)<br>
</cfoutput><br>

<!--- drop down of clauses --->
ISO 17025
<cfoutput query="ISO17025">
#replace(ISO_17025_2005, "Clause ", "<br>", "All")#
</cfoutput><br>

<Br>
ISO 65
<cfoutput query="ISO65">
#replace(ISO_65_1996, "Clause ", "<br>", "All")#
</cfoutput>

<cfoutput query="ISO65B">
#replace(ISO_65_1996, "Clause ", "<br>", "All")#
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->