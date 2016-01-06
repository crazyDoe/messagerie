import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/servlet/Login")
public class Login extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException{
		BDDTools tools = new BDDTools();
		
		String nom = "'" + req.getParameter("nom") + "'";
		String mdp = "'" + req.getParameter("mdp") + "'";
		String date = "'" + new Date().toString() + "'";
		String ip = "'" + req.getRemoteAddr() + "'";
		
		try {
			PreparedStatement ps;
			ResultSet rs;
			HttpSession session = req.getSession();
			
			ps = tools.getConn().prepareStatement("select * from login where nom = " + nom + " and mdp = " + mdp);
			rs = ps.executeQuery();
			
			if(!rs.next()){
				tools.doRequest("insert into login values(" + nom + ", " + mdp + ", " + date + ", " + ip + ")");
				
				session.setAttribute("date", req.getParameter("date"));
				session.setAttribute("ip", req.getParameter("ip"));
			}
			else{
				ps = tools.getConn().prepareStatement("select date, ip from login where nom = " + nom + " and mdp = " + mdp);
				rs = ps.executeQuery();
				if(rs.next()){
					session.setAttribute("date", rs.getString("date"));
					session.setAttribute("ip", rs.getString("ip"));
				}
				
				tools.doRequest("update login set date = " + date + ", ip = " + ip + " where nom = " + nom + " and mdp = " + mdp);
			}
			session.setAttribute("nom", req.getParameter("nom"));
			res.sendRedirect("../home.jsp");
			tools.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			try {
				tools.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}