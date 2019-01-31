<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page 
 	import= "java.sql.*" 
 	%>
 	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.yo{
 font-family: "Comic Sans MS", cursive, sans-serif;

}

</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Details</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>
	<%!
		String u ="";
		String tn = "";
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
	u = request.getParameter("usn");
	tn = request.getParameter("tournament");
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
			//rs.close();
			//ps.close();
			//con.close();
			
			dbn = rs.getString("Curr_db");
			
			if(dbn.equals("EVEN2019"))
				year = Integer.parseInt(dbn.substring(4));
			else
				year = Integer.parseInt(dbn.substring(3));
				
		//	out.print(dbn);
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		
			Class.forName("com.mysql.jdbc.Driver");
			con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbn, "root", "");	
			
			u = u.toUpperCase();
			tn = tn.toUpperCase();
			
			String query = "SELECT student.*, tournament.*, result.PRIZE_AMT,result.POSITION FROM student , tournament NATURAL JOIN result  WHERE student.USN = ? AND tournament.TOURNAMENT_NAME = ? ";   
	        
			ps1 = con1.prepareStatement(query);
	        ps1.setString(1,u);
	        ps1.setString(2,tn);
	        rs1 = ps1.executeQuery();
	      //  out.println("\nyear"+year);	
				
			 if(rs1.next() == false){
					out.println("Invalid inputs");
				}    	
								 
				
				 
		 }


		}
	 catch(Exception e ){
		 out.println("Error101");
		 e.getMessage();
	}	
	%>

<h1 class="yo">Student Detail</h1>

<div class="limiter">
		<div class="container-table100">
			<div class="wrap-table100">
					<div class="table">

						<div class="row header">
							<div class="cell">
								USN
							</div>
							<div class="cell">
								FNAME
							</div>
							<div class="cell">
								LNAME
							</div>
							<div class="cell">
								SEMESTER
							</div>
								<div class="cell">
								GENDER
							</div>
								<div class="cell">
								MOBILE NUMBER
							</div>
								<div class="cell">
								BRANCH_ID
							</div>
								<div class="cell">
								YEAR
							</div>
								<div class="cell">
								TOURNAMENT_NAME
							</div>
								<div class="cell">
								TYPE
							</div>
								<div class="cell">
								HOSTED BY
							</div>	
							<div class="cell">
							START DATE	
							</div>	
							<div class="cell">
								END DATE
							</div>	
							<div class="cell">
							SPORT_NAME	
							</div>	
							<div class="cell">
								PRIZE_AMT
							</div>	
							<div class="cell">
								POSITION
							</div>
							
						
						</div>

						<div class="row">
							<div class="cell" data-title="Full Name">
								<%=rs1.getString("USN").toUpperCase() %>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("FNAME").toUpperCase()%>
							</div>
							<div class="cell" data-title="Job Title">
								<%=rs1.getString("LNAME").toUpperCase()%>
							</div>
							<div class="cell" data-title="Location">
								<%=rs1.getInt("semester")%>
							</div>
							<div class="cell" data-title="Age">
							<%=rs1.getString("gender").toUpperCase()%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("mobile_number")%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("branch_id").toUpperCase()%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getInt("year")%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("tournament_name").toUpperCase()%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("TYPE").toUpperCase()%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("hosted_by").toUpperCase()%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getDate("start_date")%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getDate("end_date")%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("sport_name").toUpperCase() %>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getInt("prize_amt")%>
							</div>
							<div class="cell" data-title="Age">
								<%=rs1.getString("position").toUpperCase() %>
							</div>
						</div>


					</div>
					<h1 class="yo"><a href="http://localhost:8081/myProj/Edit/Edit.html">Admin Page</a></h1>
					
			</div>
		</div>
	</div>


	

<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
	

	
	
</body>
</html>