package egovframework.let.temp.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.let.temp.service.TempVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("tempDAO")
public class TempDAO extends EgovAbstractDAO{

	public TempVO selectTemp(TempVO vo) throws Exception {
		return (TempVO)select("TempDAO.selectTemp", vo);
	}
}
// DB와 연결된 SQL에 있는 것을 찾아오는 것