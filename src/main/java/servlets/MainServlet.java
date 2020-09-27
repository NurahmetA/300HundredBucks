package servlets;

import models.Directory;
import models.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet
@MultipartConfig
public class MainServlet extends HttpServlet {

    static String ROOT_DIRECTORY;

    public void init() throws ServletException {
        super.init();
        ROOT_DIRECTORY =getServletContext().getInitParameter("root");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folder =request.getParameter("folder");
        if (folder == null || folder.isEmpty()) {
            folder = "";
        }
        String currentDirectory = ROOT_DIRECTORY + "\\" + folder;
        ArrayList<File> files =new ArrayList<>();
        ArrayList<File> dirs = new ArrayList<>();
        File dir = new File(currentDirectory);
        if (dir.isDirectory()) {
            for (File item: dir.listFiles()
                 ) {
                if (item.isDirectory()) {
                    dirs.add(item);
                } else {
                    files.add(item);
                }
            }
        }
        request.setAttribute("fileList", files);
        request.setAttribute("dirList", dirs);
        request.setAttribute("folder", folder);
        request.setAttribute("currentLoc", currentDirectory);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
