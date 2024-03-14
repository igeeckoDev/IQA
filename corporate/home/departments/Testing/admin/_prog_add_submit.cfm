<!--- selects max ID number and adds 1 to add new program row --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="max">
SELECT MAX(ID)+1 as maxid FROM ProgDev
</cfquery>

<!--- inserts ID for new record --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Prog">
INSERT INTO ProgDev(ID)
VALUES(#max.maxid#)
</cfquery>

<!--- adds data from form for new record --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Prog">
UPDATE ProgDev
SET

Manual='#e_Manual#',
<cfif form.e_status is "Active">
 Status='',
<cfelse>
 Status='#form.e_status#',
</cfif>
<cfif form.comments is NOT "">
 Comments='#form.comments#',
<cfelse>
 Comments='',
</cfif>
<cfif form.notes is NOT "">
 notes='#form.notes#',
<cfelse>
 notes=' ',
</cfif>
PMEmail='#form.e_PMEmail#',
POEmail='#form.e_POEmail#',
ProgOwner='#form.e_progowner#',
LocOwner='#form.e_locowner#',
Region='#form.e_region#',
Type='#form.e_type#',
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "CPO">
CPO=#form.CPO#,
CPCMR=#form.CPCMR#,
Silver=#form.Silver#,
IQA=0,
<CFELSEIF SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
CPO=#form.CPO#,
CPCMR=#form.CPCMR#,
Silver=#form.Silver#,
IQA=#form.IQA#,
</cfif>
</cflock>
ProgOversight=#form.e_ProgOversight#,
Manager='#form.e_manager#',
<cfif Form.e_Status is "Withdrawn">
	EndDate='#form.enddate#',
<cfelseif Form.e_Status is "Pending">
	StartDate='#form.startdate#',
</cfif>
<cfif form.e_type is "ancillary">
	Specialist='#form.specialist#',
	SEMail='#form.SEMail#',
	Parent=#form.Parent#,
</cfif>
Program='#e_Program#'

WHERE ID = #max.maxid#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RevHist">
SELECT MAX(ID)+1 as maxid FROM ProgDev_RH
</cfquery>

<cflock scope="Session" timeout="10">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRevHist">
	 INSERT INTO ProgDev_RH(ID,ProgID,RevNo,RevAuthor,RevDetails,RevDate)
	 VALUES(#RevHist.maxid#,#max.maxid#,1,'#SESSION.Auth.Name#','Program Added',#CREATEODBCDate(curdate)#)
	</cfquery>
</cflock>

<cfquery BLOCKFACTOR="100" Datasource="Corporate" NAME="newProg">
SELECT ProgDev.ID, ProgDev.Program, ProgDev_RH.ProgID, ProgDev_RH.RevNo, ProgDev_RH.RevAuthor, ProgDev_RH.RevDetails, ProgDev_RH.RevDate FROM ProgDev, ProgDev_RH
WHERE ProgDev.ID = #max.maxid#
AND ProgDev.ID = ProgDev_RH.ProgID
AND ProgDev_RH.RevNo = 1
</cfquery>

<!--- add IQA Auditors --->

<!---
<cfmail
	from="Programs.Master.List.Update@ul.com"
	to="Christopher.J.Nicastro@ul.com"
	cc="David.Magri@ul.com, global.internalquality@ul.com, Steven.T.Margis@ul.com"
	subject="UL Programs Master List Update - Program Added"
	query="newProg"
    type="html">
UL Programs Master List Update - Program Added<br /><br />

Program Name: #Program#<br />
Revision Number: #RevNo#<br />
Author of Change: #RevAuthor#<br />
Details of Change: #RevDetails#<br /><br />

Link to Program Details Page:<br />
#request.serverProtocol##request.serverDomain#/departments/snk5212/iqa/_prog_detail.cfm?progid=#max.maxid#
</cfmail>
--->

<cfoutput>
	<cflocation url="_prog_detail.cfm?progid=#max.maxid#" addtoken="no">
</cfoutput>
