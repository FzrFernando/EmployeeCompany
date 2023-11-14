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
	// Si el atributo login (Tiene recogido el usuario que se ha logueado) es nulo, me reenviará a una página de error 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}

	// Creamos un Employee que va a tener el valor del usuario que se ha logueado
	Employee emp = (Employee) session.getAttribute("login");
<<<<<<< HEAD
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
=======
	// Creamos un ArrayList de CompanyProject
>>>>>>> 52285a6717f9fc59d629e9133a3672635be655ba
	ArrayList <CompanyProject> listProject = new ArrayList<CompanyProject> ();
	
	// Le asignamos al ArrayList de CompanyProject todos los proyectos de una compañía
	listProject = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
	
	// Creo una variable LocalTime que será la que contendrá el tiempo de inicio de trabajo y tendrá el valor de la session 
	LocalTime start = (LocalTime) session.getAttribute("comienzo");
	
	// Este condicional se ejecutará si alguien ha pulsado en el botón de comenzar
	if (request.getParameter("go") != null) {
		// A la session le doy un atributo para el comienzo del tiempo con el tiempo actual en ese momento
		session.setAttribute("comienzo", LocalTime.now());
		// A la session le doy un atributo que será el proyecto que he seleccionado
		session.setAttribute("projectWork",request.getParameter("projectSelect"));
	// Este condicional se ejecutará si alguien ha pulsado en el botón de parar
	} else if (request.getParameter("finish") != null) {
		// Creo una variable LocalTime que será inicializada con el tiempo en el que se pulse el botón
		LocalTime stop = LocalTime.now();
		// Creo una variable int y con ChronoUnit obtendré los segundos que hay entre el comienzo y el final
		int minutes = (int) ChronoUnit.SECONDS.between(start, stop);
		
		// Creo un proyecto y le asigno el valor que encontraré gracias a la búsqueda de un proyecto por su id
		Project p = DbRepository.find(Project.class, Integer.parseInt(session.getAttribute("projectWork").toString()));
		
		// Así quito el tiempo que estaba antes
		session.removeAttribute("comienzo"); 
		// Creo un nuevo Empleado Proyecto con los valores de empleado, proyecto y tiempo que hemos obtenido anteriormente
		EmployeeProject ep = new EmployeeProject(emp, p, minutes);
		// Añado dicho Empleado Proyecto
		DbRepository.add(ep);
		start = null;
	}
%>

<form>
	<select name="projectSelect" class="form-select">
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
		<button type="submit" name="go" value="start" class="btn btn-success">Empezar</button>
		<%
	} else {
		%>
		<button type="submit" name="finish" value="stop" class="btn btn-danger">Parar</button>
		<%
	}
	%>
</form>
<<<<<<< HEAD
--%>
=======
<a href="listCompany.jsp">
		<button class="btn btn-primary">
			Volver atrás
		</button>
	</a>
>>>>>>> 52285a6717f9fc59d629e9133a3672635be655ba
</body>
</html>