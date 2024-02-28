<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Planning - Email List - #URL.Type#">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

Select:<Br>
 :: <a href="EmailList.cfm?Type=Operations">Operations</a><br>
 :: <a href="EmailList.cfm?Type=Laboratory">Laboratory</a><br>
 :: <a href="EmailList.cfm?Type=Process">Process</a><br>
 :: <a href="EmailList.cfm?Type=Program">Program</a><br>
 :: <a href="EmailList.cfm?Type=Certification Body">Certification Body</a><br>
 :: <a href="EmailList.cfm?Type=Quality">Quality Contacts</a><Br><br>

Viewing List: <cfoutput>#URL.Type#</cfoutput><br><br>
 
<cfif URL.TYPE neq "Quality">
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Type, SentTo, pID
	FROM UL06046.AuditPlanning2017_Users
	Where Type = '#URL.Type#'
	ORDER BY SentTo
	</cfquery>

	<cfoutput query="Distribution">
	#replace(SentTo, ",", ";", "All")#;
	</cfoutput><br><br>
<cfelse>	
	<CFQUERY BLOCKFACTOR="100" name="Distribution" Datasource="Corporate">
	SELECT Name, Email, Region, SubRegion, ID
	From IQADB_LOGIN
	WHERE AccessLevel = 'RQM'
	AND Username <> 'IP_RQM'
	AND Status IS NULL
	ORDER BY Region, SubRegion
	</cfquery>

	<cfoutput query="Distribution">
	#Email#;
	</cfoutput>
	James.E.Feth@ul.com;Walter.E.Ballek@ul.com;Rodney.E.Morton@ul.com;Luis.Feijo@ul.com;
	Harish.Patel@ul.com;Michael.Schneider@ul.com;John.Carlin@ul.com;Dale.C.Hendricks@ul.com;
	JanBehrendt.Ibsoe@ul.com;Hiromi.Yamaoka@ul.com;Erica.Qin@ul.com;Kila.Yang@ul.com;
	Vinutha.mu@ul.com;Balina.Ling@ul.com;Stephanie.Schiller@ul.com;Keith.A.Mowry@ul.com;
	Rick.A.Titus@ul.com;
	<br><br>
</cfif>
	
<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->