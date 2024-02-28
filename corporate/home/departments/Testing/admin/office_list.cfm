<cfquery Datasource="Corporate" name="Region"> 
SELECT * from IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
						  
<cfset RegHolder=""> 
<cfset SubRegHolder=""> 

<CFOUTPUT Query="Region">
<cfif region is "corporate" or region is "global" or region is "field services">
<cfelse>
<cfif RegHolder IS NOT Region> 
<cfIf RegHolder is NOT ""><br></cfif>
<b><u>#Region#</u></b><br><cfif region is "Asia Pacific"><br></cfif>
</cfif>
<cfif SubRegHolder IS NOT SubRegion> 
<cfIf SubRegHolder is NOT ""><br></cfif>
<cfif subregion is region><cfelse><b>&nbsp;&nbsp;#SubRegion#</b><br></cfif>
</cfif>
&nbsp;&nbsp;&nbsp; - #OfficeName#<br>
<cfset RegHolder = Region> 
<cfset SubRegHolder = SubRegion>
</cfif>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->