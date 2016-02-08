package controler;
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

import model.BDDTools;


@WebServlet("/servlet/GetMessages")
public class GetMessages extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		req.setCharacterEncoding("UTF-8");

		try {
			String pseudo = (String)session.getAttribute("pseudo");
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("select date, pno, message FROM message where gno = ?");

			String groupe = "" + req.getSession().getAttribute("numGroupe");

			if(groupe != null){
				stmt.setInt(1, Integer.parseInt(groupe));
				rs = stmt.executeQuery();

				while(rs.next())
				{
					if(rs.getString("pno").equals(pseudo))
					{
						out.println("<li class='right clearfix'>");
								out.println("<span class='chat-img pull-right'>");
										out.println("<img src='../img/"+rs.getString("pno")+"Avatar.png' alt='User Avatar' class='avatar-message'>");
								out.println("</span>");
								out.println("<div class='chat-body clearfix'>");
										out.println("<div class='header'>");
												out.println("<small class='pull-right text-muted'>");
														out.println("<i class='fa fa-clock-o fa-fw'></i>"+rs.getString("date")+"</small>");
												out.println("<strong class='primary-font'></strong></br>");
										out.println("</div>");
										out.println("<p class='pull-right MessCourant'>");
											out.println(rs.getString("message"));
										out.println("</p>");
								out.println("</div>");
							out.println("</li>");
						}
						else
						{
							out.println("<li class='left clearfix'>");
									out.println("<span class='chat-img pull-left'>");
											out.println("<img src='../img/"+rs.getString("pno")+"Avatar.png' alt='User Avatar' class='avatar-message'>");
									out.println("</span>");
									out.println("<div class='chat-body clearfix'>");
											out.println("<div class='header'>");
													out.println("<strong class='primary-font'></strong></br>");
													out.println("<small class='pull-left text-muted'>");
															out.println("<i class='fa fa-clock-o fa-fw'></i>"+rs.getString("date")+"</small>");
															out.println("<strong class='primary-font'></strong></br>");
											out.println("</div>");
											out.println("<p class='pull-left MessRecu'>");
												out.println(rs.getString("message"));
											out.println("</p>");
									out.println("</div>");
								out.println("</li>");
						}
				}
			}
		}
		catch (Exception e) {
				e.printStackTrace();
		}
		finally{
			tools.close();
		}
	}
}
