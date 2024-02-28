<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "OUTPUT - SQL Console w/ Output - Use Select (CFDUMP Output)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Datasource="#FORM.Schema#" Name="SQL" username="#OracleDB_Username#" password="#OracleDB_Password#">
#PreserveSingleQuotes(FORM.SQL)# 
</CFQUERY>

<cfoutput>
#FORM.SQL# 
<br><br>
Completed.
</cfoutput>

<cfdump var="#SQL#">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->