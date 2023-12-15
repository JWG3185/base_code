package egovframework.let.test.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface TestService {

	//목록
	public List<EgovMap> selectTestList(TestVO vo) throws Exception;

	//상세정보
	public TestVO selectTest(TestVO vo) throws Exception;

	//등록
	public String insertTest(TestVO vo) throws Exception;

	//수정
	public void updateTest(TestVO vo) throws Exception;

	//삭제
	public void deleteTest(TestVO vo) throws Exception;

	public int selectTestListCnt(TestVO vo) throws Exception;

}
