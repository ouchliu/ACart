<%@page import="java.util.*, cartitem.*" %>
<html>

    
	<%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
    <% 
        // retrieves student data from session scope
        LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
    	if (session.getAttribute("itemnumber")==null || (Integer)(session.getAttribute("itemnumber")) == 1) {
    		%>
    			The cart is empty. <a href="ProductBrowse.jsp">Keep Shopping!<a>
    		<% 
    	} else{
        // retrieves the latest pid
        Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
    %>
    
    <%-- <% String action = request.getParameter("action"); %> --%>

    
    
           
           
            
            

<body>
<h2>Shopping Cart</h2>
<table>
    <tr>
        <td>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
            	<th>No.</th>
                <th>Name</th>
                <th>Price</th>
                <th>Amount</th>
                <th>Total</th>
                <!-- <th>Total</th> -->
            </tr>
			
			<%-- -------- Iteration Code -------- --%>
            <%
                // loop through the student data
                Iterator it = cartitem.entrySet().iterator();
            	double total = 0;
                while(it.hasNext()){
                    // current element pair
                    Map.Entry pair = (Map.Entry)it.next();
            %>

            <tr>
            	<td><%=((Cartitem)pair.getValue()).getNo()%></td>
                <td><%=((Cartitem)pair.getValue()).getItemname() %></td>
                <td>$<%=((Cartitem)pair.getValue()).getPrice()%></td>
                <td><%=((Cartitem)pair.getValue()).getAmount()%></td>
                <td>$<%=((Cartitem)pair.getValue()).getPrice() * ((Cartitem)pair.getValue()).getAmount()%></td>
            </tr>
            <%
            	total += ((Cartitem)pair.getValue()).getPrice() * ((Cartitem)pair.getValue()).getAmount();
                }
			%>
			<% session.setAttribute("totalprice", total); %>
        </table>
        </td>
    </tr>
</table>
	<BR>
	<tr>
			Total: $<%=session.getAttribute("totalprice") %>
			
	<tr>
	<br>
	<br>
	<a href="ProductBrowse.jsp">Keep Shopping <a>Or Enter Your Favorite Credit Card Number Here:
	<br>
	<form action="Confirm.jsp" method="POST">
    	<input type="hidden" name="action" value="pay"/>
        <input value="" name="cardnumber" size="30"/>
        <input type="submit" value="Pay"/>
    </form>

</body>
<%
    	}
%>


</html>

