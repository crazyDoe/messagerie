package main;
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

import outils.BDDTools;

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
			String pseudo = (String) session.getAttribute("pseudo");
						
			PreparedStatement stmt;
			
			stmt = con.prepareStatement("SELECT gno FROM groupe WHERE nom = ?");
			stmt.setString(1, group_name);
			rs = stmt.executeQuery();
			
			if(!rs.next()) { // Si groupe de plusieurs personnes non trouve
				stmt = con.prepareStatement("SELECT gno FROM groupe WHERE nom = ? or nom = ?");
				stmt.setString(1, group_name+""+pseudo);
				stmt.setString(2, pseudo+""+group_name);
				rs = stmt.executeQuery();
				
				if(!rs.next()){ // Groupe de 2 personnes non trouve, on cree un nouveau groupe
					stmt = con.prepareStatement("INSERT INTO groupe (nom) VALUES(?)");
					stmt.setString(1, group_name+""+pseudo);
					stmt.executeUpdate();
					
					int nbLines = tools.getNbLines("groupe");
						
					// Et on ajoute les deux personnes dedans
					stmt = con.prepareStatement("INSERT INTO contient VALUES(?,?)");
					stmt.setInt(1, nbLines);
					stmt.setString(2, pseudo);
					stmt.executeUpdate();
					
					stmt = con.prepareStatement("INSERT INTO contient VALUES(?,?)");
					stmt.setInt(1, nbLines);
					stmt.setString(2, group_name);
					stmt.executeUpdate();
				}
			}
			session.setAttribute("groupe", rs.getString("gno"));	
		} catch (Exception e) {
			res.getWriter().println(e);
		}
		finally{
			tools.close();
		}
	}
}
