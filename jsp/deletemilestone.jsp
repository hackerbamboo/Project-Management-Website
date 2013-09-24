<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String id = request.getParameter("id");

Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet rs = null;
ResultSet rs2 = null;
try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	stmt2 = conn.createStatement();
	
	
	String sq = "SELECT proj_id FROM milestones WHERE milestone_id = "+id;
	rs = stmt.executeQuery(sq);
	rs.next();
	String val = rs.getString("proj_id");
	
	String sq2 = "DELETE FROM milestones WHERE milestone_id = "+id;
	stmt2.executeUpdate(sq2);
	
	
	out.println(val+"Success");
	
	

} catch (Exception e) {
	out.println("Failed");
} finally {

	if (rs != null && rs2!=null)
	{	rs.close();rs2.close();}
	if (stmt != null && stmt2!=null)
	{	stmt.close();stmt2.close();}
	if (conn != null)
		conn.close();
}
%>
