<cflock scope="Session" timeout="60">
	<cflog application="no" 
	
	   file="QE" 
	   text="Logout - #SESSION.Auth.Username#" 
	  
	   type="Information">

	<cfset structClear(Session)>
</cflock>
	
<cflocation url="../index.cfm" addtoken="No">