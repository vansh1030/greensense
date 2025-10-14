<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.greensense.util.Collaboration" %>
<!DOCTYPE html>
<html>
<head>
    <title>Collaborations & Events</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h1>Collaborations & Events</h1>
        <hr>
        <% 
            List<Collaboration> collaborations = (List<Collaboration>) request.getAttribute("collaborations");
            if (collaborations != null && !collaborations.isEmpty()) {
                for (Collaboration c : collaborations) {
        %>
        <div class="collab-card" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 15px; border-radius: 5px;">
            <h3><%= c.getTitle() %></h3>
            <p style="white-space: pre-wrap;"><%= c.getDescription() %></p>
            <% if (c.getContactInfo() != null && !c.getContactInfo().isEmpty()) { %>
                <p><strong>Contact:</strong> <%= c.getContactInfo() %></p>
            <% } %>
        </div>
        <% 
                }
            } else {
        %>
            <p>No collaborations or events have been posted yet.</p>
        <% } %>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>