package egovframework.let.test.service.impl;

import java.util.List;

import egovframework.let.test.service.TestVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("testMapper")
public interface TestMapper {

	//목록
	List<EgovMap> selectTestList(TestVO vo) throws Exception;

	//상세정보
	TestVO selectTest(TestVO vo) throws Exception;

	//등록
	void insertTest(TestVO vo) throws Exception;

	//수정
	void updateTest(TestVO vo) throws Exception;

	//삭제
	void deleteTest(TestVO vo) throws Exception;

	int selectTestListCnt(TestVO vo) throws Exception;

}
