<html>

<body>

<h2>Login</h2>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            /* PreparedStatement pstmt = null; */
            ResultSet rsUser = null;
            String username = request.getParameter("username");
            session.setAttribute("username", username);
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
            
                // Create the statement
                PreparedStatement pstmt = conn.prepareStatement("SELECT name FROM users WHERE users.name = ?");
            	pstmt.setString(1, request.getParameter("username"));    
            // Use the created statement to SELECT
                // the student attributes FROM the Student table.
             
                rsUser = pstmt.executeQuery(); 
            }
                
            %>
            <% 
            rsUser.next();
            	if(!rsUser.getString("name").equals(null)) {
            	
        		%>
        			Hello <%= (String)(session.getAttribute("username"))%>
        			<br>
        			<a href="/ACart/ProductBrowse.jsp"> Wanna do some shopping?!Click here </a>
        			
        		<% 
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
             %>   
                User dosssesn't exist.
            
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
