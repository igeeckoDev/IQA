<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Site Quality Manager Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<script language=javascript>
	window.name = "doUpLoadProc";
</script>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
// End -->
</script>

<CFQUERY BLOCKFACTOR="100" NAME="Offices" Datasource="Corporate">
SELECT OfficeName, Region, SubRegion, TechnicalAudits_SQM
FROM IQAtbloffices
WHERE ID = #URL.OfficeID#
</cfquery>

<cfset SubRegHolder=""> 

<cfif isDefined("url.msg")>
	<font class="warning"><b>Note:</b> <cfoutput>#url.msg#</cfoutput></font><br /><Br />
</cfif>

<table border="1">
<tr>
	<th>Office Name</th>
	<th>Site Quality Manager</th>
</tr>
<CFOUTPUT Query="Offices"> 
    <cfif SubRegHolder IS NOT SubRegion> 
    <cfIf SubRegHolder is NOT ""><tr><td colspan="10">&nbsp;</td></tr></cfif>
    	<tr align="left" valign="top">
			<td colspan="10"><b>#Region# - #SubRegion#</b></td>
        </tr>
	</cfif>

	<tr align="left" valign="top">
    	<td nowrap>#OfficeName#</td>
   	    <td align="center">
			<cfif len(TechnicalAudits_SQM)>#replace(TechnicalAudits_SQM, ",", "<br>", "All")#<cfelse>--</cfif>
        </td>
    </tr>

    <cfset SubRegHolder = SubRegion>
</CFOUTPUT>
</table><br />

<cfoutput>
Select Site Quality Manager: 
<a href="javascript:popUp('TechnicalAudits_EmailLookup.cfm?OfficeID=#URL.OfficeID#&pageName=TechnicalAudits_SQM_Edit.cfm')">Lookup</a>
<Br><Br>

<cfif isDefined("Form.SQM")>
    <cfset SQMValue = "#Form.SQM#">
<cfelse>
    <cfset SQMValue = "">
</cfif>

<cfif isDefined("Form.SQM")>
    <cfform action="TechnicalAudits_SQM_Edit_Action.cfm">
        <cfinput
            type="hidden" 
            name="TechnicalAudits_SQM" 
            value="#SQMValue#">
            
        <cfinput
            type="hidden"
            name="OfficeID"
            value="#URL.OfficeID#">
    
        <cfinput
            type="hidden"
            name="SQM_originalValue"
            value="#Offices.TechnicalAudits_SQM#">
        
        <u>Current Selection for Site Quality Manager</u>: #SQMValue#<Br><br>
        
        <cfinput type="Submit" name="Submit" value="Save">
    </cfform>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->