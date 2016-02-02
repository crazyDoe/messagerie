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

@WebServlet("/servlet/DeleteGroup")
public class DeleteGroup extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("resource")
	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		HttpSession session = req.getSession();
		PreparedStatement stmt;
		ResultSet rs;
		
		try {
			con = tools.getConnect();

			String pseudo = ""+session.getAttribute("pseudo");
			String nomGroupe = (String) session.getAttribute("group_name");
			int numGroupe = (int) session.getAttribute("numGroupe");
			
			stmt = con.prepareStatement("DELETE FROM MESSAGE WHERE gno = ?"); // Supprime les messages
			stmt.setInt(1, numGroupe);
			stmt.executeUpdate();
			
			stmt = con.prepareStatement("DELETE FROM CONTIENT WHERE id_groupe = ?"); // Supprime les appartenances
			stmt.setInt(1, numGroupe);
			stmt.executeUpdate();
						
			stmt = con.prepareStatement("SELECT * FROM groupe WHERE nom = ?"); // test sur groupe de plusieurs personnes trouve
			stmt.setString(1, nomGroupe);
			rs = stmt.executeQuery();
			
			if(rs.next()) { // Si groupe de plusieurs personnes trouve
				stmt = con.prepareStatement("DELETE FROM CONTACT where pseudo_reception = ?"); // Supprime les contacts (>2)
				stmt.setString(1, nomGroupe);
				stmt.executeUpdate();
			}
			else{ // groupe de plusieurs personnes non trouve
				stmt = con.prepareStatement("SELECT nom FROM groupe WHERE nom = ? or nom = ?"); // test sur groupe de 2
				stmt.setString(1, nomGroupe+""+pseudo);
				stmt.setString(2, pseudo+""+nomGroupe);
				rs = stmt.executeQuery();

				if(rs.next()){ // si groupe de deux trouve
					String tmp = rs.getString("nom").toLowerCase();
					
					stmt = con.prepareStatement("DELETE FROM CONTACT where pseudo_reception = ?"); // Supprime les contacts (=2)
					stmt.setString(1, tmp.replace(pseudo.toLowerCase(), ""));
					stmt.executeUpdate();
				}
			}
			
			stmt = con.prepareStatement("DELETE FROM GROUPE where gno = ?"); // Supprime le groupe
			stmt.setInt(1, numGroupe);
			stmt.executeUpdate();
				
			res.sendRedirect("../profil.jsp");
		} catch (Exception e) {
			res.getWriter().println(e);
		}
		finally{
			tools.close();
		}	}
}
