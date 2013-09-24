<%@ page import="java.sql.*,java.util.ArrayList,org.apache.derby.jdbc.*" %>


<%

String email = request.getParameter("email");

Connection conn = null;
Statement stmt = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sql = "SELECT user_id FROM users WHERE email = '" + email + "'";
	rs1 = stmt.executeQuery(sql);
	rs1.next();
	
	String sq2 = "SELECT proj_id FROM project_teams WHERE user_id = " + rs1.getString("user_id");
	rs2 = stmt.executeQuery(sq2);
	
	
	ArrayList<String> x = new ArrayList<String>();
	while(rs2.next()){
		x.add(rs2.getString("proj_id"));
	}
	
	out.println(x);
	
	
	

} catch (Exception e) {
	out.println("<hr>" + e.getMessage() + "<hr>");
} finally {

	if (rs1 != null && rs2 != null && rs3!=null)
	{	rs1.close();rs2.close();rs3.close();
	}
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}
%>


