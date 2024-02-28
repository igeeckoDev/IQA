<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="UL06046" password="UL06046">
			SELECT Corporate.ProgDev.Program
			FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
			WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
			AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
			AND CBAudits.Name = 'UL LLC (Video Equipment, Rigid Metal Conduit, Sheet Metal Air Ducts, Interoperability Functions)'
			AND CBAudits_SchemeAssignment.status IS NULL
			ORDER BY Corporate.ProgDev.Program
</cfquery>

<Cfdump var="#CBSchemes#">