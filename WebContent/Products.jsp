<%
		if (session.getAttribute("username")==null){
			%>
			
			<a href="/ACart//Login.jsp"> Please log in first </a>
			
			<% 
		} else{
		%>
<html>
<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            
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
            

            <%-- -------- SELECT Statement Code -------- --%>
            <%
            
            
                // Create the statement
                Statement statement = conn.createStatement();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rsCate = statement.executeQuery("SELECT id, name FROM categories"); 
             
                
            %>
<body>
	<h2>Products </h2> <a href="LoginRes.jsp">Go Back<a>
	<br>
	<table>
	           	<form action="ProductSearch.jsp" method="POST">
                    <input type="hidden" name="action" value="list"/>
                    <input type="hidden" name="cate" value="no"/>
		        	<input type="hidden" name="cateid" value="0"/>
                
                    <input value="" name="search" size="30"/>
                    <input type="submit" value="Search"/>
                </form>
	    <tr>
	        
	        
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
		        			<input type="hidden" name="cateid" value="<%=rsCate.getString("id")%>"/>
		                    <th><input type="submit" value="<%=rsCate.getString("name")%>"/></th>
		        	</form>
		        </tr>
		        <%
		        	}
		        %>
		        
		        <tr>
		        	<form action="ProductSearch.jsp" method="POST">
		        			<input type="hidden" name="action" value="list"/> 
		        			<input type="hidden" name="cateid" value="0"/>
		        			<input type="hidden" name="cate" value="All"/>
		                    <th><input type="submit" value="All"/></th>
		        	</form>
		        </tr>
		        
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
                    <th><select name="categoryid">
			 		<%	
			 			rsCate = statement.executeQuery("SELECT name, id FROM categories"); 
			 			while(rsCate.next()) {
			  		%>
			  		<option value=<%=  rsCate.getString("id")%>><%= rsCate.getString("name")%></option>
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
		}
            %>
        
</table>

</body>

</html>
