<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Management - GreenSense</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <div class="card-custom">
             <div class="d-flex justify-content-between align-items-center mb-3">
                <h1 class="welcome-header mb-0">Complaint Management</h1>
                <div>
                     <a href="${pageContext.request.contextPath}/dashboard?status=unresolved" class="btn btn-sm ${activeFilter == 'unresolved' ? 'btn-success' : 'btn-secondary'}">Unresolved</a>
                     <a href="${pageContext.request.contextPath}/dashboard?status=resolved" class="btn btn-sm ${activeFilter == 'resolved' ? 'btn-secondary' : 'btn-success'}">Resolved</a>
                </div>
            </div>

            <table class="complaint-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Citizen</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Image</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="complaint" items="${complaints}">
                        <tr>
                            <td>#${complaint.id}</td>
                            <td>${complaint.citizenFullName}</td>
                            <td>${complaint.description}</td>
                            <td>${complaint.category}</td>
                            <td><a href="${pageContext.request.contextPath}/images/${complaint.imagePath}" target="_blank">View</a></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/updateStatus" method="post">
                                    <input type="hidden" name="complaintId" value="${complaint.id}">
                                    <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                        <option value="submitted" ${complaint.status == 'submitted' ? 'selected' : ''}>Submitted</option>
                                        <option value="in_progress" ${complaint.status == 'in_progress' ? 'selected' : ''}>In Progress</option>
                                        <option value="resolved" ${complaint.status == 'resolved' ? 'selected' : ''}>Resolved</option>
                                    </select>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
</body>
</html>