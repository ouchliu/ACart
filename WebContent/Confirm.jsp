<html>

<body>

            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*, java.util.*, cartitem.*" %>
            <%-- -------- Open Connection Code -------- --%>
            <%
         	// retrieves student data from session scope
            LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
        
            // retrieves the latest pid
            Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
            String username = (String)(session.getAttribute("username"));
            
            session.setAttribute("cartitem", null);
            session.setAttribute("itemnumber", null);
      
            
            
            Connection conn = null;
            /* PreparedStatement pstmt = null; */
            PreparedStatement pstmt = null;
            PreparedStatement pstmtOP = null;
            PreparedStatement pstmtUID = null;

            ResultSet rs = null;
            ResultSet rsuser = null;

            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=Hh_2010");
            %>
			
			<%-- -------- PAY Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("pay")) {
%>
				
<%-- 				<%= (java.sql.Date)(new java.util.Date())%>
 --%><% 
                	
                    // Begin transaction
                    conn.setAutoCommit(false);

 					pstmtUID = conn
         				.prepareStatement("SELECT id FROM users WHERE name = ?");
                    pstmtUID.setString(1, username);
					rsuser = pstmtUID.executeQuery();
					Integer userid = 0;
					rsuser.next();
					userid = rsuser.getInt("id");
					
                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO orders (totalprice, cardnumber, userid) VALUES (?, ?, ?)");
                    
                    pstmt.setDouble(1, (Double)(session.getAttribute("totalprice")) );
                    pstmt.setString(2, request.getParameter("cardnumber"));
                    pstmt.setInt(3, userid);

/*                     pstmt.setDate(3, (java.sql.Date)(new java.util.Date()));
 */					
                    int rowCount = pstmt.executeUpdate();
 
 					Statement statement = conn.createStatement();
 					rs = statement.executeQuery("SELECT id FROM orders");
 					
 					int lastorderid = 0;
 					while (rs.next()) {
 						lastorderid = rs.getInt("id");
 					}


                    Iterator it = cartitem.entrySet().iterator();
                    
                    while(it.hasNext()){
                        // current element pair
                        Map.Entry pair = (Map.Entry)it.next(); 
                        pstmtOP = conn
                                .prepareStatement("INSERT INTO orders_products (orderid, productid, amount) VALUES (?, ?, ?)");

                        pstmtOP.setInt(1, lastorderid);                    
                        pstmtOP.setInt(2, ((Cartitem)pair.getValue()).getId());                    
                        pstmtOP.setInt(3, ((Cartitem)pair.getValue()).getAmount());     
                        int rowCountOP = pstmtOP.executeUpdate();
            		}
 
 
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                %>
                	Congratulations! You have bought:
                	<br>
                	
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
                Iterator it1 = cartitem.entrySet().iterator();
                while(it1.hasNext()){
                    // current element pair
                    Map.Entry pair = (Map.Entry)it1.next();
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
                %>
                	</table>
					<BR>
					<tr>
							Total: $<%=session.getAttribute("totalprice") %>
							
					<tr>
					<a href="ProductBrowse.jsp">Keep Shopping<a>
                	
                	
                <% 
                }
            	
            	

                // Close the Statement
                //pstmt.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {
			
                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
             %>   
             	
                 User doesn't exist.
            
            <form action="LoginRes.jsp" method="GET">
            	Please enter your Username no password required: <p />
            	<input value="" name="username" size="20"/><p /> 
            	<input type="hidden" name ="action" value="checkuser"/>
            	<input type="submit" value="Login"/>
            </form>  
            <%
/*             	throw new RuntimeException(e);
 */            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
				
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>
        
</body>

</html>
