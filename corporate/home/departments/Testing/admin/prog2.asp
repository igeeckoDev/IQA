<link rel="stylesheet" type="text/css" media="screen" href="ic_style.css" />

<%
' ADO constants included above.  Questions about adovbs.inc?
' See "What is Adovbs.inc and Why Do I Need It?"
'   http://www.asp101.com/articles/john/adovbs/default.asp

Dim cnnDbSort      ' ADO Connection object
Dim rstDbSort      ' ADO Recordset object
Dim strSqlQuery    ' Our SQL query
Dim strSortField   ' Field to sort by
Dim strSortOrder   ' "ASC" or "DESC"
Dim objField       ' Used for table display
Dim blnColor       ' Alternating color indicator

' Set our connection string
'strConnString = ("DSN=IQA")
strConnString = (Application("CorpConnectionString"))

' Retrieve sorting parameters:
' Get the field name and make sure the input is one of our field names.
strSortField = Request.QueryString("field")
Select Case LCase(strSortField)
	Case "ID", "Region", "Program", "Progowner", "Type", "Manager", "locowner", "CPCMR", "CPO", "Silver"
		strSortField = strSortField
End Select

' Check for descending o/w we default to ascending
Select Case LCase(Request.QueryString("order"))
	Case "desc"
		strSortOrder = "DESC"
	Case Else
		strSortOrder = "ASC"
End Select

' Build our SQL query
strSqlQuery = "SELECT ID, Region, Program, ProgOwner, Type, Manager, Locowner, CPCMR, CPO, Silver from Programs WHERE CPO = 1 ORDER BY [" & strSortField & "] " & strSortOrder & ";"

' Open connection
Set cnnDbSort = Server.CreateObject("ADODB.Connection")
cnnDbSort.Open strConnString

' Get recordset
Set rstDbSort = Server.CreateObject("ADODB.Recordset")
rstDbSort.Open strSqlQuery, cnnDbSort

' Build our table:
' Start the table
Response.Write "<table border=""1"" cellspacing=""0"">" & vbCrLf

' Write titles and include links to sort the table by each field
Response.Write vbTab & "<tr>" & vbCrLf
For Each objField in rstDbSort.Fields
	Response.Write vbTab & vbTab & "<td align=""center"" bgcolor=""#CCCCCC""><strong>" & objField.Name
	Response.Write "<br> ("
	Response.Write "<a href=""?field=" & objField.Name & "&order=asc"">+</a>"
	Response.Write " / "
	Response.Write "<a href=""?field=" & objField.Name & "&order=desc"">-</a>"
	Response.Write ")</strong></td>" & vbCrLf
Next 'objField
Response.Write vbTab & "</tr>" & vbCrLf

' Display the data
blnColor = False
rstDbSort.MoveFirst
Do While Not rstDbSort.EOF
	'Response.Write rstDbSort.Fields(0).Value & "<br />" & vbCrLf

	Response.Write vbTab & "<tr>" & vbCrLf
	For Each objField in rstDbSort.Fields
		Response.Write vbTab & vbTab & "<td bgcolor="""

		' Decide what color to output
		If blnColor Then
			Response.Write "#CCCCFF"  ' Light blueish
		Else
			Response.Write "#FFFFFF"  ' White
		End If

		Response.Write """>" & Trim(objField.Value) & "</td>" & vbCrLf
	Next 'objField
	Response.Write vbTab & "</tr>" & vbCrLf

	' Toggle our colors
	blnColor = Not blnColor

	rstDbSort.MoveNext
Loop

' End the table
Response.Write "</table>" & vbCrLf

' Close data access objects and free variables
rstDbSort.Close
Set rstDbSort = Nothing
cnnDbSort.Close
Set cnnDbSort = Nothing
%>