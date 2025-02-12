<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Assignment</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<div class="container">
    <h2>Submit Assignment</h2>
    
    <form action="${pageContext.request.contextPath}/submitAssignment" 
          method="post" 
          enctype="multipart/form-data">
        
        <input type="hidden" name="action" value="submitAssignment"/>
        <input type="hidden" name="assignmentId" value="${param.assignmentId}"/>
        <input type="hidden" name="studentId" value="${sessionScope.studentId}"/>
        
        <div class="form-group">
            <label for="file">Select File:</label>
            <input type="file" id="file" name="fileName" required/>
        </div>
        
        <div class="form-group">
            <input type="submit" value="Submit Assignment" class="button"/>
        </div>
    </form>
    
    <div class="form-info">
        <p>Accepted file types: PDF, XLS, XLSX, PPTX, ZIP</p>
        <p>Maximum file size: 10MB</p>
    </div>
</div>
</body>
</html>
