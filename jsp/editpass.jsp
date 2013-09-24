<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>
<form>
<table cellpadding="8">
<%

String id = request.getParameter("id");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sq = "SELECT * FROM users WHERE user_id = " + id;
	rs = stmt.executeQuery(sq);
	rs.next();
	
	out.println("<tr><td><b>First Name:</b></td><td><input type=\"text\" id=\"FirstName\" value=\"" + rs.getString("first_name") + "\">");
	out.println("<tr><td><b>Last Name:</b></td><td><input type=\"text\" id=\"LastName\"  value=\"" + rs.getString("last_name") + "\">");
	out.println("<tr><td><b>Title:</b></td><td><input type=\"text\" id=\"Title\"  value=\"" + rs.getString("title") + "\">");
	out.println("<tr><td><b>E-mail:</b></td><td><input type=\"text\" id=\"Email\"  value=\"" + rs.getString("email") + "\">");
	out.println("<br><br><input type='button' class='Button' value='Save'>");
	
	

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
</table>
</form>