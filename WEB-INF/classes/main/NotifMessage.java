package main;
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

@WebServlet("/servlet/NotifMessage")
public class NotifMessage extends HttpServlet{
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
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM message WHERE vu=0 AND gno = (SELECT id_groupe FROM contient WHERE pseudo = ?);");
			stmt.setString(1, pseudo);
			rs = stmt.executeQuery();
			if(rs.next())
				out.println("<i style='color:red' class='fa fa-exclamation-circle'></i>");
      else
        out.println("");
		} catch (Exception e) {
				e.printStackTrace();
			}
		finally{
			tools.close();
		}
	}
}
