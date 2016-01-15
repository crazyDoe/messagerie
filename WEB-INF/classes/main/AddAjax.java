package main;
// Servlet Test.java  de test de la configuration
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/servlet/AddAjax")
public class AddAjax extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		
		String pseudo = (String) session.getAttribute("pseudo");

		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("select pseudo FROM personne"
					+ " WHERE pseudo <> ?"
					+ " AND pseudo LIKE ?"); 
			// Ajouter test sur amis déjà présents dans les contacts
			
			stmt.setString(1, pseudo);
			stmt.setString(2, req.getParameter("name")+"%");
			rs = stmt.executeQuery();
			while(rs.next())
				out.println(rs.getString("pseudo"));
		} catch (Exception e) {
				e.printStackTrace();
			}
		finally{
			tools.close();
		}
	}
}
