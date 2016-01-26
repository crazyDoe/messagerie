package controler;
// Servlet Test.java  de test de la configuration
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
import javax.servlet.http.HttpSession;

import model.BDDTools;


@WebServlet("/servlet/SelectContact")
public class SelectContact extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
			List<String> liste = new LinkedList<String>();
			String pseudo = (String)session.getAttribute("pseudo");
			
			PreparedStatement stmt = con.prepareStatement("SELECT pseudo_reception FROM contact "
					+ "where pseudo_ajout = ?");
			stmt.setString(1, pseudo);
			rs = stmt.executeQuery();
			
			while(rs.next())
				liste.add(rs.getString("pseudo_reception"));

			stmt = con.prepareStatement("SELECT pseudo_ajout FROM contact "
						+ "where pseudo_reception = ?");
			stmt.setString(1, pseudo);
			rs = stmt.executeQuery();
	
			while(rs.next())
				liste.add(rs.getString("pseudo_ajout"));
			
			session.setAttribute("contacts", liste);
			session.setAttribute("pseudo", pseudo);
			res.sendRedirect(req.getContextPath() + "/profil.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
