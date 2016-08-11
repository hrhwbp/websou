package pack;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class World extends HttpServlet{
	
	@Override
	public void init() throws ServletException {	//서버의 초기화를 수행 (딱 한번만!)
		System.out.println("초기화 1회 수행");
	}
	
	@Override
	public void destroy() {
		System.out.println("서비스 종료시 1회 수행");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("get 방식으로 호출 시 매번 수행");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Post 방식으로 호출시 매번 수행");
	}
	
/*	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		//jsp는 serice method를 override 했기 때문에 이 method를 수행한다 
		System.out.println("get post 방식을 모두 처리");
	}*/
	
}
