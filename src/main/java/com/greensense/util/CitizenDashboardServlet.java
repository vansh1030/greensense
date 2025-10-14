package com.greensense.util;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/citizenDashboard")
public class CitizenDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int citizenId = (int) session.getAttribute("user_id");

        ComplaintDAO complaintDAO = new ComplaintDAO();
        UpdateDAO updateDAO = new UpdateDAO();

        // Get all data needed for the dashboard
        List<Complaint> myComplaints = complaintDAO.getComplaintsByCitizenId(citizenId);
        int[] complaintCounts = complaintDAO.getComplaintCountsByCitizenId(citizenId);
        List<Update> recentUpdates = updateDAO.getRecentUpdates(3); // Get top 3 recent updates

        // Send data to the JSP
        request.setAttribute("myComplaints", myComplaints);
        request.setAttribute("totalComplaints", complaintCounts[0]);
        request.setAttribute("resolvedComplaints", complaintCounts[1]);
        request.setAttribute("pendingComplaints", complaintCounts[2]);
        request.setAttribute("recentUpdates", recentUpdates);

        RequestDispatcher dispatcher = request.getRequestDispatcher("citizen_dashboard.jsp");
        dispatcher.forward(request, response);
    }
}