<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Regional Operations Manager Control">
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

<CFQUERY BLOCKFACTOR="100" NAME="Regions" Datasource="Corporate">
SELECT * 
FROM IQARegion
WHERE ID = #URL.RegionID#
</cfquery>

<cfset SubRegHolder=""> 

<table border="1">
<tr>
	<th>Region Name</th>
	<th>Regional Operations Manager</th>
</tr>
<CFOUTPUT Query="Regions"> 
	<tr align="left" valign="top">
    	<td nowrap>#Region#</td>
   	    <td align="center">
			<cfif len(TechnicalAudits_ROM)>#replace(TechnicalAudits_ROM, ",", "<br>", "All")#<cfelse>--</cfif>
        </td>
    </tr>
</CFOUTPUT>
</table><br />

<cfoutput>
Select Regional Operations Manager: 
<a href="javascript:popUp('TechnicalAudits_EmailLookup.cfm?RegionID=#URL.RegionID#&pageName=TechnicalAudits_ROM_Edit.cfm')">Lookup</a>
<Br><Br>

<cfif isDefined("Form.SQM")>
    <cfset SQMValue = "#Form.SQM#">
<cfelse>
    <cfset SQMValue = "">
</cfif>

<cfif isDefined("Form.SQM")>
    <cfform action="TechnicalAudits_ROM_Edit_Action.cfm">
        <cfinput
            type="hidden" 
            name="TechnicalAudits_SQM" 
            value="#SQMValue#">
            
        <cfinput
            type="hidden"
            name="RegionID"
            value="#URL.RegionID#">
    
        <cfinput
            type="hidden"
            name="SQM_originalValue"
            value="#Regions.TechnicalAudits_ROM#">
        
        <u>Current Selection for Regional Operations Manager</u>: #SQMValue#<Br><br>
        
        <cfinput type="Submit" name="Submit" value="Save">
    </cfform>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->