<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<table cellpadding="6">
<%

String email = request.getParameter("email");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sql = "SELECT * FROM users WHERE email = '" + email + "'";


	rs = stmt.executeQuery(sql);
	rs.next();

	out.println("<input type='hidden' id='user_id' value='"+rs.getString("user_id")+"'>");
	out.println("<tr><td><b>First Name:</b></td><td>"+ rs.getString("first_name")+"</td></tr>");
	out.println("<tr><td><b>Last Name:</b></td><td>" + rs.getString("last_name")+"</td></tr>");
	out.println("<tr><td><b>Title:</b></td><td>" + rs.getString("title")+"</td></tr>");
	out.println("<tr><td><b>E-mail:</b></td><td>" + rs.getString("email")+"</td></tr>");
	



	

} catch (Exception e) {
	out.println("<hr>" + e.getMessage() + "<hr>");
} finally {

	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}
%>
</table>

