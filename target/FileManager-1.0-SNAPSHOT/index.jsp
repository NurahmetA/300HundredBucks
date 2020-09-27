<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.nio.file.attribute.BasicFileAttributes" %><%--
  Created by IntelliJ IDEA.
  User: alemh
  Date: 24.09.2020
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@include file="component/header.jsp"%>
<h1>Welcome to File Manager</h1>
<% String currentLoc = (String) request.getAttribute("currentLoc");%>
<h3>Currently you are located here: <%=currentLoc.replace("/","\\")%></h3>
<%!
    //Lists for files and folders
    ArrayList<File> files = null;
    ArrayList<File> dirs = null;
%>
<h3>Files:</h3>
<h5>
<%
    files = (ArrayList<File>) request.getAttribute("fileList");
    if (files != null) {
        for (File file: files) {
            String filePath = file.getAbsolutePath();
            filePath = filePath.replace("\\", "/");
%>
    <a href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
        <%out.println("-" + file.getName() + " " + file.length()/1024 + "KB \n");%>
    </a>
    &nbsp &nbsp &nbsp &nbsp
    <a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a><br><%
        }
    } else {
        out.println("There are no files");
    }
%>
</h5>
<h3>Folders :</h3>
<h5>
    <%
        dirs = (ArrayList<File>) request.getAttribute("dirList");
        if (dirs != null) {
            for (File file: dirs) {
                String filePath = file.getAbsolutePath();
                filePath = filePath.replace("\\", "/");
    %>
    <a href="MainServlet?folder=<%=filePath.substring(16)%>">
        <%out.println("-" + file.getName() + " " + file.length()/1024 + "KB \n");%>
    </a>
    &nbsp &nbsp &nbsp &nbsp
    <a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a><br><%
        }
    } else {
        out.println("There are no files");
    }
%>
</h5>
<h3>File Upload</h3>
<form action="MainServlet" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <input type="file" class="form-control-file" id="exampleFormControlFile1" name="file">
        <input type="submit" class="btn btn-primary" value="Submit">
        <input type="hidden" class="form-control-file" readonly name="folder" value="<%
        if (request.getAttribute("folder") == null || request.getAttribute("folder").equals("null")){
            out.print("");
        }else out.print(request.getAttribute("folder"));%>">
    </div>
</form>
<h3>Find File</h3>
<input type="text" name="search">
<%
    String pattern = request.getParameter("search");
    FileSystem fs = FileSystems.getDefault();
    final PathMatcher matcher = fs.getPathMatcher("glob:" + pattern);
    FileVisitor<Path> matcherVisitor = new SimpleFileVisitor<Path>() {
        @Override
        public FileVisitResult visitFile(Path file, BasicFileAttributes attribs) {
            Path name = file.getFileName();
            if (matcher.matches(name)) {
                System.out.print(String.format("Found matched file: '%s'.%n", file));
            }
            return FileVisitResult.CONTINUE;
        }
    };
    Files.walkFileTree(Paths.get(currentLoc), matcherVisitor);
%>
</body>
</html>
