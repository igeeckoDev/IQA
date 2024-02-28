<link rel="stylesheet" type="text/css" media="screen" href="ic_style.css" />

<%
dim conn, rs, strQuery

Set conn = Server.CreateObject("ADODB.Connection")
Set rs = Server.CreateObject("ADODB.Recordset")

'conn.Open("DSN=IQA")
conn.Open(Application("CorpConnectionString"))


strQuery = "SELECT Region, program, progowner, type, manager, locowner, CPCMR, CPO, Silver from Programs WHERE CPO = 1 ORDER BY Program"

set rs = conn.Execute(strQuery)

response.write("<Table border=1 width=700>")
response.write("<tr>")
response.write("<td><b>Region</b></td>")
response.write("<td><b>Program Name</b></td>")
response.write("<td><b>Program Owner</b></td>")
response.write("<td><b>Type</b></td>")
response.write("<td><b>Program Manager</b></td>")
response.write("<td><b>Owner</b></td>")
response.write("<td><b>CPC-MR</b></td>")
response.write("<td><b>CPO</b></td>")
response.write("<td><b>Silver</b></td>")
response.write("</tr>")

do while not rs.eof
response.write("<tr>")
for i=0 to rs.fields.count-1
if i > 5 Then
	if rs(i) = 1 Then
		response.write("<td valign=top align=center>x</td>")
	Else
		response.write("<td valign=top align=center>&nbsp;</td>")
	End If
Else
response.write("<td valign=top align=left>"& rs(i)&"</td>")
End If
next
response.write("</tr>")
rs.movenext
loop
response.write("</Table>")
%>