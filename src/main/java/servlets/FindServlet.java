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
        String fileName = request.getParameter("search");
        String folder = request.getParameter("folder");
        if (folder == null || folder.isEmpty() || folder.equals("null")){
            folder = "";
        }

        Pattern myPattern = Pattern.compile(fileName + ".*");
        Matcher matcher = null;
        boolean flag = false;
        File theFile = null;
        File directoryOfFile = new File(ROOT_DIRECTORY + "\\" + folder);

        for (File aFile: directoryOfFile.listFiles()
             ) {
            if (!aFile.isDirectory()) {
                matcher = myPattern.matcher(aFile.getAbsolutePath());
                if (matcher.find()) {
                    theFile= new File(ROOT_DIRECTORY + "\\" + folder + "\\" + aFile.getName());
                    flag = true;
                }
            }
        }
        if (flag) {
            request.setAttribute("message", "success");
            request.setAttribute("foundFile", theFile);
        } else {
            request.setAttribute("message", "unsuccess");
        }
        request.getRequestDispatcher("MainServlet?folder=" + folder).forward(request, response);

    }
}
