package myProj;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Simple
{	
	Connection con;
	String url;
    String dbname;
	String driver;
	String username;
	String password;
	String prevdbname;
	
	
	
	
	public Simple()
	{
		
		con = null;
		url = "jdbc:mysql://localhost:3306/";
		dbname = "EVEN2019";
		driver = "com.mysql.jdbc.Driver";
		username = "root"; 
		password = "";
		prevdbname = null;
		
	}
	
	public void closeConnection(){
		if(con!=null){
			try{
				con.close();
			}
			catch(SQLException e){
				e.getMessage();
			}
		}
	}
	public void DeleteEntry(ResultSet rs) throws SQLException
	{
		ResultSet rs1 = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		try
		{
			ps1 = con.prepareStatement("SELECT * FROM HAS_PLAYED_IN WHERE USN = ? AND TOURNAMENT_NAME = ? AND YEAR = ?;");
			ps2 = con.prepareStatement("DELETE FROM HAS_PLAYED_IN WHERE USN = ? AND TOURNAMENT_NAME = ? AND YEAR = ?;");
		
			ps2.setString(1,rs.getString("USN"));
			ps2.setString(2,rs.getString("TOURNAMENT_NAME"));
			ps2.setInt(3,rs.getInt("YEAR"));
			ps2.executeQuery();
		
			ps1.setString(1,rs.getString("USN"));
			ps1.setString(2,rs.getString("TOURNAMENT_NAME"));
			ps1.setInt(3,rs.getInt("YEAR"));
			rs1 = ps1.executeQuery();
		
			if(!rs1.next())
			{
				PreparedStatement ps3 = con.prepareStatement("DELETE FROM STUDENT WHERE USN = ?;");
				ps3.setString(1,rs.getString("USN"));
				ps3.executeQuery();
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public void NewEntry(String dbn,String usn, String fname, String lname, String sem, String gender, String branch, String sports,String coach,String teamname , String tournament_name, String type, String hosted_by,String pnumber, String startdate, String enddate) throws SQLException
	{   
		ResultSet rs = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		PreparedStatement ps4 = null;
		PreparedStatement ps5 = null;
		PreparedStatement st = null;
		try
		{	Class.forName(driver);
			System.out.println(dbn);
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbn, "root", "");
			
			int year;
		
			usn.toUpperCase();
			fname.toUpperCase();
			lname.toUpperCase();
			int semester = Integer.parseInt(sem);
			gender.toUpperCase();
			branch.toUpperCase();
			sports.toUpperCase();
			tournament_name.toUpperCase();
			type.toUpperCase();
			hosted_by.toUpperCase();
			SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");  
			Date start_date = format.parse(startdate);
			Date end_date = format.parse(enddate);
			java.sql.Date sd = new java.sql.Date(start_date.getTime());
			java.sql.Date ed = new java.sql.Date(end_date.getTime());
			if(dbn.equals("EVEN2019"))
					year = Integer.parseInt(dbn.substring(4));
			else
				year = Integer.parseInt(dbn.substring(3));
			
			ps1 = con.prepareStatement("INSERT INTO STUDENT VALUES(?,?,?,?,?,?,?);");
			ps5 = con.prepareStatement("INSERT INTO SPORT VALUES(?,?,?);");
			ps2 = con.prepareStatement("INSERT INTO TOURNAMENT VALUES(?,?,?,?,?,?,?);");
			ps3 = con.prepareStatement("INSERT INTO PLAYS VALUES(?,?)");
			ps4 = con.prepareStatement("INSERT INTO HAS_PLAYED_IN VALUES(?,?,?);");
			
		//	Student
			ps1.setString(1,usn);
			ps1.setString(2,fname);
			ps1.setString(3,lname);
			ps1.setInt(4,semester);
			ps1.setString(5,gender);
			ps1.setString(6,pnumber);
			ps1.setString(7,branch);
			ps1.executeUpdate();
		
			//sport
			
			st = con.prepareStatement("select sport_name from SPORT");
			rs = st.executeQuery();
			int i=1;
		
			
				while(rs.next()){
					
					if(rs.getString("sport_name").equals(sports))
						{
							i--;
							break;
						}
				}
			
				if(i==1)
				{

					ps5.setString(1,sports);
					ps5.setString(2,coach);
					ps5.setString(3,teamname);
					ps5.executeUpdate();
				}	
				//plays
				
			ps3.setString(1,usn);
			ps3.setString(2,sports);
			ps3.executeUpdate();
				
			//tournament
			rs = null;
			PreparedStatement st1 = con.prepareStatement("select tournament_name, year from TOURNAMENT");
			rs = st1.executeQuery();

			i=1;
			
				while(rs.next()){
					String p = rs.getString("tournament_name");
					boolean b =rs.getInt("year")==(year);
					System.out.println("tournament WHILE\nRS="+p +"  \nuser input: "+tournament_name+"\nAfter c,paring = "+b);
					if(p.equals(tournament_name) && rs.getInt("year")==(year))
						{
							i--;
							System.out.println("WALAH TOURN");
							break;
						}
				}
			
			
			if(i==1)
			{
				
				ps2.setInt(1,year);
				ps2.setString(2,tournament_name);
				ps2.setString(3,type);
				ps2.setString(4,hosted_by);
				ps2.setDate(5,sd);
				ps2.setDate(6,ed);
				ps2.setString(7,sports);
				ps2.executeUpdate();	
			}
			//hasplayed
					
			ps4.setString(1,usn);
			ps4.setInt(2,year);
			ps4.setString(3,tournament_name);
			ps4.executeUpdate();
			
			System.out.println("Student details entered");
			con.close();
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage()+"  oi");
		}
		
	}
	
	public void Initialize() throws SQLException
	{	Connect();
		try
		{
			con = DriverManager.getConnection(url+prevdbname,username,password);
			Statement s = con.createStatement();
		
			ResultSet rs1 = s.executeQuery("SELECT * FROM BRANCH;");
			ResultSet rs2 = s.executeQuery("SELECT * FROM SPORT;");
			PreparedStatement ps1 = con.prepareStatement("INSERT INTO BRANCH VALUES(?,?,?,?);");
			PreparedStatement ps2 = con.prepareStatement("INSERT INTO SPORT VALUES(?,?,?);");
			
		
			con = DriverManager.getConnection(url+dbname,username,password);
		
			while(rs1.next())
			{
				ps1.setString(1,rs1.getString("BRANCH_ID"));
				ps1.setString(2,rs1.getString("BRANCH_NAME"));
				ps1.setString(3,rs1.getString("HOD_NAME"));
				ps1.setString(4,rs1.getString("EMAIL_OF_HOD"));
				ps1.executeUpdate();
			}
			
			while(rs2.next())
			{
				ps2.setString(1,rs2.getString("SPORT_NAME"));
				ps2.setString(2,rs2.getString("COACH_NAME"));
				ps2.setString(3,rs2.getString("MEMBER_OF_TEAM"));
				ps2.executeUpdate();
			}
			
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
	}
	
	public void CreateTables() throws SQLException
	{	
		
		Connect();

		try
		{	System.out.println("3");
			String sql1 = "CREATE TABLE STUDENT(USN VARCHAR(10) NOT NULL PRIMARY KEY, FNAME VARCHAR(20), LNAME VARCHAR(20), SEMESTER INTEGER, GENDER CHAR(1),MOBILE_NUMBER VARCHAR(20));";
			String sql2 = "CREATE TABLE SPORT(SPORT_NAME VARCHAR(20) NOT NULL PRIMARY KEY, COACH_NAME VARCHAR(40), TEAM_NAME VARCHAR(20))";
			String sql3 = "CREATE TABLE PLAYS(USN VARCHAR(20) REFERENCES STUDENT(USN) ON DELETE CASCADE,SPORT_NAME VARCHAR(20) REFERENCES SPORT(SPORT_NAME) ON DELETE CASCADE,FOREIGN KEY(USN,SPORT_NAME)) ";
			String sql4 = "CREATE TABLE BRANCH(BRANCH_ID VARCHAR(5) NOT NULL PRIMARY KEY, BRANCH_NAME VARCHAR(50), HOD_NAME VARCHAR(40), EMAIL_OF_HOD VARCHAR(40));";
			String sql5 = "ALTER TABLE STUDENT ADD BRANCH_ID VARCHAR(5) REFERENCES BRANCH(BRANCH_ID);";
			
			String sql6 = "CREATE TABLE TOURNAMENT(YEAR INTEGER,TOURNAMENT_NAME VARCHAR(50),TYPE VARCHAR(20),HOSTED_BY VARCHAR(50), START_DATE DATE, END_DATE DATE, SPORT_NAME VARCHAR(20), FOREIGN KEY(SPORT_NAME) REFERENCES SPORT(SPORT_NAME) ON DELETE CASCADE, PRIMARY KEY(YEAR,TOURNAMENT_NAME));";
			String sql7 = "CREATE TABLE HAS_PLAYED_IN(USN VARCHAR(10) , FOREIGN KEY(USN) REFERENCES STUDENT(USN) ON DELETE CASCADE, YEAR INTEGER, TOURNAMENT_NAME VARCHAR(50), FOREIGN KEY(YEAR,TOURNAMENT_NAME) REFERENCES TOURNAMENT(YEAR,TOURNAMENT_NAME) ON DELETE CASCADE);";
			String sql8 = "CREATE TABLE RESULT(YEAR INTEGER, TOURNAMENT_NAME VARCHAR(50), PRIZE_AMT INTEGER, POSITION VARCHAR(20), FOREIGN KEY(YEAR,TOURNAMENT_NAME) REFERENCES TOURNAMENT(YEAR,TOURNAMENT_NAME) ON DELETE CASCADE);";

			Statement s = con.createStatement();

			s.executeUpdate(sql1);
			s.executeUpdate(sql2);
			s.executeUpdate(sql3);
			s.executeUpdate(sql4);
			s.executeUpdate(sql5);
			s.executeUpdate(sql6);
			s.executeUpdate(sql7);
			s.executeUpdate(sql8);
			s.close();
			
			System.out.println("Tables Have Been Created");
			
			con.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public void Connect() throws SQLException
	{
		
		try
		{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url+dbname, username,password);
			
			if (!con.isClosed())
				System.out.println("Successfully Connected to MySQL Server.");
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}

	public String CreateDatabase() throws SQLException
	{  
	    try
	    {
	    	Class.forName(driver);
	    	con = DriverManager.getConnection(url,username,password);
	    	Statement s = con.createStatement();
	    	
	    	prevdbname = dbname;
	    	if(dbname.substring(0,4).equals("EVEN"))
	    	{
	    		dbname = "ODD"+dbname.substring(4);
	    	}
	    	
	    	else if(dbname.substring(0,4).equals("ODD_"))
	    	{
	    		int yr = Integer.parseInt(dbname.substring(4));
	    		yr++;
	    		dbname = "EVEN"+yr;
	    	}
	    	
	    	
	    	
	    	s.executeUpdate("CREATE DATABASE "+dbname);
	    	
	    	System.out.println("Database Created");
	    	
	    	con.close();
	    	
	    }
	    catch(Exception e)
	    {
	    	System.out.println(e.getMessage()+" 1");
	    }
	    
	    return dbname;
	}
	
	public void DropDatabase() throws SQLException
	{
	    try
	    {
	    	Class.forName(driver);
	    	con = DriverManager.getConnection(url,username,password);
	    	Statement s = con.createStatement();
	    	s.executeUpdate("DROP DATABASE "+dbname);
	    	System.out.println("Database Dropped");
	    	con.close();
	    }
	    catch(Exception e)
	    {
	    	System.out.println(e.getMessage());
	    }
	}
}
