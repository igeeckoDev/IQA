	<CFQUERY BLOCKFACTOR="100" name="ListNew" Datasource="Corporate">
	SELECT * FROM ProgPlanAllDev
	WHERE Manager = 'Carney, W.'
	Order By Program
	</CFQUERY>	

<cfdump var="#ListNew#">

	<CFQUERY BLOCKFACTOR="100" name="List2" Datasource="Corporate">
	SELECT Program, Responsibility, Manager FROM ProgDev
	WHERE Manager = 'Carney, W.'
	AND IQA = 1
	Order By Program
	</CFQUERY>	

<cfdump var="#List2#">

	<CFQUERY BLOCKFACTOR="100" name="ListOld" Datasource="Corporate">
	SELECT * FROM ProgPlanAll
	WHERE Manager = 'Carney, W.'
	Order By Program
	</CFQUERY>	

<cfdump var="#ListOld#">

	<CFQUERY BLOCKFACTOR="100" name="ListOld2" Datasource="Corporate">
	SELECT Program, Responsibility, Manager FROM Programs
	WHERE Manager = 'Carney, W.'
	AND IQA = 1
	Order By Program
	</CFQUERY>	

<cfdump var="#ListOld2#">
