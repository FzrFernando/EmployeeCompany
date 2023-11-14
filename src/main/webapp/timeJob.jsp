<%@page import="java.util.HashMap"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}

	Employee emp = (Employee) session.getAttribute("login");
	HashMap<Integer, Integer> proyectos = (HashMap<Integer, Integer>) session.getAttribute("proyectos");

	LocalTime start = (LocalTime) session.getAttribute("comienzo");
	// Esto es para cuando vaya a empezar a trabajar
	if (request.getParameter("empezar") != null) {
		if (proyectos != null) {
			session.setAttribute("comienzo", LocalTime.now());
			proyectos.put(Integer.parseInt(request.getParameter("empezar")), start.getSecond());
		} else {
			proyectos = new HashMap<>();
			session.setAttribute("comienzo", LocalTime.now());
			proyectos.put(Integer.parseInt(request.getParameter("empezar")), start.getSecond());
			session.setAttribute("proyectos", proyectos);
		}
	}
	
	// En el caso de que vaya a terminar
	if (request.getParameter("terminar") != null) {
		LocalTime stop = LocalTime.now();
		int idProyecto = Integer.parseInt(request.getParameter("terminar"));
		int startTiempo = proyectos.get(idProyecto);
		proyectos.remove(idProyecto);
		int minutes = (int) ChronoUnit.SECONDS.between(start, stop);
		Project p = DbRepository.find(Project.class, idProyecto);
		EmployeeProject ep = new EmployeeProject(emp, p, minutes);
		
	}
%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Proyecto</th>
			</tr>
		</thead>
		<tbody>
			<% 
			// Listamos los proyectos
			for (CompanyProject cp : emp.getCompany().getCompanyProject()) {
				// Creo el tiempo de comienzo
			%>
			<tr>
				<% // En el caso de que ya existan proyectos
				if (proyectos != null) {
					%>
					<form>
						<td>
						<%=cp.getProject().getName()%>
						</td>
<!-- 						En el caso de que no esté el id del proyecto en el HashMap
							tendrá el botón para empezar a trabajar
-->
						<% if (proyectos.get(cp.getProject().getId())==null) {%>
							<td>
								<button value="<%=cp.getProject().getId()%>" name="empezar" type="submit">
								Empezar
								</button>
							</td>
							
							
						<%} 
						// Este sería el caso de que esté el id
						else { %>
							<td>
								<button value="<%=cp.getProject().getId()%>" name="terminar" type="submit">
								Terminar
								</button>
							</td>
						<% }%>
					</form>
					<%
				} 
				// Esto sería en el caso de que no haya proyectos en la session
				else {
				%>
				<form>
					<td>
					<%=cp.getProject().getName()%>
					</td>
					<td>
						<button value="<%=cp.getProject().getId()%>" name="empezar" type="submit">
						Empezar
						</button>
					</td>
				</form>
				
				
			</tr>
			<%
				}
			}
			%>
		</tbody>		
	</table>

	<a href="listCompany.jsp">
		<button name="cerrarSesion" type="submit">Atrás</button>
	</a>
	
<%-- 
	Solo funciona con un proyecto

	Employee emp = (Employee) session.getAttribute("login");
	ArrayList <CompanyProject> listProject = new ArrayList<CompanyProject> ();
	
	listProject = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
	
	LocalTime start = (LocalTime) session.getAttribute("comienzo");
	if (request.getParameter("go") != null) {
			session.setAttribute("comienzo", LocalTime.now());
			session.setAttribute("projectWork",request.getParameter("projectSelect"));
	} else if (request.getParameter("finish") != null) {
		LocalTime stop = LocalTime.now();
		int minutes = (int) ChronoUnit.SECONDS.between(start, stop);
		
		Project p = DbRepository.find(Project.class, Integer.parseInt(session.getAttribute("projectWork").toString()));
		
		session.removeAttribute("comienzo"); // Así quito el tiempo que estaba antes
		EmployeeProject ep = new EmployeeProject(emp, p, minutes);
		DbRepository.add(ep);
		start = null;
	}
%>

<form>
	<select name="projectSelect">
	<%for (CompanyProject cp : listProject) {
		if(cp.getCompany().getId() == emp.getCompany().getId()){
			%>
			<option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
			<%
		}
		%>
		<% 
	}
	%>
	</select>
	<% 
	if (request.getParameter("go") == null) {
		%>
		<button type="submit" name="go" value="start">Empezar</button>
		<%
	} else {
		%>
		<button type="submit" name="finish" value="stop">Parar</button>
		<%
	}
	%>
</form>
--%>
</body>
</html>