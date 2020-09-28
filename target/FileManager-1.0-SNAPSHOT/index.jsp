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
<body>
<div class="main">

    <h1>Welcome to File Manager</h1>
    <h3>Currently you are located here: <%=(String)request.getAttribute("currentLoc")%></h3>

    <%!
    //Lists for files and folders
    ArrayList<File> files = null;
    ArrayList<File> dirs = null;
    %>

    <br>
    <input style = "background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  background-color: #555555;" id = "button" type = "button" value = "Hide Content">
    <br><br>

    <!--Start of the Files Table -->
    <h3 class = "table">Files:</h3>
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
            //Table with files that were output using ForEach Cycle
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
        <%
                }
            } else {
                out.println("There are no files");
            }
        %>
    </table>
    <!-- End of the Files Table -->

    <!-- Start of the Folders Table -->
    <h3 class = "table">Folders :</h3>
        <%
        //As the files table folder table is outputed using ForEach Cycle
        int count2 = 1;
        dirs = (ArrayList<File>) request.getAttribute("dirList");
        if (dirs != null) {
            for (File file: dirs) {
                String filePath = file.getAbsolutePath();
                filePath = filePath.replace("\\", "/");
    %>
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
            <td> <a class="mb-0" href="MainServlet?folder=<%=filePath.substring(16)%>">
                <%out.println(file.getName());%>
            </a></td>
            <td><%=file.length()/1024 + "KB \n"%></td>
            <td><a style = "margin_left:100px;" href="delete?filename=<%=filePath%>&folder=<%=(String)request.getAttribute("folder")%>%>">Delete</a></td>
        </tr>
        <%
                }
            } else {
                out.println("There are no files");
            }
        %>
    </table>
    <!-- End of the Folders Table -->

    <br> <br>

    <!-- A Section with File Upload Function -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script>
        $(document).ready(function(){
            $('input[type="file"]').change(function(e){
                var fileName = e.target.files[0].name;
                alert('The file "' + fileName +  '" has been selected.');
            });
        });
    </script>
    <h3>File Upload</h3>
    <form action="MainServlet" method="post" enctype="multipart/form-data">
        <div class="input-group">

            <div class="input-group">
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="inputGroupFile04" name="file">
                    <label class="custom-file-label" for="inputGroupFile04">Choose file</label>
                </div>
                <div class="input-group-append">
                    <input type="submit" class="btn btn-outline-secondary" value="Submit">
                </div>
            </div>
            <input type="hidden" class="form-control-file" readonly name="folder" value="<%
            if (request.getAttribute("folder") == null || request.getAttribute("folder").equals("null")){
                out.print("");
            }else out.print(request.getAttribute("folder"));%>">
        </div>
    </form>
    <!-- The End of the Section-->

    <h1>Search a File</h1>
    <form action="search" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <input type="text" name="search" placeholder="Name of the file">
            <input type="submit" class="btn btn-outline-secondary" value="Submit">
        </div>
    </form>
        <%
            System.out.println(request.getAttribute("message"));
            if (request.getAttribute("message") == null
                    || request.getAttribute("message") == "unsucess"
                    || request.getAttribute("message").equals("null")) {
            } else if (request.getAttribute("message") == "success"){
                File file = (File) request.getAttribute("foundFile");
                String searchFilePath = file.getAbsolutePath();
                System.out.println(file.getName());
                %>
    <a href="download?filename=<%=searchFilePath%>&folder=<%=(String)request.getAttribute("folder")%>">
        <%out.println(file.getName());%>
    </a> <br>
        <%  }
        %>

    <%@include file="component/footer.jsp"%>

    <!-- Some JavaScript -->
    <script>
        $(document).ready(function () {
            flag = true;
            $("#button").click(function () {
                if(flag === true) {
                    $(".table").css({"display": "none"});
                    $("#button").prop("value", "Show Content");
                    flag = false;
                } else {
                    $(".table").css({"display": "block"});
                    $("#button").prop("value", "Hide Content");
                    flag = true;
                }
            })
        })
    </script>
</body>
</html>
