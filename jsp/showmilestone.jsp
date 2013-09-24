<%@ page import="java.sql.*,java.util.ArrayList,org.apache.derby.jdbc.*" %>


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
	
		out.println("<input type='hidden' value='"+id+"' >");
	
		
		String sq = "SELECT * FROM milestones WHERE proj_id = " + id;
		rs = stmt.executeQuery(sq);
		
		
		out.println("<div id='accordion_proj_"+id+"' class='accordion'>");
		out.println("<h3><a href=\"#\">Milestone</a></h3>");
		out.println("<div id='milestone_proj_" + id+"'>");
				
		out.println("<table cellpadding=\"3\"><tr><td><b>Id:</b></td><td><b>Date:</b></td><td><b>Milestone</b></td><td><b>Edit By</b></td><td><b>Edit/Delete</b></td>");
		String mile_id;
		while(rs.next()){
		mile_id=rs.getString("milestone_id");
		out.println("<tr id='mile_number_"+mile_id+"'><td>"+rs.getString("milestone_id")+"</td><td>"+ rs.getString("milestone_date")+"</td><td>" + rs.getString("milestone_text")+"</td><td>" + rs.getString("entered_by")+"</td>");
		out.println("<td><input type='button' value='Edit' class='me_button' id='m_edit_"+mile_id+"'>");
		out.println("<input type='button' value='Delete' class='md_button' id='m_delete_"+mile_id+"'></td></tr>");
		}
		out.println("</table><input type='button' value='Add' class='ma_button' id='m_add_proj"+id+"'></div>");
	
	
	
	
		String com_id;
		String sq2 = "SELECT * FROM comments WHERE proj_id = " + id;
		rs2 = stmt2.executeQuery(sq2);
		
		out.println("<h3><a href=\"#\">Comments</a></h3>");
		out.println("<div id='comment_proj_" + id+"'>");
				
		out.println("<table cellpadding=\"3\"><tr><td><b>Id:</b></td><td><b>Date:</b></td><td><b>Comment</b></td><td><b>Edit By</b></td><td><b>Edit/Delete</b></td>");
		
		while(rs2.next()){
		com_id=rs2.getString("comment_id");
		out.println("<tr id='com_number_"+com_id+"'><td>"+rs2.getString("comment_id")+"</td><td>"+ rs2.getString("comment_date")+"</td><td>" + rs2.getString("comment_text")+"</td><td>" + rs2.getString("entered_by")+"</td>");
		out.println("<td><input type='button' value='Edit' class='ce_button' id='c_edit_"+com_id+"'>");
		out.println("<input type='button' value='Delete' class='cd_button' id='c_delete_"+com_id+"'></td></tr>");
		}
		out.println("</table><input type='button' value='Add' class='ca_button' id='c_add_proj"+id+"'></div>");
	
	    out.println("</div>");
		

} catch (Exception e) {
	out.println("<hr>" + e.getMessage() + "<hr>");
} finally {

	if (rs != null && rs2 !=null)
	{	rs.close();rs2.close();
	}
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}
%>


