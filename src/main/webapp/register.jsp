<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - GreenSense</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container mt-4">
        <div class="auth-box" style="margin: auto;">
             <h3>Create a Citizen Account</h3>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <input type="text" class="form-control" name="fullName" placeholder="Full Name" required>
                <input type="email" class="form-control" name="email" placeholder="Email Address" required>
                <div class="password-container" style="margin-bottom: 15px;">
                     <input type="password" class="form-control" name="password" id="registerPassword" placeholder="Create Password" required>
                     <span class="toggle-password" onclick="togglePasswordVisibility('registerPassword')" style="top: 12px; color: var(--muted);">👁️</span>
                </div>
                <input type="hidden" name="role" value="citizen">
                <button type="submit" class="btn-auth">Register</button>
            </form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>