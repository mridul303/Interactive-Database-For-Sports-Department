<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*"
	     import = "java.util.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String dbname="";
	String newDB = "";
	int year = 0;
	boolean even = true;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meta_data","root","");
		ps = con.prepareStatement("select Curr_db from dbname");
		rs = ps.executeQuery();	
		year = Calendar.getInstance().get(Calendar.YEAR);
		if(rs.next() == false){
		out.println("No Current Database");	
		}
		rs.last();
		dbname = rs.getString("Curr_db");
		try{
			int n = Integer.parseInt(Character.toString(dbname.charAt(3)));
			
		}
		catch(Exception e){
			even = false;
		}
		if(even){
			newDB = "EVEN";
			year++;
			newDB = newDB + year;
		}
		else{
			newDB = "ODD";
			newDB = newDB + year;
		}
		ps = con.prepareStatement("insert into dbname values (?,?)");
		ps.setString(1,newDB);
		ps.setString(2,dbname);
		ps.executeUpdate();
	}
	catch(Exception e){
		e.getMessage();
	}
%>

</body>
</html>