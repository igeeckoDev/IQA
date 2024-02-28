<cfquery Datasource="Corporate" name="Details"> 
SELECT OfficeName
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Details.OfficeName# - Lab Coverage File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.e_File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Form.e_File" 
DESTINATION="#IQARootPath#LabCoverage" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.e_File#">

<cfset NewFileName="LabCoverage#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootPath#LabCoverage\#NewFileName#">
    
    <cfif URL.Exist eq "No">
        <cfquery Datasource="UL06046" name="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT MAX(ID)+1 as MaxID FROM LabCoverage
        </cfquery>
        
		<cfquery Datasource="UL06046" name="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO LabCoverage(ID, OfficeID, FileName)
        VALUES(#NewID.MaxID#, #URL.ID#, '#NewFileName#')
        </cfquery>
    <cfelseif URL.Exist eq "Yes">
        <cfquery Datasource="UL06046" name="getID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT ID
        FROM LabCoverage
        WHERE OfficeID = #URL.ID#
        </cfquery>
    
        <CFQUERY BLOCKFACTOR="100" NAME="UploadFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		Update LabCoverage
		SET
		FileName = '#NewFileName#'
		WHERE ID = #getID.ID#
        </CFQUERY>    
    </cfif>
         
	<cfset message = "Lab Coverage File [#NewFileName#] for #Details.OfficeName# was uploaded">
   
  <cfif isdefined("message")>
  <br>
  <cfoutput><font color="red">#message#</font></cfoutput><br>
  </cfif><Br>

<cfoutput>
	<a href="Office_Details.cfm?ID=#URL.ID#">Return to Site Profile</a> - #Details.OfficeName#<br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->