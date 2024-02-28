<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - Select Site -  Audit Coverage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "Admin" 
	or SESSION.Auth.accesslevel is "SU" 
	or SESSION.Auth.AccessLevel is "IQAAuditor"
    or SESSION.Auth.accesslevel is "RQM">

<cfquery Datasource="Corporate" name="Region"> 
SELECT IQARegion.*, IQASubRegion.*, IQAtblOffices.*, IQAtblOffices.ID AS "OfficeNameID"
FROM IQARegion, IQASubRegion, IQAtblOffices
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
AND IQASubRegion.SubRegion = IQAtblOffices.SubRegion
AND Exist = 'Yes'
AND OfficeName <> 'test location'
ORDER BY IQARegion.Region, IQASubRegion.SubRegion, IQAtblOffices.OfficeName
</CFQUERY>

<cfset AuditedBy = "IQA">
					  
<div align="Left" class="blog-time">
Audit Notification Help - <A HREF="javascript:popUp('../webhelp/webhelp_notifications.cfm')">[?]</A><br>
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A><br>
</div><br>						  

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfif curyear gte 2006 AND curyear lte 2008>
	<cfset StartYear = 2006>
<cfelseif curyear gte 2009 AND curyear lte 2011>
	<cfset StartYear = 2009>
<cfelseif curyear gte 2012 AND curyear lte 2014>
	<cfset StartYear = 2012>	
</cfif>
				  
<cfset RegHolder=""> 
<cfset SubRegHolder=""> 

<CFOUTPUT Query="Region"> 
<cfif exist is "Yes">
	<cfif region is NOT "Field Services">
        <cfif RegHolder IS NOT Region> 
        <cfIf RegHolder is NOT ""><br></cfif>
        <b><u>#Region#</u></b><br> 
        </cfif>
    
        <cfif SubRegHolder IS NOT SubRegion> 
        <cfIf SubRegHolder is NOT ""><br></cfif>
        <b>&nbsp;&nbsp;#SubRegion#</b><br>
        </cfif>

        &nbsp;&nbsp;&nbsp; :: #OfficeName# - <a href="audit_coverage.cfm?OfficeName=#OfficeName#&Year=#StartYear#&AuditedBy=#AuditedBy#">View Coverage</a><Br>
		<cfset RegHolder = Region> 
		<cfset SubRegHolder = SubRegion>
	</cfif>
</cfif>
</CFOUTPUT>
<br><br>

<cfelse>
	Insufficient Privledges
</cfif>
</cflock>


<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->