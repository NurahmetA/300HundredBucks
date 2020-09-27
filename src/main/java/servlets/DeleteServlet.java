package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.rmi.server.ExportException;

@WebServlet("/delete")
@MultipartConfig
public class DeleteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String folder = request.getParameter("folder");
            String file = request.getParameter("filename");
            File deleteDir = new File(file);
            if (deleteDir.exists()) {
                deleteDir.delete();
            }
            response.sendRedirect("MainServlet?folder=" + folder);
        } catch (Exception e) {
            request.setAttribute("error", "Something went wrong!");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }

    }
}
