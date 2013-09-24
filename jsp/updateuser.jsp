<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String id = request.getParameter("id");
String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String title = request.getParameter("title");
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sq = "UPDATE users SET first_name = '" + firstname + "',last_name = '" +lastname + "',title = '" + title + "',email = '" + email + "',password='"+ password+"' WHERE user_id = " + id;    
	stmt.executeUpdate(sq);
	
	out.println("Success");

} catch (Exception e) {
	out.println("Failed");
} finally {

	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}
%>
