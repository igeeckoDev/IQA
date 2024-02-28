<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<cfform>
    Select Accreditor:<Br>
    
    <CFQUERY BLOCKFACTOR="100" name="Accred" Datasource="Corporate">
    SELECT * FROM Accreditors
    WHERE Status IS NULL
    ORDER BY Accreditor
    </cfquery>
    
    <CFSELECT NAME="Accred" required="Yes" Message="Select Accreditor" ONCHANGE="location = this.options[this.selectedIndex].value;">
    <OPTION Value="">Select Accreditor
        <CFOUTPUT QUERY="Accred">
            <OPTION VALUE="ViewAccreditor.cfm?ID=#ID#">#Accreditor#
        </CFOUTPUT>
    </CFSELECT>
</cfform>
	
<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->