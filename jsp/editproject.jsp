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
	
	String sq = "SELECT * FROM projects WHERE proj_id = " + id;
	rs = stmt.executeQuery(sq);
	rs.next();
	
	out.println("<input type='hidden' value='"+rs.getString("proj_id")+"'>");
	out.println("<tr><td><b>Project Name:</b></td><td><input type=\"text\" id='name_proj_"+id+"' value=\"" + rs.getString("proj_name") + "\">");
	out.println("<tr><td><b>Project Number:</b></td><td><input type=\"text\" id='number_proj_"+id+"'  value=\"" + rs.getString("proj_number") + "\">");
	out.println("<tr><td><b>Billing Code:</b></td><td><input type=\"text\" id='billing_proj_"+id+"'  value=\"" + rs.getString("billing_code") + "\">");
	out.println("<tr><td><b>Project Description:</b></td><td><textarea rows='6' cols='25' id='description_proj_"+id+"'>"+ rs.getString("proj_description") + "</textarea>");
	out.println("<tr><td><b>Client Name:</b></td><td><input type=\"text\" id='client_proj_"+id+"' value=\"" + rs.getString("client_name") + "\">");
	out.println("<tr><td><b>Timeframe:</b></td><td><input type=\"text\" id='timeframe_proj_"+id+"'  value=\"" + rs.getString("timeframe") + "\">");
	out.println("<br><br><input type='button' class='Button' id='edit_proj_"+ id +"' value='Save'>");
	
	
	
	
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