<%@ page import="java.sql.*,java.util.ArrayList,org.apache.derby.jdbc.*" %>


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
	

		String sq = "SELECT * FROM projects WHERE proj_id = " + id;
		rs = stmt.executeQuery(sq);
		rs.next();
		
		
		out.println(rs.getString("proj_name"));
	
		
	
	

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


