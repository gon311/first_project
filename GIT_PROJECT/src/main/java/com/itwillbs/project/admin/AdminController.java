package com.itwillbs.project.admin;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {

	
@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Admin(Locale locale, Model model){
	
	
	
	return "admin/common/main";
	}
}
