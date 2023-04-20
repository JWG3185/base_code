package egovframework.let.stud.service.impl;

import java.util.List;

import egovframework.let.stud.service.StudVO;
import egovframework.let.temp.service.TempVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("studMapper")
public interface StudMapper {
	
	StudVO selectStud(StudVO vo) throws Exception;
	
	//임시데이터 목록 가져오기
	List<EgovMap> selectStudList(StudVO vo) throws Exception;
}
