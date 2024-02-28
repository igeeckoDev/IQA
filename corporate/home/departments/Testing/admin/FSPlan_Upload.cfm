<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF NOT len(e_File)>
	<cflocation url="#link#">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_File" 
DESTINATION="d:\webserver\corporate\home\departments\snk5212\IQA\FSPlan\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_File#">

<cfset NewFileName="FSPlan-#Form.e_Year#.#cffile.ClientFileExt#">
 
<cffile
action="rename"
source="#FileName#"
destination="d:\webserver\corporate\home\departments\snk5212\IQA\FSPlan\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="MaxID" DataSource="Corporate">
SELECT MAX(ID)+1 as MaxID FROM FSPlan
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AddNew" DataSource="Corporate">
INSERT INTO FSPLAN(ID, File_, Year_)
VALUES(#MaxID.MaxID#, '#NewFileName#', #Form.e_Year#)
</cfquery>

<cfquery BLOCKFACTOR="100" NAME="new" DataSource="Corporate">
SELECT * FROM FSPlan
WHERE ID = #MaxID.MaxID#
</cfquery>

<cfoutput query="new">
	<cflocation url="FSPlan.cfm?msg=Uploaded&ID=#ID#&Year=#Year_#" addtoken="no">
</cfoutput>
