package com.greensense.util;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/homepageAnalytics")
public class HomepageAnalyticsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ComplaintDAO complaintDAO = new ComplaintDAO();
        UserDAO userDAO = new UserDAO();
        CollaborationDAO collabDAO = new CollaborationDAO();

        int resolvedCount = complaintDAO.getResolvedComplaintsCount();
        int citizenCount = userDAO.getCitizenCount();
        int collabCount = collabDAO.getCollaborationsCount();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Create a JSON string with the data
        String json = String.format(
            "{\"resolved_complaints\": %d, \"community_volunteers\": %d, \"active_drives\": %d}",
            resolvedCount, citizenCount, collabCount
        );

        out.print(json);
        out.flush();
    }
}