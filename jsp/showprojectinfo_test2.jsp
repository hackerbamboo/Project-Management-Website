<%@ page import="java.sql.*,org.apache.derby.jdbc.*" %>

<%

String id = request.getParameter("id");

Connection conn = null;
Statement stmt0 = null;
Statement stmt1 = null;
Statement stmt_proj_1 = null;
Statement stmt_proj_2 = null;
Statement stmt_proj_3 = null;
ResultSet rs0 = null;
ResultSet rs1 = null;
ResultSet rs_proj_1 = null;
ResultSet rs_proj_2 = null;
ResultSet rs_proj_3 = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt0 = conn.createStatement();
	stmt1 = conn.createStatement();
	stmt_proj_1 = conn.createStatement();
	stmt_proj_2 = conn.createStatement();
	stmt_proj_3 = conn.createStatement();
	
	
	String sq0 = "SELECT user_id FROM users WHERE user_id = " + id;
	rs0 = stmt0.executeQuery(sq0);
	rs0.next();
	
	
	String sq1 = "SELECT proj_id FROM project_teams WHERE user_id = " + rs0.getString("user_id");
	rs1 = stmt1.executeQuery(sq1);
	rs1.next();
	
	
	String sq_proj_1 = "SELECT * FROM projects WHERE proj_id = " + rs1.getString("proj_id");
	rs_proj_1 = stmt_proj_1.executeQuery(sq_proj_1);
	rs_proj_1.next();
	
	rs1.next();
	
	String sq_proj_2 = "SELECT * FROM projects WHERE proj_id = " + rs1.getString("proj_id");
	rs_proj_2 = stmt_proj_2.executeQuery(sq_proj_2);
	rs_proj_2.next();
	
	rs1.next();
	
	String sq_proj_3 = "SELECT * FROM projects WHERE proj_id = " + rs1.getString("proj_id");
	rs_proj_3 = stmt_proj_3.executeQuery(sq_proj_3);
	rs_proj_3.next();
	
	
	out.println("<ul>");
	out.println("<li><a href='#tabs-"+rs_proj_1.getString("proj_id")+"'>"+rs_proj_1.getString("proj_name")+"</a></li>");
	out.println("<li><a href='#tabs-"+rs_proj_2.getString("proj_id")+"'>"+rs_proj_2.getString("proj_name")+"</a></li>");
	out.println("<li><a href='#tabs-"+rs_proj_3.getString("proj_id")+"'>"+rs_proj_3.getString("proj_name")+"</a></li>");
	out.println("</ul>");
		
	out.println("<div id='tabs-"+rs_proj_1.getString("proj_id")+"'>");	
	out.println("<table cellpadding=\"3\"><tbody><tr><td><b>Project Name:</b></td><td>"+ rs_proj_1.getString("proj_name")+"</td></tr><tr><td><b>Project Owner:</b></td><td>" +rs_proj_1.getString("owner")+"</td></tr><tr><td><b>Project Number:</b></td><td>" + rs_proj_1.getString("proj_number")+"</td></tr><tr><td><b>Billing Code:</b></td><td>" + rs_proj_1.getString("billing_code")+"</td></tr><tr><td><b>Project Description:</b></td><td>"+ rs_proj_1.getString("proj_description")+"</td></tr><tr><td><b>Client Name:</b></td><td>" + rs_proj_1.getString("client_name")+"</td></tr><tr><td><b>Timeframe:</b></td><td>" + rs_proj_1.getString("timeframe")+"</td></tr><tbody></table>");
	out.println("<input type='button' value='Detail' class='inButton' id='button_detail"+rs_proj_1.getString("proj_id")+"'>");	
	out.println("<input type='button' value='Edit' class='inButton' id='button_edit"+rs_proj_1.getString("proj_id")+"'>");	
	out.println("<div class='totalaccordion' style='display:none'></div>");
	out.println("</div>");
	
	out.println("<div id='tabs-"+rs_proj_2.getString("proj_id")+"'>");	
	out.println("<table cellpadding=\"3\"><tbody><tr><td><b>Project Name:</b></td><td>"+ rs_proj_2.getString("proj_name")+"</td></tr><tr><td><b>Project Owner:</b></td><td>" +rs_proj_2.getString("owner")+"</td></tr><tr><td><b>Project Number:</b></td><td>" + rs_proj_2.getString("proj_number")+"</td></tr><tr><td><b>Billing Code:</b></td><td>" + rs_proj_2.getString("billing_code")+"</td></tr><tr><td><b>Project Description:</b></td><td>"+ rs_proj_2.getString("proj_description")+"</td></tr><tr><td><b>Client Name:</b></td><td>" + rs_proj_2.getString("client_name")+"</td></tr><tr><td><b>Timeframe:</b></td><td>" + rs_proj_2.getString("timeframe")+"</td></tr><tbody></table>");
	out.println("<input type='button' value='Detail' class='inButton' id='button_detail"+rs_proj_2.getString("proj_id")+"'>");	
	out.println("<input type='button' value='Edit' class='inButton' id='button_edit"+rs_proj_2.getString("proj_id")+"'>");	
	out.println("<div class='totalaccordion' style='display:none'></div>");
	out.println("</div>");
	
	out.println("<div id='tabs-"+rs_proj_3.getString("proj_id")+"'>");	
	out.println("<table cellpadding=\"3\"><tbody><tr><td><b>Project Name:</b></td><td>"+ rs_proj_3.getString("proj_name")+"</td></tr><tr><td><b>Project Owner:</b></td><td>" +rs_proj_3.getString("owner")+"</td></tr><tr><td><b>Project Number:</b></td><td>" + rs_proj_3.getString("proj_number")+"</td></tr><tr><td><b>Billing Code:</b></td><td>" + rs_proj_3.getString("billing_code")+"</td></tr><tr><td><b>Project Description:</b></td><td>"+ rs_proj_3.getString("proj_description")+"</td></tr><tr><td><b>Client Name:</b></td><td>" + rs_proj_3.getString("client_name")+"</td></tr><tr><td><b>Timeframe:</b></td><td>" + rs_proj_3.getString("timeframe")+"</td></tr><tbody></table>");
	out.println("<input type='button' value='Detail' class='inButton' id='button_detail"+rs_proj_3.getString("proj_id")+"'>");	
	out.println("<input type='button' value='Edit' class='inButton' id='button_edit"+rs_proj_3.getString("proj_id")+"'>");	
	out.println("<div class='totalaccordion' style='display:none'></div>");
	out.println("</div>");
	
	
	
} catch (Exception e) {
	out.println("Failed");
} finally {

	if (rs0 != null && rs1!=null && rs_proj_1!=null && rs_proj_2!=null && rs_proj_3!=null)
	{	rs0.close();
		rs1.close();
		rs_proj_1.close();
		rs_proj_2.close();
		rs_proj_3.close();
		}
	if (stmt0 != null && stmt1!=null && stmt_proj_1!=null && stmt_proj_2!=null && stmt_proj_3!=null)
	{	stmt0.close();stmt1.close();stmt_proj_1.close();stmt_proj_2.close();stmt_proj_3.close();}
	if (conn != null)
		conn.close();
}
%>
