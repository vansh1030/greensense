package com.greensense.util;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateStatus")
public class UpdateComplaintStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int complaintId = Integer.parseInt(request.getParameter("complaintId"));
        String newStatus = request.getParameter("status");

        ComplaintDAO complaintDAO = new ComplaintDAO();
        complaintDAO.updateComplaintStatus(complaintId, newStatus);

        // Redirect back to the complaints list to see the change
        response.sendRedirect("viewComplaints");
    }
}