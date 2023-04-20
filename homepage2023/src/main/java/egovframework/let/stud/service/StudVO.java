package egovframework.let.stud.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;

public class StudVO extends ComDefaultVO implements Serializable{
	
	//임시데이터NUM
	private String studNum;
	
	//임시데이터NAME
	private String studName;

	public String getStudNum() {
		return studNum;
	}

	public void setStudNum(String studNum) {
		this.studNum = studNum;
	}

	public String getStudName() {
		return studName;
	}

	public void setStudName(String studName) {
		this.studName = studName;
	}

}
