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

@WebServlet("/servlet/InsertUser")
public class InsertUser extends HttpServlet{

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
			String nomSaisi = req.getParameter("pseudo");
			String mdp = req.getParameter("mdp");
      session.setAttribute("pseudo", nomSaisi);
			PreparedStatement stmt = con.prepareStatement("INSERT INTO personne VALUES (?,?,?)");
			stmt.setString(1, nomSaisi);
			stmt.setString(2, mdp);
			stmt.setString(3, "noImg");
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/profil.jsp");
			con.close();

		} catch (Exception e) {
			out.println(e);
		}
		finally{
			tools.close();
		}
	}
}
