<cfquery Datasource="Corporate" name="Region"> 
SELECT * from IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Internal Audit Summary Report">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>
					  
<cfset RegHolder=""> 
<cfset SubRegHolder=""> 

<CFOUTPUT Query="Region"> 
<cfif exist is "Yes">
<cfif RegHolder IS NOT Region> 
<cfIf RegHolder is NOT ""><br></cfif>
<b><u>#Region#</u></b> :: <cfif region is "field services"><a href="iReportFS.cfm?year=2006">Yearly Report</a><cfelse><a href="iReport_Region.cfm?region=#region#&year=2006">Yearly Report</a></cfif><br> 
</cfif>
<cfif SubRegHolder IS NOT SubRegion> 
<cfIf SubRegHolder is NOT ""><br></cfif>
<b>&nbsp;&nbsp;#SubRegion#</b> <cfif region is "field services"><cfelse>:: <a href="iReport_SubRegion.cfm?subregion=#subregion#&year=2006">Yearly Report</a></cfif><br>
</cfif>
&nbsp;&nbsp;&nbsp; - #OfficeName# <cfif region is "field services"><cfelse>:: <a href="iReport_Office.cfm?officename=#officename#&year=2006">Yearly Report</a></cfif><br>
<cfset RegHolder = Region> 
<cfset SubRegHolder = SubRegion>
</cfif>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->