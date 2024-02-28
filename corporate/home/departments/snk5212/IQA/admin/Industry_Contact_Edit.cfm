<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Industry List Control">
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

<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Industry
WHERE ID = #URL.ID#
</CFQUERY>

<cfset SubRegHolder=""> 

<table border="1">
<tr>
	<th>Industry</th>
	<th>Contact</th>
</tr>
<CFOUTPUT Query="Industry"> 
	<tr align="left" valign="top">
    	<td nowrap>#Industry#</td>
   	    <td align="center">
			<cfif len(Contact)>#replace(Contact, ",", "<br>", "All")#<cfelse>--</cfif>
        </td>
    </tr>
</CFOUTPUT>
</table><br />

<cfoutput>
Select Industry Contact: 
<a href="javascript:popUp('TechnicalAudits_EmailLookup.cfm?ID=#URL.ID#&pageName=Industry_Contact_Edit.cfm')">Lookup</a>
<Br><Br>

<cfif isDefined("Form.SQM")>
    <cfset ContactValue = "#Form.SQM#">
<cfelse>
    <cfset ContactValue = "">
</cfif>

<cfif isDefined("Form.SQM")>
    <cfform action="Industry_Contact_Edit_Action.cfm">
        <cfinput
            type="hidden" 
            name="Contact" 
            value="#ContactValue#">
            
        <cfinput
            type="hidden"
            name="ID"
            value="#URL.ID#">
    
        <cfinput
            type="hidden"
            name="Contact_originalValue"
            value="#Industry.Contact#">
        
        <u>Current Selection for Industry Contact</u>: #ContactValue#<Br><br>
        
        <cfinput type="Submit" name="Submit" value="Save">
    </cfform>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->