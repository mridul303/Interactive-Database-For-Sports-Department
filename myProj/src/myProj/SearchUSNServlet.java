package myProj;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/jDisplay_by_usn.jsp")
public class SearchUSNServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String dbname = "";
    private final String url = "jdbc:mysql://localhost:3306/";
	private final String driver = "com.mysql.jdbc.Driver";
	private String username = "root";
	private String password = "";
	private int year = 0;
	
private void close(ResultSet r, PreparedStatement ps, Connection con){
	try{
		if(r!=null){
			r.close();
		}
		if(ps!=null){
			ps.close();
		}
		if(con!=null){
			ps.close();
		}
	}
	catch(SQLException e){
		e.getMessage();
	}
	
}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside dopost");
		
		
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		String usn = request.getParameter("usn");
		String tournament = request.getParameter("tournament");
		System.out.println("USN + "+usn);
		try{
			HttpSession session = request.getSession();
			dbname = session.getAttribute("dbn").toString();
			if(dbname.equals("EVEN2019"))
				year = Integer.parseInt(dbname.substring(4));
			else
				year = Integer.parseInt(dbname.substring(3));
			if(!usn.equals(session.getAttribute("usn")) && !tournament.equals(session.getAttribute("tournament"))){
				Class.forName(driver);
				con = DriverManager.getConnection(url+dbname, username,password);
				rs = searchByUSN(rs,ps,con,usn,tournament);
				session.setAttribute("rs", rs);
				session.setAttribute("usn", usn);
				session.setAttribute("tournament", tournament);
			}
			else{
				rs = (ResultSet)session.getAttribute("rs");
				rs.beforeFirst();
				session.setAttribute("rs", rs);
			}
		}
		catch(SQLException e){
			e.getMessage();
		}
		catch(Exception e){
			e.getMessage();
		}
		finally{
			close(rs,ps,con);
		}
	}
	
	public ResultSet searchByUSN(ResultSet rs,PreparedStatement ps, Connection con,String u, String t)throws SQLException{
        try{
            String usn = u.toUpperCase();
            String tournament = t.toUpperCase();   
            String query = "SELECT `student`.*, `tournament`.*, `result`.* FROM `student` , `tournament` LEFT JOIN `result` ON `result`.`YEAR` = `tournament`.`YEAR` WHERE `student`.`USN` = ? AND `tournament`.`TOURNAMENT_NAME` = ?";   
            ps = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE);
            ps.setString(1,usn);
            ps.setString(2,tournament);
            System.out.println("\nyear"+year);
            rs = ps.executeQuery();
            return rs;
        }
        catch(Exception e)
		{
        	e.getMessage();
        	System.out.println("ResultSet in USN is null");
        	return null;
		}
    }


}
