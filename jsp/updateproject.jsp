<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String id = request.getParameter("id");
String proj_name = request.getParameter("proj_name");
String proj_number = request.getParameter("proj_number");
String billing_code = request.getParameter("billing_code");
String proj_description = request.getParameter("proj_description");
String client_name = request.getParameter("client_name");
String timeframe = request.getParameter("timeframe");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sq = "UPDATE projects SET proj_name = '" + proj_name + "',proj_number = '" +proj_number + "',billing_code = '" + billing_code + "',proj_description = '" + proj_description + "',client_name='" +client_name+"',timeframe='"+timeframe+"' WHERE proj_id = " + id;    
	stmt.executeUpdate(sq);
	
	
	out.println(id+"Success");

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
