<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Citizen Dashboard - GreenSense</title>
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
                <h1 class="welcome-header mb-4">Your Dashboard</h1>
                
                <div class="row mb-4">
                    <div class="col-md-4 mb-3"><div class="stat-card"><h2>${totalComplaints}</h2><p>Total Complaints</p></div></div>
                    <div class="col-md-4 mb-3"><div class="stat-card"><h2>${resolvedComplaints}</h2><p>Resolved</p></div></div>
                    <div class="col-md-4 mb-3"><div class="stat-card"><h2>${pendingComplaints}</h2><p>Pending</p></div></div>
                </div>

                <div class="mb-4">
                     <a href="${pageContext.request.contextPath}/submit_complaint.jsp" class="btn-main-action text-center text-decoration-none d-block">
                        <i class="bi bi-plus-circle-fill me-2"></i>File a New Complaint
                     </a>
                </div>

                <div class="complaint-list">
                    <h4 class="section-title">My Recent Complaints</h4>
                    <c:forEach var="complaint" items="${myComplaints}">
                        <div class="complaint-item">
                            <div>
                                <p class="mb-0 fw-bold">${complaint.description}</p>
                                <small class="text-muted">ID: #${complaint.id} - ${complaint.submittedAt}</small>
                            </div>
                            <span class="badge-status 
                                <c:if test='${complaint.status == "resolved"}'>badge-resolved</c:if>
                                <c:if test='${complaint.status == "in_progress"}'>badge-progress</c:if>
                                <c:if test='${complaint.status == "submitted"}'>badge-pending</c:if>
                            ">${complaint.status}</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty myComplaints}">
                        <p class="text-muted">You have not submitted any complaints yet.</p>
                    </c:if>
                </div>
            </div>

            <div class="col-lg-4">
                 <h4 class="section-title mt-4 mt-lg-0">Recent Updates & Drives</h4>
                 <c:forEach var="update" items="${recentUpdates}">
                     <div class="complaint-item">
                        <div>
                            <p class="mb-1 fw-bold">${update.title}</p>
                            <small class="text-muted">${update.content.substring(0, Math.min(update.content.length(), 60))}...</small>
                        </div>
                     </div>
                 </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>