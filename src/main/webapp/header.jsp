<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-recycle me-2"></i>GreenSense
        </a>
        <div class="navbar-nav ms-auto">
            
            <c:if test="${empty sessionScope.user_id}">
                <%-- User is NOT logged in --%>
                <a class="nav-link" href="#" id="openRegisterBtn"><i class="bi bi-person-plus me-1"></i>Register</a>
                <a class="nav-link" href="#" id="openLoginBtn"><i class="bi bi-box-arrow-in-right me-1"></i>Login</a>
            </c:if>

            <c:if test="${not empty sessionScope.user_id}">
                <%-- User IS logged in --%>
                <c:if test="${sessionScope.user_role == 'admin'}">
                    <span class="navbar-text me-3">Welcome, Admin!</span>
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                </c:if>
                <c:if test="${sessionScope.user_role == 'citizen'}">
                    <span class="navbar-text me-3">Welcome, ${sessionScope.user_name}!</span>
                    <a class="nav-link" href="${pageContext.request.contextPath}/citizenDashboard">My Dashboard</a>
                </c:if>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
            </c:if>

        </div>
    </div>
</nav>