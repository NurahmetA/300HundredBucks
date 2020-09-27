<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: alemh
  Date: 24.09.2020
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@include file="component/header.jsp"%>
<head>
    <link href="main.css" rel="stylesheet">
    <style>
        *{
            margin:30px;
        }
    </style>
</head>
<h1>Welcome to File Manager</h1>
<h3>Currently you are located here: <%=(String)request.getAttribute("currentLoc")%></h3>
<%!
    //Lists for files and folders
    ArrayList<File> files = null;
    ArrayList<File> dirs = null;
%>
<h3>Files:</h3>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">#</th>
        <th scope="col">File Name</th>
        <th scope="col">File Size</th>
        <th scope="col">Delete</th>
    </tr>
    </thead>
<%
    int count = 1;
    files = (ArrayList<File>) request.getAttribute("fileList");
    if (files != null) {
        for (File file: files) {
            String filePath = file.getAbsolutePath();
            filePath = filePath.replace("\\", "/");
%>
    <tbody>
    <tr>
        <th scope="row"><%=count++%></th>
        <td>
            <a href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
                <%out.println(file.getName());%>
            </a>
        </td>
        <td>
            <a href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
                <%out.println(file.length() / 1024 + "KB");%>
            </a>
        </td>
        <td><a style="margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a></td>
    </tr>
    </tbody>
    &nbsp &nbsp &nbsp &nbsp
<%
        }
    } else {
        out.println("There are no files");
    }
%>
</table>
<h3>Folders :</h3>
<h5>
    <%
        dirs = (ArrayList<File>) request.getAttribute("dirList");
        if (dirs != null) {
            for (File file: dirs) {
                String filePath = file.getAbsolutePath();
                filePath = filePath.replace("\\", "/");
    %>
    <a class="mb-0" href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
        <%out.println(file.getName() + " " + file.length()/1024 + "KB \n");%>
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
    <form action="MainServlet" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="inputGroupFile04" name="file">
                <label class="custom-file-label" for="inputGroupFile04">Choose file</label>
            </div>
            <div class="input-group-append">
                <input type="submit" class="btn btn-outline-secondary" value="Submit">
            </div>
        </div>
    </form>
<%@include file="component/footer.jsp"%>
</body>
</html>
