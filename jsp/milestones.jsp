<%@ page import="java.sql.*,java.util.ArrayList,org.apache.derby.jdbc.*" %>


<%


String index = request.getParameter("index");
out.println(index);

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
		String id;
		String sq = "SELECT * FROM milestones WHERE proj_id = " + index.substring(index.length()-1);
		rs = stmt.executeQuery(sq);
		
		out.println("<table><tr><td><b>milestone_id:</b></td><td><b>milestone_date:</b></td><td><b>milestone_text</b></td><td><b>enter_by</b></td><td><b>Edit/Add/Delete</b></td>");
		
		while(rs.next()){
		id=rs.getString("milestone_id");
		out.println("<tr><td>"+rs.getString("milestone_id")+"</td><td>"+ rs.getString("milestone_date")+"</td><td>" + rs.getString("milestone_text")+"</td><td>" + rs.getString("entered_by")+"</td>");
		out.println("<td><input type='button' value='E' class='editbutton' id='edit_"+id+"'>");
		out.println("<input type='button' value='A' class='addbutton' id='add_"+id+"'>");
		out.println("<input type='button' value='D' class='deletebutton' id='delete_"+id+"'></td></tr>");
		}
	

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


