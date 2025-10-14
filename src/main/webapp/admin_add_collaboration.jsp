<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Collaboration - GreenSense</title>
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
                    <h1 class="welcome-header mb-4">Add a New Collaboration or Event</h1>
                    <form action="${pageContext.request.contextPath}/addCollaboration" method="post">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" id="title" name="title" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="5" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="contactInfo" class="form-label">Contact Info (Optional)</label>
                            <input type="text" id="contactInfo" name="contactInfo" class="form-control">
                        </div>
                        <button type="submit" class="btn-main-action mt-2">Post Collaboration</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>