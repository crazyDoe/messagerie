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
						
			PreparedStatement stmt = con.prepareStatement("SELECT id_groupe FROM contient WHERE pseudo1 = ? and pseudo2 = ?");
			stmt.setString(1, (String) session.getAttribute("pseudo"));
			stmt.setString(2, (String) session.getAttribute("friend"));
			rs = stmt.executeQuery();
			
			if(rs.next()) { // Si groupe avec pseudo1 et pseudo2 trouve
				session.setAttribute("groupe", rs.getString("id_groupe"));
			}
			else{
				stmt = con.prepareStatement("SELECT id_groupe FROM contient WHERE pseudo2 = ? and pseudo1 = ?");
				stmt.setString(1, (String) session.getAttribute("pseudo"));
				stmt.setString(2, (String) session.getAttribute("friend"));
				rs = stmt.executeQuery();		
				
				if(rs.next()) { // Si groupe avec pseudo2 et pseudo1 trouve
					session.setAttribute("groupe", rs.getString("id_groupe"));	
				}
				else{ // on cree un nouveau groupe
					stmt = con.prepareStatement("INSERT INTO groupe (nom) VALUES(?)");
					stmt.setString(1, "newGroupe");
					stmt.executeUpdate();
					
					// Et on ajoute les deux personnes dedans
					stmt = con.prepareStatement("INSERT INTO contient VALUES(?,?,?)");
					stmt.setInt(1, tools.getNbLines("groupe"));
					stmt.setString(2, (String) session.getAttribute("pseudo"));
					stmt.setString(3, (String) session.getAttribute("friend"));
					stmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
