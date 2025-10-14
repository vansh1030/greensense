<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Live Truck Tracking - GreenSense</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style> #map { height: 600px; border-radius: var(--radius); } </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <h1 class="welcome-header mb-4">Live Truck Tracking</h1>
        <div class="card-custom">
             <div id="map"></div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // Your existing map JavaScript remains the same
        var map = L.map('map').setView([19.0760, 72.8777], 12);
        var truckMarkers = {}; 

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        function updateTruckLocations() {
            fetch('${pageContext.request.contextPath}/getTruckLocations')
                .then(response => response.json())
                .then(locations => {
                    locations.forEach(truck => {
                        var truckId = truck.truck_id;
                        var latLng = [truck.lat, truck.lon];
                        if (truckMarkers[truckId]) {
                            truckMarkers[truckId].setLatLng(latLng);
                         } else {
                            truckMarkers[truckId] = L.marker(latLng).addTo(map);
                         }
                        truckMarkers[truckId].bindPopup("<b>Truck ID: " + truckId + "</b>");
                    });
                });
        }
        setInterval(updateTruckLocations, 5000); 
        updateTruckLocations();
    </script>
</body>
</html>