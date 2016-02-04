package controler;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/servlet/Deconnect")
public class Deconnect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		req.getSession().invalidate();
		res.sendRedirect("../jsp/profil.jsp");
	}
}
