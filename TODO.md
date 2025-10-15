# TODO: Modify Complaint Management Table

## Frontend Changes
- [x] Remove Action column from admin_dashboard.jsp table
- [x] Update status select options to "unresolved", "in progress", "resolved"
- [x] Add CSS for borders and spacing in style.css

## Backend Changes
- [x] Update sql_setup.sql: Change complaints.status enum to ('unresolved', 'in_progress', 'resolved')
- [x] Update ComplaintDAO.java: Change default status in addComplaint to 'unresolved'
- [x] Update ComplaintDAO.java: Adjust getComplaintsByStatus for "unresolved" to include 'unresolved', 'in_progress'
- [x] Update ComplaintDAO.java: Update getComplaintCountByStatus for new statuses
- [x] Update AdminDashboardServlet.java: Adjust count logic for stats (unresolved = unresolved + in_progress? Wait, decide mapping)
- [x] Update UpdateComplaintStatusServlet.java: Ensure it handles new statuses

## Database Migration
- [x] Run SQL to update existing 'submitted' to 'unresolved' in complaints table

## Testing
- [x] Test the dashboard, ensure table displays correctly, status updates work
