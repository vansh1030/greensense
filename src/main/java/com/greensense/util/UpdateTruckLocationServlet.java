package com.greensense.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateLocation")
public class UpdateTruckLocationServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // In a real app, you'd get these from a GPS device. We'll use URL parameters.
        int truckId = Integer.parseInt(request.getParameter("truckId"));
        double lat = Double.parseDouble(request.getParameter("lat"));
        double lon = Double.parseDouble(request.getParameter("lon"));

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE truck_locations SET latitude = ?, longitude = ? WHERE truck_id = ?")) {

            pstmt.setDouble(1, lat);
            pstmt.setDouble(2, lon);
            pstmt.setInt(3, truckId);
            pstmt.executeUpdate();
            response.getWriter().println("Location updated for truck " + truckId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}