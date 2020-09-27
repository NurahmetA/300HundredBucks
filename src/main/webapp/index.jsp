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
    <script src="jquery-3.5.1.min.js"></script>
</head>
<div class="main">
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
    <%
        int count2 = 1;
        dirs = (ArrayList<File>) request.getAttribute("dirList");
        if (dirs != null) {
            for (File file: dirs) {
                String filePath = file.getAbsolutePath();
                filePath = filePath.replace("\\", "/");
    %>
<h3>Folders :</h3>
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Folder Name</th>
            <th scope="col">Folder Size</th>
            <th scope="col">Delete</th>
        </tr>
        </thead>
        <tr>
            <td><%=count2++%></td>
            <td> <a class="mb-0" href="download?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>">
                <%out.println(file.getName());%>
            </a></td>
            <td><%=file.length()/1024 + "KB \n"%></td>
            <td><a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a></td>
        </tr>
    &nbsp &nbsp &nbsp &nbsp
   <%
    }
    } else {
        out.println("There are no files");
    }
%>
    </table>
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
</div>
<%@include file="component/footer.jsp"%>
<script>
    $(document).ready(function () {
        $(".").
    })
</script>
</body>

</html>
