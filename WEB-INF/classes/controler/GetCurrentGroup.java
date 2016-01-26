package controler;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BDDTools;


@WebServlet("/servlet/GetCurrentGroup")
public class GetCurrentGroup extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
			String group_name = (String) session.getAttribute("group_name");
			String next_function = (String) req.getParameter("next_function");
			String pseudo = (String) session.getAttribute("pseudo");
						
			PreparedStatement stmt;
			
			stmt = con.prepareStatement("SELECT gno FROM groupe WHERE nom = ?");
			stmt.setString(1, group_name);
			rs = stmt.executeQuery();
			
			if(rs.next()){ // groupe de plusieurs personnes trouve
				session.setAttribute("numGroupe", rs.getInt("gno"));	
			}
			else{
				stmt = con.prepareStatement("SELECT gno FROM groupe WHERE nom = ? or nom = ?");
				stmt.setString(1, group_name+""+pseudo);
				stmt.setString(2, pseudo+""+group_name);
				rs = stmt.executeQuery();
				
				if(rs.next()){ // Groupe de 2 personnes trouve
					session.setAttribute("numGroupe", rs.getInt("gno"));
				}
			}
			
			if(next_function != null && next_function.equals("delete_group"))
				res.sendRedirect("DeleteGroup");
		} catch (Exception e) {
			res.getWriter().println(e);
		}
		finally{
			tools.close();
		}
	}
}
