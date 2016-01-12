package main;
// Servlet Test.java  de test de la configuration
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import outils.BDDTools;

@WebServlet("/servlet/add")
public class add extends HttpServlet{

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();

		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("select pseudo FROM personne WHERE pseudo LIKE '"+req.getParameter("name")+"%';");
			rs = stmt.executeQuery();
			while(rs.next())
			{
				out.println(rs.getString("pseudo"));
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
