<%@ page import="java.sql.*,java.lang.String.*, org.apache.derby.jdbc.*" %>

<%

String first_f = request.getParameter("first_f");
String last_f = request.getParameter("last_f");
String email_f = request.getParameter("email_f");
String password_f = request.getParameter("password_f");


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sql = "INSERT INTO users (first_name, last_name, email, password) VALUES (first_f, last_f, email_f, password_f);";

	rs = stmt.executeQuery(sql);

	
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
