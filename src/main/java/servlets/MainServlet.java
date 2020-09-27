package servlets;

import models.Directory;
import models.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/MainServlet")
@MultipartConfig
public class MainServlet extends HttpServlet {

    static String ROOT_DIRECTORY;

    public void init() throws ServletException {
        super.init();
        ROOT_DIRECTORY =getServletContext().getInitParameter("root");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folder = request.getParameter("folder");
        if (folder == null || folder.isEmpty() || folder.equals("null")){
            folder = "";
        }
        String uploadPath = ROOT_DIRECTORY + "\\" + folder;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdirs();
        for (Part part : request.getParts()) {
            String fileName = part.getSubmittedFileName();
            part.write(uploadPath + File.separator + fileName);
        }
        request.setAttribute("message", "File  has uploaded successfully!");
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folder =request.getParameter("folder");
        if (folder == null || folder.isEmpty() || folder.equals("null")){
            folder = "";
        }
        String currentDirectory = ROOT_DIRECTORY + "\\" + folder;
        System.out.println(currentDirectory);
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
