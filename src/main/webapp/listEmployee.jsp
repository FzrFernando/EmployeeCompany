<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Employee</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
	<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}
	
	Employee emp = DbRepository.find(Employee.class, (Integer)session.getAttribute("idUser"));
	
	ArrayList<Employee> result = null;
	
	try{
		result = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
	} catch (Exception e) {
		
	}
	%>
	
	<a>
		<button>
			Asignar Trabajo
		</button>
	</a>
	
	<table class="table">
		<thead>
			<tr>
				<th scope="col">Id</th>
				<th scope="col">Nombre</th>
				<th scope="col">Apellidos</th>
				<th scope="col">Email</th>
				<th scope="col">Género</th>
				<th scope="col">Fecha de Nacimiento</th>
				<th scope="col">Nombre Compañía</th>
				<%
				if(emp.getRole().equals("ADMIN")){
				%>
				<th>Edit</th>
				<th>Delete</th>	
				<% 
				}
				%>																			
			</tr>
		</thead>
		<tbody>
			<%
			for (Employee e : result) {
			%>
			<tr>
				<td><%=e.getId()%></td>
				<td><%=e.getFirstName()%></td>
				<td><%=e.getLastName()%></td>
				<td><%=e.getEmail()%></td>
				<td><%=e.getGender()%></td>
				<td><%=e.getDateOfBirth()%></td>
				<td><%=e.getCompany().getName()%></td>
				<%
				if(emp.getRole().equals("ADMIN")){
				%>
				<td>
					<form action="editEmployee.jsp">
						<input id="id" name="id" type="text" value='<%=e.getId()%>' hidden>
						<div class="form-group row">
	      					<div class="offset-4 col-8">
	      						<button name="submit" type="submit" class="btn btn-primary">Editar</button>
	      					</div>
	      				</div>
					</form>
				</td>
				<td>
					<form action="deleteEmployee.jsp">
						<input id="id" name="id" type="text" value='<%=e.getId()%>' hidden>
						<div class="form-group row">
	      					<div class="offset-4 col-8">
	      						<button name="submit" type="submit" class="btn btn-primary">Eliminar</button>
	      					</div>
	      				</div>
					</form>
				</td>
			</tr>
			<%
				}
			}
			%>
		</tbody>
	</table>
</body>
</html>