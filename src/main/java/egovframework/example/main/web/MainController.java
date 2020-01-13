package egovframework.example.main.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	
	
	@RequestMapping(value="/main.do")
	public String main ( ModelMap model, HttpServletRequest rq ) throws Exception {
		List <Map> memberList = new ArrayList<Map>();
		
        try {
			getTxtList(memberList, rq);
			
			} catch ( FileNotFoundException e ) {
				e.getStackTrace();
			} catch ( IOException e ) {
				e.getStackTrace();
		}
		model.addAttribute("memberList", memberList);
		return "main";
	}
	@RequestMapping(value="new/register.do")
	public String submit ( HttpServletRequest rq ) throws Exception {
		
		System.out.println("id : "+rq.getParameter("id"));
		System.out.println("name : "+rq.getParameter("name"));
		System.out.println("phone : "+rq.getParameter("phone"));
		System.out.println("email : "+rq.getParameter("email"));
		
		String storedData = rq.getServletContext().getRealPath("resources"+File.separator+"stored_data.txt");
		//String storedData = "E:\\temp\\stored_data.txt";
		String newMember = rq.getParameter("id")+" / "+rq.getParameter("name")+" / "+rq.getParameter("phone")+" / "+rq.getParameter("email");
		String temp;
		
		List <String> memberList = new ArrayList<String>();
		BufferedReader br = new BufferedReader(new FileReader(storedData));

		while((temp = br.readLine()) != null) {
			temp.split("/");
			memberList.add(temp);
		}
		memberList.add(newMember);
		
		FileWriter fw = new FileWriter(storedData);
		
        for ( String member : memberList ) {
            
            fw.write(member+"\r\n");
        }
        fw.close();
		
		return "redirect:/main.do";
	}
	@RequestMapping(value="/modify.do")
	public String modify ( HttpServletRequest rq ) throws Exception {
		System.out.println("start");
		List <String> memberList = new ArrayList<String>();
		String storedData = rq.getServletContext().getRealPath("resources"+File.separator+"stored_data.txt");
		String temp;
		
		BufferedReader br = new BufferedReader(new FileReader(storedData));
		int selector = Integer.parseInt(rq.getParameter("selector"))-1;
		String param = rq.getParameter("idUpdate")+" / "+rq.getParameter("nameUpdate")+" / "+rq.getParameter("phoneUpdate")+" / "+rq.getParameter("emailUpdate");
		
		while((temp = br.readLine()) != null) {
			temp.split("/");
			System.out.println("## "+temp);
			memberList.add(temp);
		}
		
		memberList.set(selector, param);
		
		FileWriter fw = new FileWriter(storedData);
		
        for(String member:memberList) {
            
            fw.write(member+"\r\n");
        }
        fw.close();
		
		return "redirect:/main.do";
	}
	
	@RequestMapping(value="/delete.do")
	public String del( HttpServletRequest rq) throws Exception {

		List <String> memberList = new ArrayList<String>();
		String storedData = rq.getServletContext().getRealPath("resources"+File.separator+"stored_data.txt");
		String temp;
		
		BufferedReader br = new BufferedReader(new FileReader(storedData));
		int selector = Integer.parseInt(rq.getParameter("del_selector"))-1;
		
		while((temp = br.readLine()) != null) {
			temp.split("/");
			memberList.add(temp);
		}
		
		memberList.remove(selector);
		FileWriter fw = new FileWriter(storedData);
        for(String member:memberList) {
            fw.write(member+"\r\n");
        }
        fw.close();
		
		return "redirect:/main.do";
	}
	
	public List<Map> getTxtList ( List<Map>memberList , HttpServletRequest rq) throws Exception {
		
		String storedData = rq.getServletContext().getRealPath("resources"+File.separator+"stored_data.txt");
		String temp;
		BufferedReader br = new BufferedReader(new FileReader(storedData));
		System.out.println("storedData::"+storedData);
		while((temp = br.readLine()) != null) {
			
			Map<String, Object> element = new HashMap<String, Object>();
			String[] a=temp.split("/");
			element.put("id", a[0]);
			element.put("name", a[1]);
			element.put("phone", a[2]);
			element.put("email", a[3]);
			
			memberList.add(element);
		}
		br.close();
		return memberList;
	}
}
