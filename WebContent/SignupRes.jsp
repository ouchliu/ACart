<html>

<body>

	<%
	if (request.getParameter("action")==null) {
		%>
		<a href="/ACart//Signup.jsp"> Please signup first </a>
		<%
	} else{
	
		String username = request.getParameter("name"); 
/* 		session.setAttribute("username", username);
 */	%>

<h2>SignUp</h2>
<table>
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="/menu.html" />
        </td>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
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
            
            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO users (name, role, age, state) VALUES (?, ?, ?, ?)");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("role"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("age")));                    
                    pstmt.setString(4, request.getParameter("state"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
			Welcome <%= username %>, You have successfully signed up!
            
            <%-- -------- Close Connection Code -------- --%>
            <%
                conn.close();
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
            %>
            	signup failure
            <%
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } // Ignore
                    pstmt = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
	}
            %>
        </table>
        </td>
    </tr>
</table>
</body>

</html>
