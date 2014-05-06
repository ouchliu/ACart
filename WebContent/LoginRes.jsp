<html>



            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            if((session.getAttribute("username")==null)) {
 				session.setAttribute("cartitem", null);
                session.setAttribute("itemnumber", null);
                
            }
            
            
            if(!(session.getAttribute("username")==null) && !((String)(session.getAttribute("username"))).equals(request.getParameter("username"))) {
 				session.setAttribute("cartitem", null);
                session.setAttribute("itemnumber", null);
            }
            
            
            Connection conn = null;
            /* PreparedStatement pstmt = null; */
            ResultSet rsUser = null;	
           
            
            
            try {

            	
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=Hh_2010");
                
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
            String action = request.getParameter("action");
            if (action != null && action.equals("checkuser")) {
/*             	session.setAttribute("username", request.getParameter("username"));
 */                // Create the statement
 				String username = request.getParameter("username");
 				session.setAttribute("username", username);
                /*pstmt = conn.prepareStatement("SELECT name, role FROM users WHERE users.name = ?");
            	pstmt.setString(1, (String)(session.getAttribute("username")));    
            // Use the created statement to SELECT
                // the student attributes FROM the Student table.
             	
                rsUser = pstmt.executeQuery();  */
            }
                
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT name, role FROM users WHERE users.name = ?");
        	pstmt.setString(1, (String)(session.getAttribute("username")));    
        // Use the created statement to SELECT
            // the student attributes FROM the Student table.
         	
            rsUser = pstmt.executeQuery(); 
            %>
            <% 
            rsUser.next();
            	if(!rsUser.getString("name").equals(null)) {
                	%>
                	<body>
    				<div>
          				<span style="float:right"><a href="BuyShoppingCart.jsp">Buy Shopping Cart<a></span><h2>Login</h2><br/>
    				</div>
    				<a href="Login.html">Log out<a>
    				<br/>
                	<% 
        		%>
        			Hello <%=rsUser.getString("role")%> <%= rsUser.getString("name")%>
        			<br>
        			<a href="/ACart/ProductBrowse.jsp"> Wanna do some shopping?!Click here </a>
        			
        		<% 
        			if(rsUser.getString("role").equals("Owner")) {
        				%>
        				<br>
        				<a href="/ACart/Categories.jsp"> Manage your categories </a>
        				<br>
        				<a href="/ACart/Products.jsp"> Manage your products </a>
        				
        				<%
        			}
            	}
            
            %>
            
            <%-- -------- Close Connection Code -------- --%>
            <%
            
                // Close the ResultSet
                rsUser.close();
            	

                // Close the Statement
                //pstmt.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {
			
                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
             	if((session.getAttribute("username")) == null) {
             		%>
             		Please login first.
             		<% 
             	} else if ((String)(session.getAttribute("username")) == ""){
             		%>
             		Please don't enter nothing.
             		<% 
             	} else {
             %>   
          		
                User <%=(String)(session.getAttribute("username"))%>&nbsp doesn't exist.
            <%
            }
            %>
            
            <form action="LoginRes.jsp" method="GET">
            	Please enter your Username no password required: <p />
            	<input value="" name="username" size="20"/><p /> 
            	<input type="hidden" name ="action" value="checkuser"/>
            	<input type="submit" value="Login"/>
            </form> 
            <%
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
				if (rsUser != null) {
                    try {
                    	rsUser.close();
                    } catch (SQLException e) { } // Ignore
                    rsUser = null;
                }
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
