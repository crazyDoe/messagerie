package main;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import outils.BDDTools;

@WebServlet("/servlet/AddContact")
public class AddContact extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();

			String nomCourant = ""+session.getAttribute("pseudo");
			String nomGroupe = req.getParameter("nomGroupe");
			
			if(nomGroupe == null) { // On cree un groupe de deux personnes
				String nomSaisi = req.getParameter("nomSaisi");
	
				PreparedStatement stmt = con.prepareStatement("INSERT INTO contact VALUES(?,?)");
				stmt.setString(1, nomCourant);
				stmt.setString(2, nomSaisi);
				stmt.executeUpdate();
			}
			else{ // On cree un groupe de plusieurs personnes								
				String[] results = req.getParameterValues("checkboxes");
				
				PreparedStatement stmt;
				
				stmt = con.prepareStatement("INSERT INTO groupe (nom) VALUES(?)");
				stmt.setString(1, nomGroupe);
				stmt.executeUpdate();
				
				int group = tools.getNbLines("groupe");
				
				stmt = con.prepareStatement("INSERT INTO contact VALUES(?, ?)");
				stmt.setString(1, nomCourant);
				stmt.setString(2, nomGroupe);
				stmt.executeUpdate();
				
				stmt = con.prepareStatement("INSERT INTO CONTIENT VALUES(?, ?)");
				stmt.setInt(1, group);
				stmt.setString(2, nomCourant);
				stmt.executeUpdate();
				
				for(String s : results){
					stmt = con.prepareStatement("INSERT INTO contact VALUES(?, ?)");
					stmt.setString(1, s.trim());
					stmt.setString(2, nomGroupe);
					stmt.executeUpdate();
				}
				
				for(String s : results){
					stmt = con.prepareStatement("INSERT INTO CONTIENT VALUES(?, ?)");
					stmt.setInt(1, group);
					stmt.setString(2, s.trim());
					stmt.executeUpdate();
				}
			}
			res.sendRedirect("SelectContact");
		} catch (Exception e) {
			res.getWriter().println(e);
		}
		finally{
			tools.close();
		}
	}
}
