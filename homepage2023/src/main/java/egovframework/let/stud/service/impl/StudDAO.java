package egovframework.let.stud.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.let.stud.service.StudVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("studDAO")
public class StudDAO extends EgovAbstractDAO{

	public StudVO selectStud(StudVO vo) throws Exception {
		return (StudVO)select("StudDAO.selectStud", vo);
	}
}
