<html>
<title>Products Browsing</title>



	<%
	if (session.getAttribute("username")==null){
		%>
		
		<a href="/ACart//Login.html"> Please log in first </a>
		
		<% 
	} else {
		%>
		Hello, <%= session.getAttribute("username")%>
		<% 
	/* } */
	String action = request.getParameter("action");
	/* String cate = null; */
	if (action != null && action.equals("list")) {
		session.setAttribute("cate", request.getParameter("cate"));
		if (!((String)(session.getAttribute("cate"))).equals("no")){
			session.setAttribute("realcate", request.getParameter("cate"));
		
		}
	}
%>

<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            
            PreparedStatement pstmt = null; 
            PreparedStatement pstmtL = null; 

            ResultSet rsCate = null;
            ResultSet rsC = null;
            
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
                rsCate = statement.executeQuery("SELECT name FROM categories"); 
             
                
            %>
<body>
	<h2>Products</h2>
	<table>
		<tr>
	           	<form action="ProductBrowse.jsp" method="POST">
                    <input type="hidden" name="action" value="list"/>
                    <input type="hidden" name="cate" value="no"/>
                    <input value="" name="search" size="30"/>
                    <input type="submit" value="Search"/>
                </form>
	    </tr>
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
		        
		        	<form action="ProductBrowse.jsp" method="POST">
		        			<input type="hidden" name="action" value="list"/> 
		        			<input type="hidden" name="cate" value="<%=rsCate.getString("name")%>"/>
		                    <th><input type="submit" value="<%=rsCate.getString("name")%>"/></th>
		        	</form>
		        </tr>
		        <%
		        	}
		        %>
		        
		        <tr>
		        	<form action="ProductBrowse.jsp" method="POST">
		        			<input type="hidden" name="action" value="list"/> 
		        			<input type="hidden" name="cate" value="All"/>
		                    <th><input type="submit" value="All"/></th>
		        	</form>
		        </tr>
		        
		        </table>
	        </td>
	        
	        <td>
                    <tr>
       Category:
	<%
	if((session.getAttribute("realcate")==null)) {
	%>
		All
	<% 
	} else {
	%>
	<%=session.getAttribute("realcate") %>
	<% 
	}
	%>  
	</tr>
            </td>
            
                         
	
	
	
            
            
            
            
    </tr>
    
            
            
            <%-- -------- LIST Code -------- --%>
            <%
/*                  action = request.getParameter("action");
 */                // Check if an insertion is requested
                if (action != null && action.equals("list")) {                	
                	
                	if (((String) (session.getAttribute("cate"))).equals("All")) {
						 pstmtL = conn.prepareStatement("SELECT * FROM products");
                 	     rsC = pstmtL.executeQuery(); 
					} else if (((String) (session.getAttribute("cate"))).equals("no")) {
                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    	if (session.getAttribute("realcate")==null || ((String) (session.getAttribute("realcate"))).equals("All")) {
                    		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ?");
 	                    	pstmtL.setString(1, "%" + request.getParameter("search") + "%");
                        	rsC = pstmtL.executeQuery(); 
                    	} else {
                    		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ? AND category = ?");
 	                    	pstmtL.setString(1, "%" + request.getParameter("search") + "%");
 	                    	pstmtL.setString(2, (String) (session.getAttribute("realcate"))); 
							rsC = pstmtL.executeQuery(); 
                    	}
					} else {
                        pstmtL = conn.prepareStatement("SELECT * FROM products WHERE products.category = ?");
 						pstmtL.setString(1, (String) (session.getAttribute("cate")));                    
                        rsC = pstmtL.executeQuery(); 
					}
               
             %>
             <!-- <table border="1">
            <tr>
            	<th>IDD</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr> -->
             <% 
                if(
/*                 		(!((String)(session.getAttribute("cate"))).equals("no")) && (rsC.next())
 */                		!(rsC.next())
 						|| ((String)(session.getAttribute("cate"))).equals("no") && (request.getParameter("search").equals(""))
 				){                
                	%>
                	<br>
                    Not found
                    <% 
                
                } else {
                // Iterate over the ResultSet
                
                %>
                <tr>
            	<table border="1">
            <tr>
            	<th>IDD</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr>
                <% 
                rsC = pstmtL.executeQuery(); 
                while (rsC.next()) {
            %>

            <tr>
                <form action="ProductOrder.jsp" method="POST">
                    <input type="hidden" name="action" value="addtocart"/>
                    <input type="hidden" name="id" value="<%=rsC.getInt("id")%>"/>

                <%-- Get the id --%>
					<td>
                    	<%=rsC.getInt("id")%>
                	</td>
                    <td>
                    	<%=rsC.getString("name")%>
                	</td>
                	<td>
                    	<%=rsC.getInt("sku")%>
                	</td>
                	
                    <td>
                    	<%=rsC.getString("category")%>
					</td>
                    <td>
                    	<%=rsC.getFloat("price")%>
                	</td>

                <%-- Button --%>
                <td><input type="submit" value="Add To Cart"></td>
                </form>
                
           
            </tr>
            <%
                }
                }
            }
            %>
            </table>
            
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
