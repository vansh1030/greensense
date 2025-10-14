<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - GreenSense</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-8">
                <h1 class="welcome-header mb-4">Admin Dashboard</h1>
                
                <div class="row mb-4">
                    <div class="col-md-4 mb-3"><div class="stat-card"><div class="icon"><i class="bi bi-exclamation-triangle-fill"></i></div><div><h2>${pendingCount}</h2><p>Pending</p></div></div></div>
                    <div class="col-md-4 mb-3"><div class="stat-card"><div class="icon"><i class="bi bi-hourglass-split"></i></div><div><h2>${inProgressCount}</h2><p>In Progress</p></div></div></div>
                    <div class="col-md-4 mb-3"><div class="stat-card"><div class="icon"><i class="bi bi-check-circle-fill"></i></div><div><h2>${resolvedCount}</h2><p>Resolved</p></div></div></div>
                </div>

                <div class="card-custom mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="section-title mb-0">Complaint Management</h4>
                        <div>
                            <a href="${pageContext.request.contextPath}/dashboard?status=unresolved" class="btn btn-sm ${activeFilter == 'unresolved' ? 'btn-success' : 'btn-secondary'}">Unresolved</a>
                            <a href="${pageContext.request.contextPath}/dashboard?status=resolved" class="btn btn-sm ${activeFilter == 'resolved' ? 'btn-secondary' : 'btn-success'}">Resolved</a>
                        </div>
                    </div>
                    <table class="complaint-table">
                        <thead><tr><th>ID</th><th>Citizen</th><th>Description</th><th>Status</th></tr></thead>
                        <tbody>
                            <c:forEach var="complaint" items="${complaints}">
                                <tr>
                                    <td>#${complaint.id}</td>
                                    <td>${complaint.citizenFullName}</td>
                                    <td>${complaint.description}</td>
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

            <div class="col-lg-4">
                 <div class="card-custom mb-4">
                    <h4 class="section-title">Live Truck Routes</h4>
                    <c:forEach var="route" items="${truckRoutes}">
                        <div class="mb-2">
                            <strong>Truck #${route.truckId}</strong> (${route.status})<br>
                            <small class="text-muted">${route.sourceLocation} to ${route.destinationLocation}</small>
                        </div>
                    </c:forEach>
                 </div>

                 <div class="card-custom mb-4">
                    <h4 class="section-title">Post an Update</h4>
                    <form action="${pageContext.request.contextPath}/addUpdate" method="post">
                        <input type="text" name="title" class="form-control" placeholder="Update Title" required>
                        <textarea name="content" class="form-control" rows="3" placeholder="Announce a cleanup drive..." required></textarea>
                        <button type="submit" class="btn-main-action mt-2">Publish Update</button>
                    </form>
                 </div>
            </div>
        </div>
    </div>

</body>
</html>