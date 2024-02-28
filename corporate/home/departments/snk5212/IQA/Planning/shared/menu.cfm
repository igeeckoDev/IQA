<ul class="arrow2">
  <li class="arrow2"><a href="AuditPlanning_getEmpNo.cfm?New=Yes" class="arrow">Add a new Program or Process</a></li>
</ul>

<cfoutput>
	<cfif Request.Development eq "Yes">
	<br />
	<h2>Site Status</h2>
		<ul class="arrow2">
			<li class="arrow2">
				<p class="warning">
					Application In Development - This is TEST DATA and is NOT ACCURATE
				</p>
			</li>
		</ul>
	</cfif>
</cfoutput>