<html>

<body>
<h2>SignUp</h2>
<table>
    <tr>
        <%-- <td valign="top">
            -------- Include menu HTML code --------
            <jsp:include page="/menu.html" />
        </td> --%>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            /* PreparedStatement pstmt = null; */
            ResultSet rsState = null;
            ResultSet rsRole = null;
            
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
            
            
                // Create the statement
                Statement statement = conn.createStatement();
            	Statement statement1 = conn.createStatement();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rsState = statement.executeQuery("SELECT name FROM states"); 
                rsRole = statement1.executeQuery("SELECT name FROM roles");
             
                
            %>
            
            <!-- Add an HTML table header row to format the results -->
            Please enter your information here.
            <table border="1">
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Age</th>
                <th>State</th>
            </tr>

            <tr>
                <form action="SignupRes.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th><input value="" name="name" size="20"/></th>
                    <th><select name="role">
			 		<%
			 			while(rsRole.next()) {
			  		%>
			  		<option value=<%= rsRole.getString("name") %>><%= rsRole.getString("name")%></option>
			  		<%
			  		}
			   			%>
					</select></th>
                    <th><input value="" name="age" size="5"/></th>
                    <th><select name="state">
			 		<%
			 			while(rsState.next()) {
			  		%>
			  		<option value=<%= rsState.getString("name") %>><%= rsState.getString("name")%></option>
			  		<%
			  		}
			   			%>
					</select></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rsRole.close();
            	rsState.close();

                // Close the Statement
                //pstmt.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                throw new RuntimeException(e);
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
				if (rsRole != null) {
                    try {
                    	rsRole.close();
                    } catch (SQLException e) { } // Ignore
                    rsRole = null;
                }
                
                if (rsState != null) {
                    try {
                    	rsState.close();
                    } catch (SQLException e) { } // Ignore
                    rsState = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>
        </table>
        </td>
    </tr>
</table>
</body>

</html>
