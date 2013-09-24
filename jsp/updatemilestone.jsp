<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String id = request.getParameter("id");
String milestone_text = request.getParameter("milestone_text");
String milestone_date = request.getParameter("milestone_date");
String entered_by = request.getParameter("entered_by");

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
	
	
	String sq = "UPDATE milestones SET milestone_text = '" + milestone_text + "',milestone_date  = '" +milestone_date  + "',entered_by = " + entered_by + " WHERE milestone_id = " + id;    
	stmt.executeUpdate(sq);
	
	String sq2 = "SELECT proj_id FROM milestones WHERE milestone_id = "+id;
	rs2 = stmt.executeQuery(sq2);
	rs2.next();
	
	String val = rs2.getString("proj_id");
	
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
