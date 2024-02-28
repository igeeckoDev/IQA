<cfquery Datasource="Corporate" name="ProgDetail">
SELECT * from ProgDev
WHERE ID = #URL.ProgID#
</CFQUERY>

<!--- update program data --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Prog">
UPDATE ProgDev
SET

<cfif form.PMEmail is "">
 PMEmail='',
<cfelse>
 PMEmail='#form.PMEmail#',
</cfif>
<cfif form.POEmail is "">
 POEmail='',
<cfelse>
 POEmail='#form.POEmail#',
</cfif>
ProgOwner='#form.e_progowner#',
LocOwner='#form.e_locowner#',
Region='#form.e_region#',
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "CPO">
	 CPO=#form.CPO#,
	 CPCMR=#form.CPCMR#,
	 Silver=#form.Silver#,
	 IQA=#form.IQA#,
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
 EndDate=#CreateODBCDate(form.enddate)#,
<cfelseif Form.e_Status is "Pending">
	<cfif len(form.StartDate)>
		StartDate=#CreateODBCDate(form.startdate)#,
	</cfif>
</cfif>
<cfif ProgDetail.Type is "Ancillary">
	<cfif form.e_type is "Ancillary" OR len(form.specialist) AND len(form.SEMail)>
	<!--- if type is ancillary OR if there is specialist info... some cases where non-ancillary programs have specialists --->
	Specialist='#form.specialist#',
 	SEMail='#form.SEMail#',
 	Parent=#form.Parent#,
	<cfelseif NOT len(form.specialist) AND NOT len(form.SEMail)>
	<!--- specialist fields are blank --->
	Specialist='',
	SEMail='',
	Parent=null,
	</cfif>
<cfelseif ProgDetail.Type is NOT "Ancillary" AND form.e_type is "Ancillary">
	 Specialist='#form.specialist#',
 	 SEMail='#form.SEMail#',
 	 Parent=#form.Parent#,
</cfif>
<cfif form.e_status is "Active">
 Status='',
<cfelse>
 Status='#form.e_status#',
</cfif>
<cfif form.comments is NOT "">
 Comments='#form.comments#',
<cfelse>
 comments=' ',
</cfif>
<cfif form.notes is NOT "">
 notes='#form.notes#',
<cfelse>
 notes=' ',
</cfif>
<cfif form.manual is NOT "">
Manual='#form.Manual#',
<cfelse>
Manual=' ',
</cfif>
Type='#form.e_type#'

WHERE ID = #url.progid#
</cfquery>

<!--- Rev Hist --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RevHist">
SELECT MAX(RevNo)+1 as maxRev FROM ProgDev_RH
WHERE ProgID = #url.progid#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RevID">
SELECT MAX(ID)+1 as maxID FROM ProgDev_RH
</cfquery>

<cflock scope="Session" timeout="10">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRevHist">
	 INSERT INTO ProgDev_RH(ID,
	 	ProgID,
		RevNo,
		RevAuthor,
		RevDetails,
		RevDate)
	VALUES(#RevID.MaxID#,
		#url.progID#,
		#RevHist.maxRev#,
		'#SESSION.Auth.Name#',
		'#form.e_RevDetails#',
		#CREATEODBCDate(curdate)#)
	</cfquery>
</cflock>

<cfquery BLOCKFACTOR="100" Datasource="Corporate" NAME="newProg">
SELECT ProgDev.ID, ProgDev.Program, ProgDev_RH.ProgID, ProgDev_RH.RevNo, ProgDev_RH.RevAuthor, ProgDev_RH.RevDetails, ProgDev_RH.RevDate FROM ProgDev, ProgDev_RH
WHERE ProgDev.ID = #url.progID#
AND ProgDev.ID = ProgDev_RH.ProgID
AND ProgDev_RH.RevNo = #RevHist.maxRev#
</cfquery>

<!--- add IQA Auditors --->

<!---
<cfmail
	from="Programs.Master.List.Update@ul.com"
	to="Christopher.J.Nicastro@ul.com"
	cc="David.Magri@ul.com, global.internalquality@ul.com, Steven.T.Margis@ul.com"
	subject="UL Programs Master List Update - Program Changes"
	query="newProg"
    type="html">
UL Programs Master List Update - Program Edit<br /><br />

Program Name: #Program#<br />
Revision Number: #RevNo#<br />
Author of Change: #RevAuthor#<br />
Details of Change: #RevDetails#<br /><br />

Link to Program Details Page:<br />
http://#CGI.SERVER_NAME#/departments/snk5212/iqa/_prog_detail.cfm?progid=#url.progID#
</cfmail>
--->
<!--- /// --->

<cfoutput>
	<cflocation url="_prog_detail.cfm?progid=#url.progid#" addtoken="no">
</cfoutput>
