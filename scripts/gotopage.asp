<%
if Request.Form("selectPage")<>"" then
       Response.Redirect("/" & Request.Form("language") & "/" & Request.Form("type") & "/" & Request.Form("folder") & "/" & Request.Form("selectPage") & ".html#docCont")
end if
%>   

