<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KPRD">
SELECT RD.ID, RD.KPID, RD.RDNumber, RD.RD, KP.KP, KP.ID FROM RD, KP
WHERE KP.ID = RD.KPID 
ORDER BY KP.KP, RD.RD
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Key Processes and Reference Documents">
<cfinclude template="SOP.cfm">

<!--- / --->
						  
Key Process - <a href="addkp.cfm">Add/Edit</a><br>
Reference Document - <a href="addrd.cfm">Add/Edit</a><br><br>
						  
<cfset KPHolder = ""> 

<CFOUTPUT Query="KPRD"> 
<cfif KPHolder IS NOT KPID> 
<cfIf KPHolder is NOT ""><br></cfif>
<b>#KP#</b><br> 
</cfif>
&nbsp;&nbsp; - #trim(RD)# (#trim(RDNumber)#)<br>
<cfset KPHolder = KPID> 
</CFOUTPUT>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->