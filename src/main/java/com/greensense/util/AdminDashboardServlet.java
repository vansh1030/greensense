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

@WebServlet("/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Security check: ensure an admin is logged in
        if (session == null || !"admin".equals(session.getAttribute("user_role"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp"); // Redirect non-admins to homepage
            return;
        }

        // --- Fetch all data for the dashboard ---
        ComplaintDAO complaintDAO = new ComplaintDAO();
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "unresolved"; // Default view
        }
        List<Complaint> complaints = complaintDAO.getComplaintsByStatus(statusFilter);
        
        int unresolvedCount = complaintDAO.getComplaintCountByStatus("unresolved");
        int inProgressCount = complaintDAO.getComplaintCountByStatus("in_progress");
        int resolvedCount = complaintDAO.getComplaintCountByStatus("resolved");
        
        // Fetch truck routes
        TruckDAO truckDAO = new TruckDAO();
        List<TruckRoute> truckRoutes = truckDAO.getAllRoutes();

        // --- Send all data to the JSP ---
        request.setAttribute("complaints", complaints);
        request.setAttribute("pendingCount", unresolvedCount);
        request.setAttribute("inProgressCount", inProgressCount);
        request.setAttribute("resolvedCount", resolvedCount);
        request.setAttribute("activeFilter", statusFilter);
        request.setAttribute("truckRoutes", truckRoutes);

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin_dashboard.jsp");
        dispatcher.forward(request, response);
    }
}