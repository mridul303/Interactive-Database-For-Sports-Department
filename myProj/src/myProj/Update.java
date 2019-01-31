package myProj;

import java.sql.*;

public class Update {
	String url;
    String dbname;
	String driver;
	String username;
	String password;
	Connection con;
	int year = 0;
			
	public Update(String dbn){
		con = null;
		url = "jdbc:mysql://localhost:3306/";
		dbname = "EVEN2019";
		driver = "com.mysql.jdbc.Driver";
		username = "root"; 
		password = "";
		
		try{
        	Class.forName(driver).newInstance();
			con = DriverManager.getConnection(url+dbn, username,password);
			if(dbn.equals("EVEN2019"))
				year = Integer.parseInt(dbn.substring(4));
			else
				year = Integer.parseInt(dbn.substring(3));
			if (!con.isClosed())
				System.out.println("Successfully Connected to MySQL Server.");
		}
		catch(Exception e){
			System.out.println("excepr");
			
			e.getMessage();
		}
		
		
	}
	
	
	  
    public void updateResult(String pos, int amt, String tm)throws SQLException{
        	
        	
            String position = pos.toUpperCase();
            String tournament = tm.toUpperCase();
            String query = "INSERT INTO result VALUES (?, ?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            System.out.println(year);
    		
            
            ps.setInt(1,year);
            ps.setString(2,tournament);
            ps.setInt(3,amt);
            ps.setString(4,position);
            ps.executeUpdate();
            System.out.println("Updation successfull");
        }
       
    
}
