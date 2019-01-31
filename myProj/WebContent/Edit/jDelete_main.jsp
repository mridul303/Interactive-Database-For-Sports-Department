<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.yo{
 font-family: "Comic Sans MS", cursive, sans-serif;

}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		int year=0;
		String dbname="";
%>
	<%
	String usn = request.getParameter("usn");


	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meta_data", "root", "");
		ps = con.prepareStatement("select Curr_db from dbname");
		rs = ps.executeQuery();	
		
		if(rs.next() == false){
		out.println("No Current Database");	
		}
		dbname = rs.getString("Curr_db");
		
	
	
		
	  if(dbname.equals("EVEN2019"))
			year = Integer.parseInt(dbname.substring(4));
		else
			year = Integer.parseInt(dbname.substring(3));
	}
	catch(Exception e){
		e.getMessage();
	}
	%>


<%
	try{
		
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname, "root", "");
		
		String q = "delete from student where usn = ? ";
		ps = con.prepareStatement(q);
		ps.setString(1,usn);
		ps.executeUpdate();
		
		out.print("Entry Deleted");
	}catch(Exception e){
		e.getMessage();
	}


%>
<h1 class="yo"><a href="http://localhost:8081/myProj/ManagementSection/index.html">Admin Page</a></h1>
	

</body>
</html>