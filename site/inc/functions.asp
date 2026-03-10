<%
Function H(v)
    If IsNull(v) Then
        H = ""
    Else
        H = Server.HTMLEncode(CStr(v))
    End If
End Function

Function QS(name, defaultValue)
    Dim v
    v = Trim(Request.QueryString(name) & "")
    If v = "" Then
        QS = defaultValue
    Else
        QS = v
    End If
End Function

Function FS(name, defaultValue)
    Dim v
    v = Trim(Request.Form(name) & "")
    If v = "" Then
        FS = defaultValue
    Else
        FS = v
    End If
End Function

Function ToInt(v)
    On Error Resume Next
    ToInt = CInt(v)
    If Err.Number <> 0 Then
        ToInt = 0
        Err.Clear
    End If
    On Error GoTo 0
End Function

Function LikeParam(keyword)
    LikeParam = "%" & keyword & "%"
End Function

Sub RequireAdminLogin()
    If Session(ADMIN_SESSION_KEY) = "" Then
        Response.Redirect "/admin/login.asp"
    End If
End Sub

Sub AlertAndBack(msg)
    Response.Write "<script>alert('" & Replace(msg, "'", "\\'") & "');history.back();</script>"
    Response.End
End Sub
%>
