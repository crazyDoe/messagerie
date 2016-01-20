package main;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

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
			String nomSaisi = req.getParameter("nomSaisi");
			String nomCourant = ""+session.getAttribute("pseudo");

			@SuppressWarnings("unchecked")
			List<String> liste = (List<String>)session.getAttribute("contacts");
			liste.add(nomSaisi);
			session.setAttribute("contacts", liste);
			
			PreparedStatement stmt = con.prepareStatement("INSERT INTO contact VALUES(?,?)");
			stmt.setString(1, nomCourant);
			stmt.setString(2, nomSaisi);
			stmt.executeUpdate();
			res.sendRedirect("SelectContact");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
