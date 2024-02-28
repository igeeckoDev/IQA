<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Form.File" 
DESTINATION="#SitePath#SiteShared\ApprovalFiles" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="Module#url.mID#-Approval#form.ApprovalNumber#-ApprovalFile.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#SitePath#SiteShared\ApprovalFiles\#NewFileName#">
      
      	<CFQUERY BLOCKFACTOR="100" NAME="getMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT MAX(ID)+1 as MAXID FROM ApplicationApprovals
        </CFQUERY>
        
        <cfif NOT len(getMaxID.MaxID)>
			<cfset getMaxID.maxID = 1>
		</cfif>
        
		<CFQUERY BLOCKFACTOR="100" NAME="InsertRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO ApplicationApprovals(ID, mID, ApprovalFile, ApprovalName, ApprovalDate, ApprovalPerson, ApprovalNumber, Notes)
		VALUES(#getMaxID.maxID#, #URL.mID#, '#NewFileName#', '#Form.ApprovalName#', #CreateODBCDate(Form.ApprovalDate)#, '#Form.ApprovalPerson#', #form.ApprovalNumber#, '#Notes#')
        </CFQUERY>
  
      <cfset message = "Approval File #NewFileName# uploaded">
   
<cflocation url="modulesView_Details.cfm?mID=#mID#&msg=#message#" addtoken="no">