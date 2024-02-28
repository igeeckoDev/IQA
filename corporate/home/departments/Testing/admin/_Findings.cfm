<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subtitle = "Findings/Observations Generated From #url.Year# IQA Audits - by Audit Number">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select Year: 
<cfoutput>
    <cfloop index="i" from="2010" to="#curyear#">
		<cfif url.year eq #i#><b>#i#</b><cfelse><a href="_Findings.cfm?Year=#i#">#i#</a></cfif>
    </cfloop>
</cfoutput><br />

<hr class='dash'><Br />

<cfset var=ArrayNew(1)>

<cfset IDHolder = "">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT *
FROM Report
WHERE Report.Year_ = #URL.Year#
AND Report.AuditedBy = 'IQA'
ORDER BY Report.ID
</CFQUERY>

	<cfoutput query="a">
		<cfif IDHolder IS NOT ID> 
		<cfIf IDHolder is NOT ""><br></cfif>
		<b><u>#Year#-#ID#-IQA</u></b><br>
			<cfset TitleHolder = "">
		</cfif>
		
        <cfset counter = 0>
        
		<cfloop from="1" to="37" index="i">
		   	<cfset var[i] = #evaluate("CAR#i#")#>
				<cfif var[i] NEQ 0>
                 :: <cfset dump = #replace(var[i], ",", "<br> :: ", "All")#>
				#dump#<Br>
                <cfset counter = #counter# + 1>
                </cfif>
        </cfloop>
            <cfif Counter eq 0>
            No Findings or Observations<br>
            </cfif><br>
	</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->