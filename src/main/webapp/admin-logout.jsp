<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    session.removeAttribute("adminId");
    session.removeAttribute("adminName");
    response.sendRedirect("admin-login.jsp?msg=logged_out");
%>
