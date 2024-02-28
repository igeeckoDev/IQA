<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add CAR Trainer Logins">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="MaxID"> 
SELECT MAX(ID)+1 as MAXID FROM CAR_Login
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Name"> 
SELECT Name, LastName From CARAdminList
WHERE Name = '#URL.Name#'
</cfquery>

<cfoutput>
<cfform name="addlogin" action="#CGI.SCRIPT_NAME#" method="POST" enctype="application/x-www-form-urlencoded">

<input type="hidden" name="ID" value="#MaxID.MaxID#">

<u>Name</u><br>
<input type="hidden" name="ID" value="#URL.Name#">
#URL.Name#<br><br>

<script language="JavaScript" src="../popup.js"></script>

<u>Email Address</u><br>
<cfinput size="75" type="Text" name="Email" maxlength="128" required="Yes" message="Please enter #url.name#'s external email address"><br>
<a href="javascript:popUp('emailLookup2.cfm?LastName=#Name.LastName#')">lookup</a> email address<br><br>

<u>Username</u><br>

<u>Access Level</u><br>
CARTrainer<br><br>

<INPUT TYPE="Submit" value="Submit">

</cfform>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->