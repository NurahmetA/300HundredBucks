<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: alemh
  Date: 24.09.2020
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<head>
    <link rel="stylesheet" href="main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<%@include file="component/header.jsp"%>
<h1>Welcome to File Manager</h1>
<h3>Currently you are located here: <%=(String)request.getAttribute("currentLoc")%></h3>
<%!
    //Lists for files and folders
    ArrayList<File> files = null;
    ArrayList<File> dirs = null;
%>
<h3>Files:</h3>
<h5>
<%
    // Comment by Lil Nasway
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
    <a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a><%
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
    <a href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
        <%out.println("-" + file.getName() + " " + file.length()/1024 + "KB \n");%>
    </a>
    &nbsp &nbsp &nbsp &nbsp
    <a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a><%
        }
    } else {
        out.println("There are no files");
    }
%>
</h5>
<h3>File Upload</h3>
<div class="input-group">
    <div class="custom-file">
        <form action="MainServlet" method="post" enctype="multipart/form-data">
                <input type="file" class="custom-file-input" id="inputGroupFile04" name="file">
                <label class="custom-file-label" for="inputGroupFile04">Choose file</label>
                <input type="text" class="form-control-file" readonly name="folder" value="<%
                if (request.getAttribute("folder") == null || request.getAttribute("folder").equals("null")){
                    out.print("");
                }else out.print(request.getAttribute("folder"));%>">
                <input type="submit" class="btn btn-primary" value="Submit">
        </form>
    </div>
</div>
</body>
</html>
