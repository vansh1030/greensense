<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Login</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
            Email: <input type="email" name="email" required><br><br>
            <div class="password-container">
    Password: <input type="password" name="password" id="password" required>
    <span class="toggle-password" onclick="togglePasswordVisibility('password')">👁️</span>
</div>
<br><br>
            <input type="submit" value="Login">
        </form>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
