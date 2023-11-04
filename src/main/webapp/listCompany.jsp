<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Company</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
	<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}
	ArrayList<Company> result = null;
	
	try{
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
	} catch (Exception e) {
		
	}
	%>
	<table class="table">
			<%
			for (Company c : result) {
			%>
		<thead>
			<tr>
				<th scope="col">Nombre</th>
				<th scope="col">Número Empleados</th>
				<th scope="col">Número Proyectos</th>
				<th></th>
				<th></th>																				
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=c.getName()%></td>
				<td><%=c.getEmployee().size()%></td>
				<td><%=c.getCompanyProject().size()%></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<th scope="col">Empleados</th>
			</tr>
				<% 
				for (Employee e : c.getEmployee()){
				%>
			<tr>
				<td><%=e.getFirstName() %></td>
				<td><%=e.getLastName() %></td>
			</tr>
				<%}%>
			<tr>
				<th scope="col">Proyectos</th>
			</tr>
				<% 
				for (CompanyProject cp : c.getCompanyProject()){
				%>
			<tr>
				<td><%=cp.getProject().getName() %></td>
				<td><%=cp.getProject().getButget() %></td>
			</tr>
				<%}%>
			<% 
			}
			%>
		</tbody>
	</table>
</body>
</html>