package egovframework.let.stud.service;

import java.util.List;

import egovframework.let.temp.service.TempVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface StudService {

	//임시데이터 가져오기
	public StudVO selectStud(StudVO vo) throws Exception;
	
	//임시데이터 목록 가져오기
	public List<EgovMap> selectStudList(StudVO vo) throws Exception;
}