<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Updates</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h1>Latest Updates</h1>
        <hr>
        <c:forEach var="update" items="${updates}">
            <div class="update-card" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 15px; border-radius: 5px;">
                <h3>${update.title}</h3>
                <p style="color: #555; font-size: 0.9em;">Posted on: ${update.createdAt}</p>
                <p style="white-space: pre-wrap;">${update.content}</p>
            </div>
        </c:forEach>
        <c:if test="${empty updates}">
            <p>No updates have been posted yet.</p>
        </c:if>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>