<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>
 	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!
		String bid ="";
		String bn = "";
		String hn="";
		String hid="";
		String dbn="";
		int year = 0;
		
		Connection con;
		Connection con1;
		PreparedStatement ps;
		PreparedStatement ps1;
		ResultSet rs;
		ResultSet rs1;

		int f1=0;
	%>

	<%
		bid = request.getParameter("bid").toUpperCase();
		bn = request.getParameter("bn").toUpperCase();
		hn = request.getParameter("hn").toUpperCase();
		hid = request.getParameter("hid").toUpperCase();
	%>
	
	
	
	<%
	try{
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meta_data", "root", "");
		ps = con.prepareStatement("select Curr_db from dbname");
		rs = ps.executeQuery();
		
		if(rs.next() == false)
		{
			out.println("No Current Database");	
		}
		
		else
		{		
			dbn = rs.getString("Curr_db");
			
			if(dbn.equals("EVEN2019"))
				year = Integer.parseInt(dbn.substring(4));
			else
				year = Integer.parseInt(dbn.substring(3));
				
		//	out.print(dbn);
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		
			Class.forName("com.mysql.jdbc.Driver");
			con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbn, "root", "");	
			
			String q = "INSERT INTO	branch VALUES(?,?,?, ?)";
			
			ps1 = con1.prepareStatement(q);
	        ps1.setString(1,bid);
	        ps1.setString(2,bn);
	        ps1.setString(3,hn);
	        ps1.setString(4,hid);
	        ps1.executeUpdate();
	
		}}
	 catch(Exception e ){
		 out.println("Error101");
		 e.getMessage();
	}	
	%>
	
	
	INSERTON DONE <br>
	ENTER TO RETURN BACK:	
	<a href="http://localhost:8081/myProj/ManagementSection/index.html"><button>Admin Page</button></a>
</body>
</html>