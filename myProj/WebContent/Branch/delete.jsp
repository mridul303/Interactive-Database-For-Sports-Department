<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<title>Insert title here</title>
</head>
<body>


<%!
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		int year=0;
		String dbname="";
		String bid;
%>
	<%
		bid= request.getParameter("bid").toUpperCase();
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
		
		String q = "delete from branch where branch_id = ? ";
		ps = con.prepareStatement(q);
		ps.setString(1,bid);
		ps.executeUpdate();
		
%>

<div class="alert alert-success">
    <strong>Success!</strong> The entry has been deleted.
  </div>
	<%}


	catch(Exception e){
		e.getMessage();
	}


%>
<h1 class="yo"><a href="http://localhost:8081/myProj/ManagementSection/index.html">Admin Page</a></h1>
	





</body>
</html>