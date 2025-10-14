package com.greensense.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/getTruckLocations")
public class GetTruckLocationsServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        StringBuilder jsonArray = new StringBuilder("[");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM truck_locations");
             ResultSet rs = pstmt.executeQuery()) {

            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonArray.append(",");
                }
                jsonArray.append("{");
                jsonArray.append("\"truck_id\":").append(rs.getInt("truck_id")).append(",");
                jsonArray.append("\"lat\":").append(rs.getDouble("latitude")).append(",");
                jsonArray.append("\"lon\":").append(rs.getDouble("longitude"));
                jsonArray.append("}");
                first = false;
            }
            jsonArray.append("]");
            out.print(jsonArray.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}