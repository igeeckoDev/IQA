<cfset email = "Christopher.J.Nicastro@ul.com">

<cfset FindAt = "#Find("@", email) - 1#">

<cfoutput>#FindAt#</cfoutput>

<cfset Username = "#left(email, FindAt)#">

<cfoutput>#UserName#</cfoutput>