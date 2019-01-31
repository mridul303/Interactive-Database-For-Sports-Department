<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import= "myProj.Update" import= "java.sql.*"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
<%!
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;


%>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meta_data", "root", "");
		ps = con.prepareStatement("select Curr_db from dbname");
		rs = ps.executeQuery();
	
		
		if(rs.next() == false){
			out.println("No Current Database");
			
		}
		
		else{
	
			String fd = rs.getString("Curr_db");
			String s1 =  request.getParameter("pos");
			int s2 = Integer.parseInt(request.getParameter("amt"));
			String s3 =  request.getParameter("tn");
			Update up = new Update(fd);
			up.updateResult(s1,s2,s3);
			out.println("SUCCESSFULLY UPDATED");
			
		}}
		catch(Exception e){
			e.getMessage();
		}



%>

<br>
<a href="http://localhost:8081/myProj/ManagementSection/index.html"><button>Admin Page</button></a>
</body>
</html>