<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT ID, Username, TotalLogins 
FROM IQADB_LOGIN "LOGIN" 
ORDER BY Username
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Access Logs">
<cfinclude template="SOP.cfm">

<!--- / --->

<script language="JavaScript" src="validate.js"></script>	

<br>
<p class="blog-content">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="user.cfm">

Select Username:<br>
<SELECT NAME="e_finduser" displayname="Username">
		<OPTION value="" selected>Select Username
		<OPTION value="">---
<CFOUTPUT QUERY="finduser">
		<OPTION VALUE="#ID#">#username# <cfif totallogins eq 0><cfelse>*</cfif>
</CFOUTPUT>
</SELECT>
<br><br>

* - indicates user has logged in since new logging system (4/4/2007, 1:00PM)<br><br>

<INPUT TYPE="button" value="Submit" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>
</p>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->