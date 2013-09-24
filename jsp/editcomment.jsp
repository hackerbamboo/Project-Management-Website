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
	
	String sq = "SELECT * FROM comments WHERE comment_id = " + id;
	rs = stmt.executeQuery(sq);
	rs.next();
	
	out.println("<input type='hidden' value='"+rs.getString("comment_id")+"'>");
	out.println("<tr><td><b>Comment Text:</b></td><td><input type=\"text\" id='text_comment_"+id+"' value=\"" + rs.getString("comment_text") + "\">");
	out.println("<tr><td><b>Comment Date:</b></td><td><input type=\"text\" id='date_comment_"+id+"'  value=\"" + rs.getString("comment_date") + "\">");
	out.println("<br><br><input type='button' class='Button' id='edit_comment_"+ id +"' value='Save'>");
	
	
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