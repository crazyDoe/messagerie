package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import outils.BDDTools;

@WebServlet("/servlet/SelectContacts")
public class SelectContacts extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req, res);
		Connection con = null;
		ResultSet rs;

		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("SELECT pseudo FROM personne join contact on where pseudo = ?");

			stmt.setString(1, req.getParameter("pseudo"));
			rs = stmt.executeQuery();
			
			List<String> liste = new LinkedList<String>();

			while(rs.next())
				liste.add(rs.getString("pseudo"));
			req.getSession().setAttribute("contacts", liste);
			res.getWriter().println(liste);
			//res.sendRedirect(req.getContextPath() + "/profil.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
