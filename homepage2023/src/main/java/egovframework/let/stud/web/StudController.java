package egovframework.let.stud.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.let.stud.service.StudService;
import egovframework.let.stud.service.StudVO;
import egovframework.let.temp.service.TempVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class StudController {
	
	@Resource(name = "studService")
	private StudService studService;
	
	//임시데이터 가져오기
	@RequestMapping(value = "/stud/select.do")
	public String select(StudVO studVO, HttpServletRequest request, ModelMap model) throws Exception{
		StudVO result = studService.selectStud(studVO);
		model.addAttribute("result", result);
		return "stud/StudSelect";
	}
	//임시데이터 목록 가져오기
	@RequestMapping(value = "/stud/selectList.do")
	public String selectList(StudVO studVO, HttpServletRequest request, ModelMap model) throws Exception{
		//List : java.util.List
		List<EgovMap> resultList = studService.selectStudList(studVO);
		model.addAttribute("resultList", resultList);
		
		return "stud/StudSelectList";
	}
	
	//임시데이터 등록/수정
		@RequestMapping(value = "/stud/studRegist.do")
		public String studRegist(StudVO studVO, HttpServletRequest request, ModelMap model) throws Exception{
			
			return "stud/StudRegist";
		}
}
