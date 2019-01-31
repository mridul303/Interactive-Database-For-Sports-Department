package myProj;


import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import myProj.Simple;
public class Search {

	private Connection con=null;
	int year = 0;
	//Simple sm = new Simple();
	String url;
    String dbname;
	String driver;
	String username;
	String password;
	
	
	
	public Search(String dbn){
		try
		{
			url = "jdbc:mysql://localhost:3306/";
			dbname = "EVEN2019";
			driver = "com.mysql.jdbc.Driver";
			username = "root"; 
			password = "";
			
			
			Class.forName(driver).newInstance();
			con = DriverManager.getConnection(url+dbn, username,password);
			
			if(dbn.equals("EVEN2019"))
				year = Integer.parseInt(dbn.substring(4));
			else
				year = Integer.parseInt(dbn.substring(3));
		
			 System.out.println("\nyear in:"+year);
			if (!con.isClosed())
				System.out.println("Successfully Connected to MySQL Server.");
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
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
	
	public ResultSet searchByName(String fn, String ln, String t)throws SQLException{
       ResultSet rs = null;
       PreparedStatement ps = null;
        try{
            String fname = fn.toUpperCase();
            String lname = ln.toUpperCase();
            String tournament = t.toUpperCase();
            final String query = "SELECT `student`.*, `tournament`.* FROM `student` , `tournament` WHERE `student`.`fname` = ? AND `student`.`lname` = ? AND `tournament`.`TOURNAMENT_NAME` = ? AND `tournament`.`YEAR` = ?";
            ps = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE);
            ps.setString(1,fname);
            ps.setString(2,lname);
            ps.setString(3,tournament);
            ps.setInt(4,year);
            rs = ps.executeQuery();
            return rs;
        }
        catch(Exception e)
		{
			System.out.println(e.getMessage());
			return null;
		}
    }
    
    public ResultSet searchByUSN(String u, String t)throws SQLException{
        ResultSet rs = null;
        PreparedStatement ps = null;
        try{
            String usn = u.toUpperCase();
            String tournament = t.toUpperCase();
            
            
           // String query = "SELECT `student`.*, `tournament`.* FROM `student` , `tournament` WHERE `student`.`USN` = ? AND `tournament`.`TOURNAMENT_NAME` = ? AND `tournament`.`YEAR` = ?";   
           String query = "SELECT `student`.*, `tournament`.*, `result`.* FROM `student` , `tournament` LEFT JOIN `result` ON `result`.`YEAR` = `tournament`.`YEAR` WHERE `student`.`USN` = ? AND `tournament`.`TOURNAMENT_NAME` = ?";
            
            ps = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE);
            ps.setString(1,usn);
            ps.setString(2,tournament);
            System.out.println("\nyear"+year);
            //ps.setInt(3, year);
            rs = ps.executeQuery();
            return rs;
        }
        catch(Exception e)
		{
        	e.getMessage();
        	return null;
		}
    }

   
	
	public ResultSet DisplayBranchWise(String Branch_ID) throws SQLException
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		try
		{
			ps = con.prepareStatement("SELECT * FROM STUDENT WHERE BRANCH_ID = ?;");
		
			ps.setString(1,Branch_ID);
		
			rs = ps.executeQuery();
			
			return rs;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			return null;			
		}
	}
}

