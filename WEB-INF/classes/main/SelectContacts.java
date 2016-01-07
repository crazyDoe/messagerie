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

import outils.BDDTools;

@WebServlet("/servlet/SelectContacts")
public class SelectContacts extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools();
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();

		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("SELECT pseudo FROM personne where pseudo = ?");

			stmt.setString(1, req.getParameter("pseudo"));
			rs = stmt.executeQuery();
			
			while(rs.next())
				out.println(rs.next());
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}