package com.kh.icu.common.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.icu.common.model.service.AlarmService;
import com.kh.icu.common.model.vo.Alarm;
import com.kh.icu.member.model.vo.Member;

@Controller
public class AlarmController {
	@Autowired
	private AlarmService alarmService;
	
	@RequestMapping("alarm")
	@ResponseBody
	public String alram(HttpSession session, Model model) {
		 Member loginUser = (Member)session.getAttribute("loginUser");
		 int memNo = loginUser.getMemNo();
		List<Alarm> alarmList = alarmService.selectAlarmList(memNo);
		System.out.println("??????????"+alarmList);
		model.addAttribute("alarmList",alarmList);
		String alist = new Gson().toJson(alarmList);
		System.out.println(alist);
		//model.addAttribute("list", list);
		// 1. 모델로 alarmList
		return alist;
	}
	
}