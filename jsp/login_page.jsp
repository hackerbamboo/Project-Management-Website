<%@ page import="java.sql.*,java.lang.String.*, org.apache.derby.jdbc.*" %>

<%

String u_email = request.getParameter("u_email");
String u_pswd = request.getParameter("u_pswd");


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try
{

	Class.forName("org.apache.derby.jdbc.ClientDriver");
	String fullConnectionString = "jdbc:derby://localhost:1527/jQuerySprintLab";
	conn = DriverManager.getConnection(fullConnectionString);

	stmt = conn.createStatement();
	
	String sql = "SELECT email, password FROM users ORDER BY email";

	rs = stmt.executeQuery(sql);

	int count = 0;
	
	while(rs.next()){
		if(rs.getString("email").equalsIgnoreCase(u_email)){
			
			if(rs.getString("password").equalsIgnoreCase(u_pswd)){
				out.println("Success");
				break;
			}
			else{
				out.println("Wrong");
				
				break;
			}
		}
		else{
			count++;
		}
		
	}
	
	if(count>=6){
		out.println("No");
	}
	

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
