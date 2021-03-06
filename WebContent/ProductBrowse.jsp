<html>
<title>Products Browsing</title>



	<%
	if (session.getAttribute("username")==null){
		%>
		
		<a href="/ACart//Login.jsp"> Please log in first </a>
		
		<% 
	} else {
		%>
		
<div>
      <span style="float:right">
      	<a href="BuyShoppingCart.jsp">Buy Shopping Cart<a>
      </span>
      Hello, <%= session.getAttribute("username")%> 
      <a href="Login.jsp">Log out<a>
      <br/>
</div>
		<% 
	/* } */
	String action = request.getParameter("action");
	/* String cate = null; */
	if (action != null && action.equals("list")) {
		session.setAttribute("cate", request.getParameter("cate"));
		session.setAttribute("cateid", request.getParameter("cateid"));
		if (!((String)(session.getAttribute("cate"))).equals("no")){
			session.setAttribute("realcate", request.getParameter("cate"));
			session.setAttribute("realcateid", request.getParameter("cateid"));
			session.setAttribute("search", null);
		} else {
			session.setAttribute("search", request.getParameter("search"));
		}
	}
	
	
	
	
%>
	<%-- Initialization of students and nextPID --%>
    <% if(session.getAttribute("cartitem")==null) 
         session.setAttribute("cartitem", new LinkedHashMap<String, Cartitem>());
       if(session.getAttribute("itemnumber")==null)
         session.setAttribute("itemnumber", 1);
       if(session.getAttribute("totalprice")==null)
           session.setAttribute("totalprice", 0.0);
       
    %>    
    
    <%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
    <% 
        // retrieves student data from session scope
        LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
    
        // retrieves the latest pid
        Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
    %>



<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*, cartitem.*, java.util.*"%>
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
                rsCate = statement.executeQuery("SELECT name, id FROM categories"); 
             
                
            %>
<body>
	<h2>Products</h2>
	<table>
		<tr>
	           	<form action="ProductBrowse.jsp" method="POST">
                    <input type="hidden" name="action" value="list"/>
                    <input type="hidden" name="cate" value="no"/>
                    <input type="hidden" name="cateid" value="no"/>
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
		        			<input type="hidden" name="cateid" value="<%=rsCate.getString("id")%>"/>
		                   
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
		        			<input type="hidden" name="cateid" value="0"/>
		        			
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
    		<%-- -------- ADD TO CARD Code -------- --%>
    <%       
       // Check if an insertion is requested
       if (action != null && action.equals("addtocart")) {
                    
          // make new student to add to students map
       		 Cartitem newCartitem = new Cartitem(); 
          	
          	 if (!(cartitem.get(request.getParameter("itemname"))==null)){
       				newCartitem = cartitem.get(request.getParameter("itemname"));
     		       	newCartitem.setAmount( (cartitem.get(request.getParameter("itemname"))).getAmount()+ Integer.parseInt(request.getParameter("amount")));                   
     		       	itemnumber--;
          	 } else {
	          // add the attributes from the request object to new student
	           newCartitem.setId(Integer.parseInt(request.getParameter("id")));                   
			   newCartitem.setNo(Integer.parseInt(request.getParameter("no")));                   
	           newCartitem.setItemname(request.getParameter("itemname"));
	           newCartitem.setPrice(Float.parseFloat(request.getParameter("price")));
		       newCartitem.setAmount(Integer.parseInt(request.getParameter("amount")));                   
	          // add new student to the map
       		  } cartitem.put(request.getParameter("itemname"), newCartitem);
	           itemnumber++;
	           session.setAttribute("itemnumber", itemnumber);
         }
     %>
    
    
    
            
            
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
 	                    	pstmtL.setString(1, "%" + (String)(session.getAttribute("search")) + "%");
                        	rsC = pstmtL.executeQuery(); 
                    	} else {
                    		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ? AND categoryid = ?");
 	                    	pstmtL.setString(1, "%" + (String)(session.getAttribute("search")) + "%");
 	                        pstmtL.setInt(2, Integer.parseInt((String)(session.getAttribute("realcateid"))));
							rsC = pstmtL.executeQuery(); 
                    	}
					} else {
                        pstmtL = conn.prepareStatement("SELECT * FROM products WHERE products.categoryid = ?");
                        pstmtL.setInt(1, Integer.parseInt((String)(session.getAttribute("cateid"))));
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
                	<tr>
                	<br>
                    Not found
                    </tr>
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
                    <input type="hidden" name="action" value="preaddtocart"/>
                    <input type="hidden" name="preitemname" value="<%=rsC.getString("name")%>"/>
                    <input type="hidden" name="preprice" value="<%=rsC.getInt("price")%>"/>
					<input type="hidden" name="preid" value="<%=rsC.getInt("id")%>"/>
                    

                <%-- Get the id --%>
					<td>
                    	<%=rsC.getInt("id")%>
                	</td>
                    <td>
                    	<%=rsC.getString("name")%>
                	</td>
                	<td>
                    	<%=rsC.getString("sku")%>
                	</td>
                	
                    <td>
                    	<%
                    	rsCate = statement.executeQuery("SELECT name, id FROM categories"); 
			 			String curcate = null;
                    	while(rsCate.next()) {
			 				if (rsC.getInt("categoryid")==(rsCate.getInt("id"))){
                    			curcate = rsCate.getString("name");
			 				}
                    	}
                    	
                    	%>
                    	<%=curcate%>
					</td>
                    <td>
                    	$<%=rsC.getFloat("price")%>
                	</td>

                <%-- Button --%>
                <td><input type="submit" value="Buy"></td>
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
            } catch (Exception e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
/*                 throw new RuntimeException(e);
 */
            	%>
            	<h2>Sorry</h2>
            	Please try again!
            	<br>
            <%
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
