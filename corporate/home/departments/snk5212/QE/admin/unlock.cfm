<cfquery Datasource="Corporate" name="unlock"> 
SELECT null_field from  CAR_LOGIN  "LOGIN" WHERE ID = #URL.ID#
</cfquery>