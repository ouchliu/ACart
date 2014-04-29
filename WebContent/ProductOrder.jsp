<%@page import="java.util.*, cartitem.*" %>
<html>

    
	<%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
    <% 
        // retrieves student data from session scope
        LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
    
        // retrieves the latest pid
        Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
    %>
    
    <% String action = request.getParameter("action"); %>

    
    
            
           
            
            

<body>
<div>
      <span style="float:right"><a href="BuyShoppingCart.jsp">Buy Shopping Cart<a></span>Hello, <%= session.getAttribute("username")%><br/>
</div>
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
                while(it.hasNext()){
                    // current element pair
                    Map.Entry pair = (Map.Entry)it.next();
            %>

            <tr>
            	<td><%=((Cartitem)pair.getValue()).getNo()%></td>
                <td><%=((Cartitem)pair.getValue()).getItemname() %></td>
                <td><%=((Cartitem)pair.getValue()).getPrice()%></td>
                <td><%=((Cartitem)pair.getValue()).getAmount()%></td>
                <td><%=((Cartitem)pair.getValue()).getPrice() * ((Cartitem)pair.getValue()).getAmount()%></td>
            </tr>
            <%
                }
            
            
            if (action != null && action.equals("preaddtocart")) {
				
            %>
            <tr>
                <form action="ProductBrowse.jsp" method="POST">
                    <input type="hidden" name="action" value="addtocart"/>
                    <input type="hidden" name="itemname" value="<%=request.getParameter("preitemname")%>"/>
                    <input type="hidden" name="price" value="<%=Integer.parseInt(request.getParameter("preprice"))%>"/>
                    <input type="hidden" name="no" value="<%=(Integer)(session.getAttribute("itemnumber"))%>"/>
                    <input type="hidden" name="id" value="<%=request.getParameter("preid")%>"/>
                    
                    
                    <td><%= session.getAttribute("itemnumber") %></td>
                    <td><%= request.getParameter("preitemname") %></td>
                    <td><%= Integer.parseInt(request.getParameter("preprice")) %></td>                    
                    <td><input value="" name="amount" size="10"/></td>
                    <td><input type="submit" value="Add To Card"/></td>
                </form>
            </tr>
			<%
            }
			%>
        </table>
        </td>
    </tr>
</table>
	<li><a href="ProductBrowse.jsp">Go Back<a></li>

</body>

</html>

