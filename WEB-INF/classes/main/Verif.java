package main;
// Servlet Test.java  de test de la configuration
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

@WebServlet("/servlet/Verif")
public class Verif extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM personne WHERE pseudo=? AND mdp = ?");

			String nomSaisi = req.getParameter("login");

			stmt.setString(1, nomSaisi);
			stmt.setString(2, req.getParameter("mdp"));
			rs = stmt.executeQuery();

			if(rs.next()){
				session.setAttribute("pseudo", nomSaisi);
				res.sendRedirect("../profil.jsp");
			}
			else{
				session.setAttribute("erreur","Mauvais Identifiants");
				res.sendRedirect("../login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
