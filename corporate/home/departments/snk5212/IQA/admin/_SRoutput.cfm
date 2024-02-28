<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subtitle = "SRs Generated From #url.Year# IQA Audits - View by Audit Number">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select Year: 
<cfoutput>
    <cfloop index="i" from="2010" to="#curyear#">
		<cfif url.year eq #i#><b>#i#</b><cfelse><a href="_SRoutput.cfm?Year=#i#">#i#</a></cfif>
    </cfloop>
</cfoutput><br />

<hr class='dash'><Br />

<cfset var=ArrayNew(1)>

<cfset IDHolder = "">
<cfset Count = 0>
<cfset SRTotal = 0>

<cfloop from="1" to="37" index="i">
	<cfset var[i] = "SR#i#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT Report.ID, Report.Year_, #var[i]# as SR, Clauses_2010SEPT1.Title
FROM Report, Clauses_2010SEPT1
WHERE Report.Year_ = #URL.Year#
AND Report.AuditedBy = 'IQA'
AND Clauses_2010SEPT1.ID = #i#
AND #var[i]# <> '0'
ORDER BY Report.ID, Clauses_2010SEPT1.Title
</CFQUERY>

<cfset TitleHolder = "">

	<cfoutput query="a">
		<cfif IDHolder IS NOT ID> 
		<cfIf IDHolder is NOT ""><br></cfif>
		<b><u>#Year#-#ID#-IQA</u></b><br>
			<cfset TitleHolder = "">
		</cfif>
		
		<cfif TitleHolder IS NOT Title>
		<cfif TitleHolder IS NOT ""><br></cfif>
			<u>#Title#</u><br>
		</cfif>

        <cfset Count = #Listlen(SR, ",")#>
        Count = (#Count#)<Br />

		 :: <cfset dump = #replace(SR, ",", "<br> :: ", "All")#>
		#dump#<br />
        
		<cfset IDHolder = ID>
		<cfset TitleHolder = Title>
        
        <cfset SRTotal = Count + SRTotal>
	</cfoutput>
</cfloop>

<cfoutput>
<br /><Br />
Total SRs - #SRTotal#<br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->