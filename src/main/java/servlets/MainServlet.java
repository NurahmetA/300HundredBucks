package servlets;

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


    private static String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
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
            String fileName = getSubmittedFileName(part);
            part.write(uploadPath + File.separator + fileName);
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folder =request.getParameter("folder");
        if (folder == null || folder.isEmpty() || folder.equals("null")){
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
