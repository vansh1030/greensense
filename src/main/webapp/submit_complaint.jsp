<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>File a Complaint - GreenSense</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card-custom">
                    <h1 class="welcome-header mb-4">File a New Complaint</h1>
                    <form action="${pageContext.request.contextPath}/submitComplaint" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="category" class="form-label">Category</label>
                            <select id="category" name="category" class="form-select">
                                <option value="Garbage Pileup">Garbage Pileup</option>
                                <option value="Broken Bin">Broken Bin</option>
                                <option value="Overflowing Bin">Overflowing Bin</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="photo" class="form-label">Upload Photo</label>
                            <input type="file" id="photo" name="photo" class="form-control" accept="image/*" required>
                        </div>
                        <input type="hidden" id="latitude" name="latitude">
                        <input type="hidden" id="longitude" name="longitude">
                        <button type="submit" class="btn-main-action mt-2">Submit Complaint</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Get location as soon as the page loads
        window.onload = function() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    document.getElementById('latitude').value = position.coords.latitude;
                    document.getElementById('longitude').value = position.coords.longitude;
                });
            }
        };
    </script>
</body>
</html>