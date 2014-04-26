<html>
<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmtL = null; 
            PreparedStatement pstmt = null; 
            ResultSet rsCate = null;
            ResultSet rsC = null;
            String action = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=Hh_2010");
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt = conn
                        .prepareStatement("UPDATE products SET name = ?, sku = ?, category = ?, price = ? WHERE id = ?");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("sku")));
                    pstmt.setString(3, request.getParameter("category"));
                    pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));

                    
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // DELETE students FROM the Students table.
                    pstmt = conn
                        .prepareStatement("DELETE FROM products WHERE id = ?");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            
           
            
            
            
            

            <%-- -------- SELECT Statement Code -------- --%>
            <%
            
            
                // Create the statement
                Statement statement = conn.createStatement();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rsCate = statement.executeQuery("SELECT name FROM categories"); 
             
                
            %>
<body>
<h2>Products</h2>
<table>
    <tr>
        Please enter your new product information here.
        
        <td>
        <table border="1">
        <tr>
                <th>Categories</th>
        </tr>
        <tr>
        <%
        	while(rsCate.next()) {
        	String cur = rsCate.getString("name");
        %>
        
        <form action="ProductSearch.jsp" method="POST">
        			<input type="hidden" name="action" value="list"/>
        			<input type="hidden" name="cate" value="<%=rsCate.getString("name")%>"/>
                    <th><input type="submit" value="<%=rsCate.getString("name")%>"/></th>
        </form>
        </tr>
        <%
        	}
        %>
        </table>
        </td>
        
        <td>
            
            
            
            
            
            <!-- Add an HTML table header row to format the results -->
            
            <table border="1">
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr>

            <tr>
                <form action="ProductsRes.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="name" size="20"/></th>
                    <th><input value="" name="sku" size="10"/></th>
                    <th><select name="category">
			 		<%	
			 			rsCate = statement.executeQuery("SELECT name FROM categories"); 
			 			while(rsCate.next()) {
			  		%>
			  		<option value=<%= rsCate.getString("name") %>><%= rsCate.getString("name")%></option>
			  		<%
			  		}
			   			%>
					</select>
					</th>
                    <th><input value="" name="price" size="10"/></th>
                    <th><input type="submit" value="New Product"/></th>
                </form>
            </tr>
            
            </table>
        </td>
    </tr>
            
             <%-- -------- LIST Code -------- --%>
            <%
                action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("list")) {

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmtL = conn
                    .prepareStatement("SELECT * FROM products WHERE products.category = ?");

                    pstmtL.setString(1, request.getParameter("cate"));                   
                    rsC = pstmtL.executeQuery();
                
                
             %>
             <table border="1">
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr>
             <% 
                    
                // Iterate over the ResultSet
                while (rsC.next()) {
            %>

            <tr>
                <form action="Products.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%=rsC.getInt("id")%>"/>

                <%-- Get the id --%>
					<td>
                    	<%=rsC.getInt("id")%>
                	</td>
                    <td>
                    	<input value="<%=rsC.getString("name")%>" name="name" size="15"/>
                	</td>
                	<td>
                    	<input value="<%=rsC.getInt("sku")%>" name="sku" size="10"/>
                	</td>
                	
                	<%-- <td>
                    	<input value="<%=rsC.getString("category")%>" name="category" />
                	</td>
                	 --%>
                	
                    <td><select name="category">
                    <option selected="<%=rsC.getString("category")%>"><%=rsC.getString("category")%></option>
			 		<%	
			 			rsCate = statement.executeQuery("SELECT name FROM categories"); 
			 			while(rsCate.next()) {
			  		%>
			  		<option value=<%= rsCate.getString("name") %>><%= rsCate.getString("name")%></option>
			  		<%
			  		}
			   			%>
					</select>
					</td>
                    <td>
                    	<input value="<%=rsC.getFloat("price")%>" name="price" size="10"/>
                	</td>

                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                
                <form action="Products.jsp" method="POST">
                	<input type="hidden" name="action" value="delete"/>
                	<input type="hidden" value="<%=rsC.getInt("id")%>" name="id"/>
          			<td><input type="submit" value="Delete"/></td>     
                </form>
           
            </tr>
            <%
                }
            %>
            </table>
			<% 
            }
            %>
       		
       		
            

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rsCate.close();
            	/* rsC.close(); */
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
				if (rsCate != null) {
                    try {
                    	rsCate.close();
                    } catch (SQLException e) { } // Ignore
                    rsCate = null;
                }
				if (rsC != null) {
                    try {
                    	rsC.close();
                    } catch (SQLException e) { } // Ignore
                    rsC = null;
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
</body>

</html>
