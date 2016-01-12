package main;
// Servlet Test.java  de test de la configuration
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import outils.BDDTools;

@WebServlet("/servlet/addContact")
public class addContact extends HttpServlet{

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
			String nomSaisi = req.getParameter("pseudo");
			String nomCourant = ""+session.getAttribute("pseudo");
			PreparedStatement stmta = con.prepareStatement("SELECT * FROM personne WHERE pseudo= ?");
			stmta.setString(1, nomSaisi);
			rs = stmta.executeQuery();
			if(rs.next())
			{
				Statement stmt = con.createStatement();
				List<String> liste = (List<String>)session.getAttribute("contacts");
				liste.add(nomSaisi);
				req.getSession().setAttribute("contacts", liste);

				String requete = "INSERT INTO contact VALUES('"+nomCourant+"','"+nomSaisi+"');";
				stmt.executeUpdate(requete);
				res.sendRedirect(req.getContextPath() + "/profil.jsp");
			}
			else
			{
				session.setAttribute("erreur","Cet utilisateur n'existe pas");
				res.sendRedirect(req.getContextPath() + "/addContact.jsp");
			}
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
