<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Cert is "">
<cflocation url="#link#" addtoken="no">
</CFIF>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ID = #URL.ID#
</CFQUERY>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Cert" 
DESTINATION="d:\webserver\corporate\home\departments\snk5212\iqa\Certs\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf">

<cfset FileName="#Form.Cert#">

<cfset NewFileName="#TPTDP.Certificate#.#cffile.ClientFileExt#">

<cffile
    action="rename"
    source="#FileName#"
    destination="d:\webserver\corporate\home\departments\snk5212\iqa\Certs\#NewFileName#">

<cflocation url="TPTDP_View.cfm?ID=#URL.ID#" addtoken="no">