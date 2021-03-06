package helloJsp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** * Servlet implementation class Controller */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private static String DELETE_JSP = "/Delete.jsp";
  private static String EDIT_JSP = "/Edit.jsp";
  private static String SHOWALL_JSP = "/ShowAll.jsp";

  
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      String s = request.getParameter("idPage");
      String forward="";
      forward = "/Delete.jsp";
      RequestDispatcher view = request.getRequestDispatcher(forward);
      view.forward(request, response);
	  /*
	  
    // Get a map of the request parameters
    @SuppressWarnings("unchecked")
    Map parameters = request.getParameterMap();
    if (parameters.containsKey("delete")){
      forward = DELETE_JSP;
    } else if (parameters.containsKey("edit")){
      forward = EDIT_JSP;
    } else {
      forward = SHOWALL_JSP;
    }
    RequestDispatcher view = request.getRequestDispatcher(forward);
    view.forward(request, response);*/
  }
} 