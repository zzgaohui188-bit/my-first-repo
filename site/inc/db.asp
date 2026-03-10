<!--#include file="config.asp" -->
<%
Function OpenConn()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open "Provider=SQLOLEDB;Data Source=" & DB_SERVER & ";Initial Catalog=" & DB_NAME & ";User ID=" & DB_USER & ";Password=" & DB_PASSWORD & ";"
    Set OpenConn = conn
End Function

Function CreateCmd(ByRef conn, sql)
    Dim cmd
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn
    cmd.CommandType = 1 ' adCmdText
    cmd.CommandText = sql
    Set CreateCmd = cmd
End Function

Sub AddParam(ByRef cmd, name, dataType, size, value)
    Dim p
    Set p = cmd.CreateParameter(name, dataType, 1, size, value) ' adParamInput
    cmd.Parameters.Append p
End Sub
%>
