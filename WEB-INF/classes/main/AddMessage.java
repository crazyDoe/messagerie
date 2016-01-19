package main;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import outils.BDDTools;

@WebServlet("/servlet/AddMessage")
public class AddMessage extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();
					
			String pseudo = "" + session.getAttribute("pseudo");
			String message = "" + req.getParameter("message");
			String date = new SimpleDateFormat("dd MMMM yyyy / HH:mm:ss", Locale.FRANCE).format(new Date());
			
			PreparedStatement stmt = con.prepareStatement("INSERT INTO MESSAGE VALUES(null, ?, ?, ?, ?, ?)");
			stmt.setString(1, pseudo);
			stmt.setInt(2, Integer.parseInt((String) session.getAttribute("groupe")));
			stmt.setString(3, message);
			stmt.setString(4, date);
			stmt.setInt(5, 0);
			
			res.getWriter().println(date + " - " + pseudo + " : " + message);

			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
