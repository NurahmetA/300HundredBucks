package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/search")
@MultipartConfig
public class FindServlet extends HttpServlet {

    static String ROOT_DIRECTORY;

    public void init() throws ServletException {
        super.init();
        ROOT_DIRECTORY =getServletContext().getInitParameter("root");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = (String) request.getAttribute("search");
        String folder = request.getParameter("folder");

        if (folder == null || folder.isEmpty() || folder.equals("null")){
            folder = "";
        }

        Pattern myPattern = Pattern.compile("[a-zA-Z0-9]\\.*");
        Matcher matcher = myPattern.matcher(ROOT_DIRECTORY + "\\" + folder + "\\" + fileName);

        try {
            if(matcher.find()) {
                File theFile = new File(ROOT_DIRECTORY + "\\" + folder + "\\" + fileName);
                request.setAttribute("message", "success");
                request.setAttribute("file", theFile);
            } else {
                request.setAttribute("message", "unsucess");
            }
            response.sendRedirect("MainServlet?folder=" + folder);
        } catch (FileNotFoundException e) {
            request.setAttribute("error", "Some problems may occur in search");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }
    }

}
