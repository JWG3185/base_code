package egovframework.let.test.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.test.service.TestService;
import egovframework.let.test.service.TestVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class TestController {

	@Resource(name = "testService")
	private TestService testService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	// 목록
	@RequestMapping("/test/selectList.do")
	public String selectList(@ModelAttribute("searchVO") TestVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		List<EgovMap> resultList = testService.selectTestList(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		int totCnt = testService.selectTestListCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("USER_INFO", user);
		
		return "test/TestSelectList";
		
	}
	
	// 등록/수정
	@RequestMapping("/test/testRegist.do")
	public String testRegist(@ModelAttribute("searchVO") TestVO testVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null || user.getId() == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/test/selectList.do";
		} else {
			model.addAttribute("USER_INFO", user);
		}
		
		TestVO result = new TestVO();
		if(!EgovStringUtil.isEmpty(testVO.getTestId() ) ) {
			result = testService.selectTest(testVO);
			//본인 및 관리자만 허용
			if(!user.getId().equals(result.getFrstRegisterId() ) && !"admin".equals(user.getId() ) ) {
				model.addAttribute("message", "작성자 본인만 확인 가능합니다.");
				return "forward:/test/selectList.do";
			}
		}
		
		model.addAttribute("result", result);
		
		//세션 초기화
		request.getSession().removeAttribute("sessionTest");
		
		return "test/TestRegist";
		
	}
	
	// 등록하기
	@RequestMapping(value = "/test/insert.do")
	public String insert(@ModelAttribute("searchVO") TestVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		//이중 서브밋 방지 체크
		if(request.getSession().getAttribute("sessionTest") != null) {
			return "forward:/test/selectList.do";
		}
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		if(user == null || user.getId() == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/test/selectList.do";
		}
		
		searchVO.setUserId(user.getId());
		searchVO.setFrstRegisterId(user.getId());
		
		testService.insertTest(searchVO);
		
		//이중 서브밋 방지
		request.getSession().setAttribute("sessionTest", searchVO);
		return "forward:/test/selectList.do";
		
	}
	
	//상세정보
	@RequestMapping(value = "/test/select.do")
	public String select(@ModelAttribute("searchVO") TestVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("USER_INFO", user);
		
		TestVO result = testService.selectTest(searchVO);
		
		model.addAttribute("result", result);
		return "test/TestSelect";
	}
	
	//게시물 수정하기
	@RequestMapping(value = "/test/update.do")
	public String update(@ModelAttribute("searchVO") TestVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		//이중 서브밋 방지 체크
		if(request.getSession().getAttribute("sessionTest") != null) {
			return "forward:/test/selectList.do";
		}
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null || user.getId() == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/test/selectList.do";
		}
		
		searchVO.setUserId(user.getId());
		searchVO.setLastUpdusrId(user.getId());
		
		testService.updateTest(searchVO);
		
		//이중 서브밋 방지
		request.getSession().setAttribute("sessionTest", searchVO);
		return "forward:/test/selectList.do";
	}

	//게시물 삭제하기
	@RequestMapping(value = "/test/delete.do")
	public String delete(@ModelAttribute("searchVO") TestVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null || user.getId() == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/test/selectList.do";
		}
		
		searchVO.setUserId(user.getId());
		
		TestVO exVO = testService.selectTest(searchVO);
		
		//본인 및 관리자만 허용
		if(!user.getId().equals(exVO.getFrstRegisterId() ) && !"admin".equals(user.getId() ) ) {
			model.addAttribute("message", "작성자 본인만 삭제 가능합니다.");
			return "forward:/test/selectList.do";
		}
		
		testService.deleteTest(searchVO);
		
		return "forward:/test/selectList.do";
	}

	
}
