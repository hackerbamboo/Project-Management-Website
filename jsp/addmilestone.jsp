<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String proj_id = request.getParameter("id");
String milestone_text = request.getParameter("milestone_text");
String milestone_date = request.getParameter("milestone_date");
String entered_by = request.getParameter("user");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);
	
	stmt = conn.createStatement();
	
	String sq = "INSERT INTO milestones (proj_id, milestone_date, milestone_text, entered_by) VALUES ("+proj_id+",'"+milestone_date+"','"+milestone_text+"',"+ entered_by+")";
	stmt.executeUpdate(sq);
	
	out.println(proj_id+"Success");
	
	

} catch (Exception e) {
	out.println("Failed");
} finally {

	if ( rs!=null)
	{	rs.close();}
	if ( stmt!=null)
	{	stmt.close();}
	if (conn != null)
		conn.close();
}
%>
