package controler;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/servlet/UploadImage")
@MultipartConfig
public class UploadImage extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("resource")
	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException{
		final String path = req.getServletContext().getRealPath("/") + "img/" + req.getSession().getAttribute("pseudo") + "Avatar.png";
		final Part filePart = req.getPart("file");

	    OutputStream out = null;
	    InputStream filecontent = null;

	    out = new FileOutputStream(new File(path));
	    filecontent = filePart.getInputStream();

	    int read = 0;
	    final byte[] bytes = new byte[1024];

	    while ((read = filecontent.read(bytes)) != -1)
	    	out.write(bytes, 0, read);

	    res.sendRedirect("../jsp/profil.jsp");
	}
}
