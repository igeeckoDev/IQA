<cfquery Datasource="Corporate" name="Progs"> 
SELECT Area, Year FROM iReportPrograms
WHERE Year = '2006'
ORDER BY Area
</CFQUERY>

<cfquery Datasource="Corporate" name="nacpo">
SELECT Program, Manager, ProgOwner FROM ProgDev
WHERE (Manager = 'Carney, W.' OR ProgOwner = 'Carney, W.')
ORDER BY Program
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Program Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->

<br><u>Select a Program</u>:<br>
<cfoutput>
 - North American Certification Program Office :: <a href="iReportPrograms.cfm?Area=NACPO&year=2006">View</a>
</cfoutput><br><br>

<CFOUTPUT Query="Progs"> 
 - #Area# :: <a href="iReportPrograms.cfm?Area=#Area#&Year=2006">View</a><br>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->