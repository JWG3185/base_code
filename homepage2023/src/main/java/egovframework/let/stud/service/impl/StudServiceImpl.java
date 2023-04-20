package egovframework.let.stud.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.stud.service.StudService;
import egovframework.let.stud.service.StudVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("studService")
public class StudServiceImpl extends EgovAbstractServiceImpl implements StudService {
	
//	@Resource(name = "studDAO")
//	private StudDAO studDAO;
	
	@Resource(name="studMapper")
	private StudMapper studMapper;
	
//	public StudVO selectStud(StudVO vo) throws Exception {
//		return studDAO.selectStud(vo);
//	}
	
	public StudVO selectStud(StudVO vo) throws Exception {
		return studMapper.selectStud(vo);
	}
	
	//임시데이터 목록 가져오기
	public List<EgovMap> selectStudList(StudVO vo) throws Exception {
		return studMapper.selectStudList(vo);
	}
}
