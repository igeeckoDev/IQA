<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Check CAR Trainer Logins">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Trainers"> 
SELECT * FROM CARAdminList
WHERE Trainer = 'Yes'
ORDER BY LastName
</CFQUERY>

<cfset Trainers = #valueList(Trainers.Name, ',')#>
<cfset myArrayList = ListToArray(Trainers)>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
    <CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Logins"> 
    SELECT * 
    FROM CAR_LOGIN "LOGIN" 
    WHERE Name = '#myArrayList[i]#'
    </cfquery>
    
    <cfoutput>
    #myArrayList[i]# - <cfif logins.recordcount eq 0><a href="TrainerCreateLogin.cfm?Name=#myArrayList[i]#">Create Account</a><cfelse>Account Exists</cfif>
    </cfoutput><br>
</cfloop>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->