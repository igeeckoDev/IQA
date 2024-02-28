<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "WiSE Locations">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="OfficesByRegion"> 
SELECT IQAtblOffices.OfficeName as OfficeName, IQARegion.Region as Region, IQASubRegion.SubRegion as SubRegion
FROM IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
AND IQATblOffices.WiSE = 'Yes'
AND IQATblOffices.Exist = 'Yes'
AND IQATblOffices.OfficeName <> 'test location'
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>


<cfset RegHolder=""> 
<cfset SubRegHolder=""> 

<CFOUTPUT Query="OfficesByRegion">

    <cfif RegHolder IS NOT Region>
    <br>
    <b><u>#Region#</u></b>
    </cfif> 
    
    <cfif SubRegHolder IS NOT SubRegion>
    	<cfif NOT Len(RegHolder) OR RegHolder IS NOT Region><br></cfif>
    <b>&nbsp;&nbsp;#SubRegion#</b><br>
    </cfif>

	&nbsp;&nbsp;&nbsp; - #OfficeName#<br>

<cfset RegHolder = Region> 
<cfset SubRegHolder = SubRegion>
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->