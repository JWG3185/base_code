package egovframework.let.test.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.test.service.TestService;
import egovframework.let.test.service.TestVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("testService")
public class TestServiceImpl implements TestService{

	@Resource(name="testMapper")
	private TestMapper testMapper;

	@Resource(name="egovTestIdGnrService")
	private EgovIdGnrService idgenService;
	
	
	//목록
	public List<EgovMap> selectTestList(TestVO vo) throws Exception {
		return testMapper.selectTestList(vo);
	}

	//상세정보
	public TestVO selectTest(TestVO vo) throws Exception {
		return testMapper.selectTest(vo);
	}

	//등록
	public String insertTest(TestVO vo) throws Exception {
		String id = idgenService.getNextStringId();
		vo.setTestId(id);
		testMapper.insertTest(vo);
		return id;
	}

	//수정
	public void updateTest(TestVO vo) throws Exception {
		testMapper.updateTest(vo);
	}

	//삭제
	public void deleteTest(TestVO vo) throws Exception {
		testMapper.deleteTest(vo);
	}

	@Override
	public int selectTestListCnt(TestVO vo) throws Exception {
		return testMapper.selectTestListCnt(vo);
	}

}
