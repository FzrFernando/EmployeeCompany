<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.util.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Time Job</title>
</head>
<body>
<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}

	Employee emp = (Employee) session.getAttribute("login");
	
%>
	<h1>Proyectos</h1>
	<table>
		<thead>
			<tr>

				<th scope="col">Nombre projecto</th>
				<th scope="col">Estado</th>
			</tr>
		</thead>
		<tbody>
		<%
			for (CompanyProject cp : emp.getCompany().getCompanyProject()) {
				Date fechaActual = new Date();
				if (cp.getEnd().after(fechaActual)) {//Es after pero para no tener que cambiar la bbdd
			%>
			<tr>
				<form>
				<td><%=cp.getProject().getName()%></td>
				<%if(cp.getProject().getId()<=0){ %>
				<td>
					<button value="<%=cp.getProject().getId()%>" name="comienzo" type="submit">Comenzar a trabajar</button>
				</td>
				<%}else{ %>
				<td>
					<button value="<%=cp.getProject().getId()%>" name="final" type="submit">Terminar de trabajar</button>
				</td>
				<%} %>
				</form>
			</tr>
			<%
			}
			}
			%>
		</tbody>
	</table>
</body>
</html>