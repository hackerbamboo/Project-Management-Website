<%@ page import="java.sql.*,java.util.ArrayList,org.apache.derby.jdbc.*" %>


<%

String index = request.getParameter("index");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	

		String sq = "SELECT * FROM projects WHERE proj_id = " + index;
		rs = stmt.executeQuery(sq);
		rs.next();
		
		
		
		
		String content= "<table cellpadding=\"3\"><tbody><tr><td><b>Project Name:</b></td><td>"+ rs.getString("proj_name")+"</td></tr><tr><td><b>Project Owner:</b></td><td>" +rs.getString("owner")+"</td></tr><tr><td><b>Project Number:</b></td><td>" + rs.getString("proj_number")+"</td></tr><tr><td><b>Billing Code:</b></td><td>" + rs.getString("billing_code")+"</td></tr><tr><td><b>Project Description:</b></td><td>"+ rs.getString("proj_description")+"</td></tr><tr><td><b>Client Name:</b></td><td>" + rs.getString("client_name")+"</td></tr><tr><td><b>Timeframe:</b></td><td>" + rs.getString("timeframe")+"</td></tr><tbody></table>";
		
		
		out.println(content);
	
	

} catch (Exception e) {
	out.println("<hr>" + e.getMessage() + "<hr>");
} finally {

	if (rs != null)
	{	rs.close();
	}
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}
%>


