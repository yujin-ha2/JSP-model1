package project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginCheck")
public class LoginCheck extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");

        MemberDao dao = new MemberDao();
        String id = request.getParameter("id");
        PrintWriter out = response.getWriter();

        boolean checkID = dao.isIdCheck(id);
        if(!checkID) {
            out.print("not-usable");
        } else {
            out.print("usable");
        }
	}

}
