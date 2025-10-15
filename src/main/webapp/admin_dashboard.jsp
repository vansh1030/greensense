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
    <script>
        function editRoute(routeId, truckId, source, destination, status) {
            document.getElementById('editRouteId').value = routeId;
            document.getElementById('editTruckId').value = truckId;
            document.getElementById('editSource').value = source;
            document.getElementById('editDestination').value = destination;
            document.getElementById('editStatus').value = status;
            document.getElementById('editForm').style.display = 'block';
        }
        function cancelEdit() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
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
                            <a href="${pageContext.request.contextPath}/dashboard?status=resolved" class="btn btn-sm ${activeFilter == 'resolved' ? 'btn-success' : 'btn-secondary'}">Resolved</a>
                        </div>
                    </div>
                    <table class="complaint-table">
                        <thead><tr><th>Complaint No.</th><th>Date & Time</th><th>Citizen</th><th>Category</th><th>Location</th><th>Description</th><th>Status</th></tr></thead>
                        <tbody>
                            <c:forEach var="complaint" items="${complaints}">
                                <tr>
                                    <td>#${complaint.id}</td>
                                    <td>${complaint.submittedAt}</td>
                                    <td>${complaint.citizenFullName}</td>
                                    <td>${complaint.category}</td>
                                    <td>${complaint.latitude}, ${complaint.longitude}</td>
                                    <td>${complaint.description}</td>
                                    <td>
                                        <c:if test="${complaint.status != 'resolved'}">
                                            <form action="${pageContext.request.contextPath}/updateStatus" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="complaintId" value="${complaint.id}">
                                                <select name="status" class="form-select form-select-sm" onchange="if(this.value=='resolved'){document.getElementById('imageUpload${complaint.id}').style.display='block';}else{this.form.submit();}">
                                                    <option value="unresolved" ${complaint.status == 'unresolved' ? 'selected' : ''}>Unresolved</option>
                                                    <option value="in_progress" ${complaint.status == 'in_progress' ? 'selected' : ''}>In Progress</option>
                                                    <option value="resolved" ${complaint.status == 'resolved' ? 'selected' : ''}>Resolved</option>
                                                </select>
                                                <div id="imageUpload${complaint.id}" style="display:none; margin-top:5px;">
                                                    <input type="file" name="resolutionImage" accept="image/*" required>
                                                    <button type="submit" class="btn btn-sm btn-success mt-1">Resolve</button>
                                                </div>
                                            </form>
                                        </c:if>
                                        <c:if test="${complaint.status == 'resolved'}">
                                            Resolved
                                            <c:if test="${not empty complaint.imagePath}">
                                                <br><small><a href="${pageContext.request.contextPath}/images/${complaint.imagePath}" target="_blank">View Image</a></small>
                                            </c:if>
                                        </c:if>
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-lg-4">
                 <div class="card-custom mb-4">
                    <h4 class="section-title">Truck Management</h4>
                    <table class="table table-sm">
                        <thead><tr><th>ID</th><th>Source</th><th>Destination</th><th>Status</th><th>Action</th></tr></thead>
                        <tbody>
                            <c:forEach var="route" items="${truckRoutes}">
                                <tr>
                                    <td>${route.truckId}</td>
                                    <td>${route.sourceLocation}</td>
                                    <td>${route.destinationLocation}</td>
                                    <td>${route.status}</td>
                                    <td><button class="btn btn-sm btn-primary" onclick="editRoute(${route.routeId}, ${route.truckId}, '${route.sourceLocation}', '${route.destinationLocation}', '${route.status}')">Edit</button></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="editForm" style="display:none;">
                        <form action="${pageContext.request.contextPath}/updateTruckRoute" method="post">
                            <input type="hidden" id="editRouteId" name="routeId">
                            <div class="mb-2"><input type="text" id="editTruckId" name="truckId" class="form-control" placeholder="Truck ID" required></div>
                            <div class="mb-2"><input type="text" id="editSource" name="source" class="form-control" placeholder="Source" required></div>
                            <div class="mb-2"><input type="text" id="editDestination" name="destination" class="form-control" placeholder="Destination" required></div>
                            <div class="mb-2">
                                <select id="editStatus" name="status" class="form-select" required>
                                    <option value="scheduled">Scheduled</option>
                                    <option value="in_transit">In Transit</option>
                                    <option value="completed">Completed</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-success btn-sm">Update</button>
                            <button type="button" class="btn btn-secondary btn-sm" onclick="cancelEdit()">Cancel</button>
                        </form>
                    </div>
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