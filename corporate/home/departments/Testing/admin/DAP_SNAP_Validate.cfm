<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Records">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
ORDER BY ID
</cfquery>

<cfdump var="#Records#">

<cfoutput query="Records">
<!--- verify that there are no 00000 L2 Employee Numbers UNLESS WTDP/TCP/Program Compliance is NA --->
	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "WTDP">
			<cfif WTDPCompliance neq "NA" AND L2EmpNo eq "00000">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=L2 Employee Number&msg=No Employee Number&rowID=#ID#" addtoken="No">
			</cfif>
		<cfelseif FunctionType2 eq "TCP" OR FunctionType2 eq "PPP">
			<cfif TCPQualification neq "NA" AND L2EmpNo eq "00000">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=L2 Employee Number&msg=No Employee Number&rowID=#ID#" addtoken="No">
			</cfif>
		</cfif>
	<cfelseif FunctionType eq "Data Acceptance">
		<cfif ProgramCompliance neq "NA" AND L2EmpNo eq "00000">
			<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=L2 Employee Number&msg=No Employee Number&rowID=#ID#" addtoken="No">
		</cfif>
	</cfif>
<!--- verify that there are Notes added when Program Compliance is NA --->
<cfset Dump = #replace(Notes, "<p>", "", "All")#>
<cfset vNotes = #replace(Dump, "</p>", "", "All")#>

	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "WTDP">
			<cfif WTDPCompliance eq "NA" AND vNotes eq "None">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Notes&msg=Notes Required&rowID=#ID#" addtoken="No">
			</cfif>
		<cfelseif FunctionType2 eq "TCP" OR FunctionType2 eq "PPP">
			<cfif TCPQualification eq "NA" AND vNotes eq "None">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Notes&msg=Notes Required&rowID=#ID#" addtoken="No">
			</cfif>
		</cfif>
	<cfelseif FunctionType eq "Data Acceptance">
		<cfif ProgramCompliance eq "NA" AND vNotes eq "None">
			<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Notes&msg=Notes Required&rowID=#ID#" addtoken="No">
		</cfif>
	</cfif>
<!--- verify that a project number is listed UNLESS WTDP/TCP/Program Compliance is NA --->
	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "WTDP">
			<cfif WTDPCompliance neq "NA" AND ProjectsReviewed eq "None" 
				OR WTDPCompliance neq "NA" AND ProjectsReviewed eq "NA">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Projects Reviewed&msg=No Project Number&rowID=#ID#" addtoken="No">
			</cfif>
		<cfelseif FunctionType2 eq "TCP" OR FunctionType2 eq "PPP">
			<cfif TCPQualification neq "NA" AND ProjectsReviewed eq "None" 
				OR TCPQualification neq "NA" AND ProjectsReviewed eq "NA">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Projects Reviewed&msg=No Project Number&rowID=#ID#" addtoken="No">
			</cfif>
		</cfif>
	<cfelseif FunctionType neq "Data Acceptance">
		<cfif ProgramCompliance neq "NA" AND ProjectsReviewed eq "None" 
			OR ProgramCompliance neq "NA" AND ProjectsReviewed eq "NA">
			<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=Projects Reviewed&msg=No Project Number&rowID=#ID#" addtoken="No">
		</cfif>
	</cfif>
<!--- verify that there is a CAR listed when Program Compliance is NO --->
	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "WTDP">
			<cfif WTDPCompliance eq "No" AND CARs eq "None">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=CARs&msg=No CARs Listed&rowID=#ID#" addtoken="No">
			</cfif>
		<cfelseif FunctionType2 eq "TCP" OR FunctionType2 eq "PPP">
			<cfif TCPQualification eq "No" AND CARs eq "None">
				<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=CARs&msg=No CARs Listed&rowID=#ID#" addtoken="No">
			</cfif>
		</cfif>
	<cfelseif FunctionType neq "Data Acceptance">
		<cfif ProgramCompliance eq "No" AND CARs eq "No">
			<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=CARs&msg=No CARs Listed&rowID=#ID#" addtoken="No">
		</cfif>
	</cfif>
</cfoutput>

<cfoutput query="Records">
<!--- validate employee numbers --->
<cfif L2EmpNo neq "00000">
<!----
	<cfif L2EmpStatus neq "No">
		<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
		SELECT EMPLOYEE_NUMBER
		FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
		WHERE EMPLOYEE_NUMBER = '#L2EmpNo#'
		</CFQUERY>
	
		<cfif NameLookup.RecordCount eq 0>
			<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Validate=L2 Employee Number&msg=Invalid Employee Number&rowID=#ID#" addtoken="No">
		</cfif>
	</cfif>
--->
</cfif>
</cfoutput>

<cflocation url="DAP_SNAP_Complete.cfm?#CGI.Query_String#" addtoken="no">