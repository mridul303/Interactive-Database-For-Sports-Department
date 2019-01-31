<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<%@ page import = "java.io.IOException" import = "java.sql.*" import = "myProj.Simple" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
.yo{
 font-family: "Comic Sans MS", cursive, sans-serif;

}

</style>
</head>
<body>


<%
	
try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meta_data","root","");
	PreparedStatement ps = con.prepareStatement("select Curr_db from dbname");
	ResultSet rs = ps.executeQuery();
	if(rs.next() == false){
		out.println("No Current Database");
		
	} 

	else{
		String cd = rs.getString("Curr_db");
		
		String usn =request.getParameter("usn");
		
		String fname =request.getParameter("fname");
		
		String lname=request.getParameter("lname");
	
		String sem=request.getParameter("sem");
	
		String gender=request.getParameter("gender");
		
		String branch=request.getParameter("branch");
	
		String number =request.getParameter("number"); 
		
		String sport=request.getParameter("game");
		
		String coc =request.getParameter("coc");
				
		String tn =request.getParameter("tn");
	
		String tournament=request.getParameter("tournament");
	
		String type=request.getParameter("type");
		
		String host=request.getParameter("hosted");
					
		String sd=request.getParameter("sd");
		
		String ed=request.getParameter("ed");
		
		//String Result=request.getParameter("position");
	
		Simple s = new Simple();
		s.NewEntry(cd,usn, fname, lname, sem, gender, branch,sport,coc,tn,tournament,type,host,number,sd,ed);
		
		}
}
catch(Exception e){
		
	 System.out.println(e);
}  



%>

<h1 class="yo"><a href="http://localhost:8081/myProj/ManagementSection/index.html">Admin Page</a></h1>
					
</body>
</html>