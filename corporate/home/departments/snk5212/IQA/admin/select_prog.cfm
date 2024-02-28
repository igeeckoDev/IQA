<cfquery Datasource="Corporate" name="ProgList"> 
SELECT * from ProgDev
WHERE IQA = 1
ORDER BY Program
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Program List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>

<b>Select A Program</b><br><br>

<cfoutput query="ProgList">
<a href="calendar3.cfm?type=program&program=#program#">#Program#</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->