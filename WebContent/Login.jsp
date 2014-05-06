<%
	session.setAttribute("username", null);
	session.setAttribute("cartitem", null);
	session.setAttribute("itemnumber", null);
	session.setAttribute("totalprice", null);
%>

<html>
<head><title>ACart Login</title></head> 
<body>
	Welcome to ACart<p>
<form action="LoginRes.jsp" method="GET">
	Please enter your Username no password required: <p />
	<input value="" name="username" size="20"/><p /> 
	<input type="hidden" name ="action" value="checkuser"/>
	<input type="submit" value="Login"/>
</form> 
<a href="Signup.jsp">Haven't signup yet?</a>
</body>
</html>