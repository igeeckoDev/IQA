<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="emailUpdate"> 
SELECT ID, Function, Owner As Email
FROM GlobalFunctions
WHERE Owner IS NOT NULL
ORDER BY ID
</CFQUERY>

<cfoutput query="emailUpdate">
	<!--- find the location of the @ in the email address, findat is the count including the @ symbol --->
	<cfset FindAt = "#Find("@", Email) - 1#">
	<!--- set the username variable to everything left of the @ symbol --->
	<cfset EmailUsername = "#left(Email, FindAt)#">
	<!--- set altUsername to the email username plus ul.com --->
	<cfset newEmail = "#EmailUsername#@ul.com">

	#ID# | #Function#<Br />
    #Email#<br />
    #newEmail#<br /><Br />


<!---
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="doEmailUpdate"> 
    UPDATE ProgDev
    SET SEmail = '#newEmail#'
    WHERE ID = #ID#
    </CFQUERY>
    
    <CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="outputEmailUpdate"> 
	SELECT ID, Program, SEmail as Email 
    FROM ProgDev
    WHERE ID = #ID#
    </CFQUERY>

	#outputEmailUpdate.ID# | #outputEmailUpdate.Program#<Br />
    #outputEmailUpdate.Email#<Br><br />
--->
</cfoutput>