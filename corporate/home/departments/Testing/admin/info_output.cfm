<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Information Request">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfinclude template="#IQARootDir#qInfo_Output.cfm">
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->