<cfoutput>
:: <a href="Calibration_Index.cfm">Calibration Index</a><br><Br>
:: <a href="#CARRootDir#">Return to QE Menu</a><br>
:: <a href="#CARAdminDir#logout.cfm">Logout</a><br><br>
</cfoutput>

<cflock scope="SESSION" timeout="5">
	<cfoutput>
	Logged in as: #SESSION.Auth.Username#/#SESSION.Auth.AccessLevel#<br>
	</cfoutput>
</cflock>