<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>
<%@ page contentType="application/json; charset=iso-8859-1"%>
<%

String user_id = request.getParameter("user_id");

Connection conn = null;
Statement stmt1 = null;
ResultSet rs1 = null;
Statement stmt2 = null;
ResultSet rs2 = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt1 = conn.createStatement();
	stmt2 = conn.createStatement();
	
	String sql1 = "SELECT proj_id "
			    + "FROM project_teams "
			    + "WHERE user_id = " + user_id;
				
	rs1 = stmt1.executeQuery(sql1);	
	
	out.println("{\"projects\" : [");
	
	int proj_count = 0;
	
	while(rs1.next()){
	
		String sql2 = "SELECT * "
					+ "FROM projects "
					+ "WHERE proj_id = "
					+ rs1.getString("proj_id");
					
		rs2 = stmt2.executeQuery(sql2);
		
		proj_count++;
		
		if(rs1.getRow() > 1){
			out.println(", ");
		}
		
		while(rs2.next()){
		
			out.print("{\"proj_id\" : \"" + rs2.getString("proj_id") + "\", ");
			out.print("\"owner\" : \"" + rs2.getString("owner") + "\", ");
			out.print("\"proj_name\" : \"" + rs2.getString("proj_name") + "\", ");
			out.print("\"proj_number\" : \"" + rs2.getString("proj_number") + "\", ");
			out.print("\"billing_code\" : \"" + rs2.getString("billing_code") + "\", ");
			out.print("\"proj_description\" : \"" + rs2.getString("proj_description") + "\", ");
			out.print("\"client_name\" : \"" + rs2.getString("client_name") + "\", ");
			out.print("\"timeframe\" : \"" + rs2.getString("timeframe") + "\"}");
		
		}
		

	}

	out.println("], \n");
	out.println("\"count\" : \"" + proj_count + "\"}");
	
} catch (Exception e) {
	out.println(e.getMessage());
} finally {

	if (rs1 != null)
		rs1.close();
	if (stmt1 != null)
		stmt1.close();
	if (rs2 != null)
		rs2.close();
	if (stmt2 != null)
		stmt2.close();
	if (conn != null)
		conn.close();
}
%>
