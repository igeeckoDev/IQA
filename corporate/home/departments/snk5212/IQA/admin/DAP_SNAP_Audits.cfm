<cfif URL.Half eq 1>
	<cfset Half = "January - June">
<cfelseif URL.Half eq 2>
	<cfset Half = "July - December">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="OSHA SNAP Audits Assignment - <b>DAP #url.Half# (#Half# #curyear#)</b>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.msg")>
	<cfoutput>
	    <font color="red">#url.msg#</font><br /><br />
	</cfoutput>
</cfif>

<cfoutput>
	View: <b>DAP #url.Half# (#Half# #curyear#)</b><br />
    <cfloop from="2010" to="#nextYear#" index="i">
       	#i# -
        <cfloop from="1" to="2" index="j">
        	<cfif i eq url.year AND j eq url.half>
				<u>DAP #j#</u>
            <cfelse>
                <a href="DAP_SNAP_Audits.cfm?Year=#i#&Half=#j#">DAP #j#</a>
            </cfif>
            <cfif j eq 1> : </cfif>
        </cfloop><br />
    </cfloop><Br />

    <cflock scope="SESSION" timeout="5">
    	<cfif SESSION.Auth.UserName eq "Admin" OR SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "IQAAuditor">
			<cfif URL.Year lte 2012>
                :: <a href="DAP_SNAP_Coverage.cfm?Year=#URL.Year#">View OSHA SNAP Coverage Table</a><br>
            <cfelse>
                :: <a href="DAP_SNAP_Coverage2013_currentYear.cfm?Year=#URL.Year#">View</a> OSHA SNAP Coverage Table<br>
				:: <a href="SNAP.cfm">View</a> OSHA SNAP Matrix<br />
            </cfif><br />
		</cfif>
    </cflock>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Audits" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditOfficeNameID, AuditYear, AuditID, Status, AssignedTo, CompletedDate, DueDate

FROM xSNAPData

WHERE AuditYear = #url.year#
<cfif url.half eq 1>
	AND (AuditMonth BETWEEN 1 AND 6)
<cfelseif url.half eq 2>
	AND (AuditMonth BETWEEN 7 AND 12)
</cfif>

GROUP BY AuditOfficeNameID, AuditYear, AuditID, Status, AssignedTo, CompletedDate, DueDate
ORDER BY AuditID, AuditOfficeNameID
</cfquery>

<table border="1" style="border-collapse: collapse;">
<tr>
	<th>DAP Audit Number</th>
    <th>Office Name</th>
    <th>Auditor<br>Assigned</th>
    <th>Due Date</th>
    <th>Completed<br />Status</th>
    <th>On Time?</th>
</tr>

<cfoutput query="Audits">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CheckAudit">
    SELECT AuditType2
    FROM AuditSchedule
    WHERE ID = #AuditID#
    AND Year_ = #AuditYear#
    </cfquery>

    <!---
	only output dap 1 and dap 2 audits - which are the only
	Global Function/Process audits where DAP Records are gathered
	--->
    <cfif CheckAudit.AuditType2 eq "Global Function/Process">
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
        SELECT OfficeName
        FROM IQAtblOffices
        WHERE ID = #AuditOfficeNameID#
        </cfquery>

	    <tr>
            <td align="center">
            	<A href="DAP_SNAP_Review.cfm?ID=#AuditID#&Year=#AuditYear#&OfficeID=#AuditOfficeNameID#">
                	#AuditYear#-#AuditID#-#AuditOfficeNameID#
                </A>
            </td>
            <td>#Office.OfficeName#</td>
            <td align="center">
            <!--- if assignedto field is defined, show the value --->
            <cfif len(AssignedTo)>
                #AssignedTo#<Br>
                <!--- Reassignable if it has not been completed --->
				<cfif NOT len(Status)>
                	<cflock scope="session" timeout="5">
                    	<cfif SESSION.Auth.UserName eq "Purvey"
							OR SESSION.Auth.UserName eq "CJones"
							OR SESSION.Auth.AccessLevel eq "SU">
                            <a href="DAP_SNAP_AssignAudit.cfm?AuditYear=#AuditYear#&AuditID=#AuditID#&AuditOfficeNameID=#AuditOfficeNameID#">
                                Reassign
                            </a>
                    	</cfif>
                	</cflock>
                </cfif>
            <cfelseif NOT len(AssignedTo)>
                <!--- if the status is defined, then the audit has been started and/or completed, most likely before the audit assignments were completed, so do not allow this audit to be assigned, since its in process already --->
                <cfif len(Status)>
                    --
                <!--- if assignedto and status fields are blanks, this means the audit is not assigned and has not been started yet --->
                <cfelse>
                	<cflock scope="session" timeout="5">
                    	<cfif SESSION.Auth.UserName eq "Purvey"
							OR SESSION.Auth.UserName eq "CJones"
							OR SESSION.Auth.AccessLevel eq "SU">
		        			<a href="DAP_SNAP_AssignAudit.cfm?AuditYear=#AuditYear#&AuditID=#AuditID#&AuditOfficeNameID=#AuditOfficeNameID#">
        		            	Assign
                    		</a><br>
                		</cfif>
                    </cflock>
				</cfif>
            </cfif>
            </td>
			<td align="center">
				<cfif len(DueDate)>
                   	#dateformat(DueDate, "mm/dd/yyyy")#
				<cfelse>
                	--
				</cfif>
            </td>
            <td align="center" valign="middle">
				<cfif len(Status)>
                	<cfif Status eq "Complete">
                		<img src="#IQARootDir#images/green.jpg" border="0" />
                    </cfif>
				<cfelse>
                	<cfif len(DueDate)>
						<cfif DueDate lt curDate>
                            <!--- not Completed and LATE --->
                            <img src="#IQARootDir#images/red.jpg" border="0" />
                        <cfelseif DueDate gte curDate>
                            <img src="#IQARootDir#images/blue.jpg" border="0" />
                        </cfif>
					<cfelse>
                    	<img src="#IQARootDir#images/blue.jpg" border="0" />
                    </cfif>
				</cfif>
            </td>
            <td align="center">
            	<cfif Status eq "Complete" AND len(CompletedDate)>
                	<!--- Oracle stores Dates as mm/dd/yyyy hh:mm:ss --->
                	<!--- change date format to remove time from CompletedDate --->
					<cfset vCompletedDate = dateformat(CompletedDate, "mm/dd/yyyy")>
					<cfif len(DueDate)>
                    	<!--- change date format to remove time from DueDate --->
                    	<cfset vDueDate = dateformat(DueDate, "mm/dd/yyyy")>
						<!--- If it was completed LATE --->
                        <cfif vCompletedDate gt vDueDate>
                            <img src="#IQARootDir#images/red.jpg" border="0" />
                        <!--- Completed on time --->
                        <cfelseif vCompletedDate lte vDueDate>
                            <img src="#IQARootDir#images/green.jpg" border="0" />
                        </cfif>
					<cfelse>
						<img src="#IQARootDir#images/green.jpg" border="0" />
					</cfif>
                    	<br />#vCompletedDate#
                <cfelseif Status eq "Complete" AND NOT len(CompletedDate)>
                	<img src="#IQARootDir#images/green.jpg" border="0" />
                <cfelseif Status NEQ "Complete">
                	<cfif len(DueDate)>
	                    <!--- change date format to remove time from DueDate --->
                    	<cfset vDueDate = dateformat(DueDate, "mm/dd/yyyy")>
						<cfif vDueDate lt curDate>
                            <!--- not Completed and LATE --->
                            <img src="#IQARootDir#images/red.jpg" border="0" />
                        <cfelseif vDueDate gte curDate>
                            <!--- not completed and NOT late --->
                            <img src="#IQARootDir#images/blue.jpg" border="0" />
                        </cfif>
					<cfelse>
                    	<img src="#IQARootDir#images/blue.jpg" border="0" />
                    </cfif>
				</cfif>
            </td>
	    </tr>
	</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->