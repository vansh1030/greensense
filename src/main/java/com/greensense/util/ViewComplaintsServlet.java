package com.greensense.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewComplaints")
public class ViewComplaintsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ComplaintDAO complaintDAO = new ComplaintDAO();
        List<Complaint> complaintList = complaintDAO.getAllComplaints();

        request.setAttribute("complaints", complaintList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin_view_complaints.jsp");
        dispatcher.forward(request, response);
    }
}