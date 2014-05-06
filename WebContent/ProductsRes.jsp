<html>

<body>

	<%
	
	if (session.getAttribute("username")==null){
		%>
		
		<a href="/ACart//Login.jsp"> Please log in first </a>
		
		<% 
	} else if (request.getParameter("action")==null) {
		%>
		<a href="/ACart//LoginRes.jsp"> Please try to manage products </a>
		<%
	} else{
	
	
		String productname = request.getParameter("name"); 
		session.setAttribute("productname", productname); 
	%>


<table>
    <tr>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rsCate = null;
            
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
                    .prepareStatement("INSERT INTO products (name, sku, categoryid, price) VALUES (?, ?, ?, ?)");

                    if(!request.getParameter("name").equals("")){
                    	pstmt.setString(1, request.getParameter("name"));
                    }
                    if(!request.getParameter("sku").equals("")){
                        pstmt.setString(2, request.getParameter("sku"));
                    }
                    
                 	pstmt.setInt(3, Integer.parseInt(request.getParameter("categoryid")));
                 	if(!request.getParameter("price").equals("")){
                        pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    }
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            <h2>Congratulations</h2>
			<%= productname %> has been added
			<br>
			<br>
			<a href="Products.jsp">Go back</a></li>
            
            <%-- -------- Close Connection Code -------- --%>
            <%
                conn.close();
            } catch (Exception e) {
            %>
            	<h2>Sorry</h2>
            	Failure to insert new product.
            	<br>
				<br>
				<a href="Products.jsp">Go back</a></li>
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
