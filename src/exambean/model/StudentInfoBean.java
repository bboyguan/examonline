package exambean.model;

public class StudentInfoBean {
	private String ID;		//学生号
	private String password;//学生密码
	private String name;	//学生姓名
	private String CLASS;	//学生班级
	private float score;	//学生成绩
	private float score_sing;	//学生单选题成绩
	private float score_muti;	//学生多选题成绩
	private float score_jud;	//学生判断题成绩
	private float score_fill;	//学生填空题成绩
	private float score_ess;	//学生简答题成绩
	private String grade;	//成绩等级评价
	public String getGrade() {
		return grade;
	}


	public void setGrade(String grade) {
		this.grade = grade;
	}


	public float getScore_sing() {
		return score_sing;
	}


	public void setScore_sing(float score_sing) {
		this.score_sing = score_sing;
	}


	public float getScore_muti() {
		return score_muti;
	}


	public void setScore_muti(float score_muti) {
		this.score_muti = score_muti;
	}


	public float getScore_jud() {
		return score_jud;
	}


	public void setScore_jud(float score_jud) {
		this.score_jud = score_jud;
	}


	public float getScore_fill() {
		return score_fill;
	}


	public void setScore_fill(float score_fill) {
		this.score_fill = score_fill;
	}


	public float getScore_ess() {
		return score_ess;
	}


	public void setScore_ess(float score_ess) {
		this.score_ess = score_ess;
	}


	public StudentInfoBean(String iD, String cLASS,String name,  float score_sing,
			float score_muti, float score_jud, float score_fill, float score_ess,float score,String grade) {
		super();
		ID = iD;
		this.name = name;
		CLASS = cLASS;
		this.score = score;
		this.score_sing = score_sing;
		this.score_muti = score_muti;
		this.score_jud = score_jud;
		this.score_fill = score_fill;
		this.score_ess = score_ess;
		this.grade=grade;
	}
	
	
	public StudentInfoBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudentInfoBean(String iD, String password, String name, String cLASS, float score) {
		super();
		this.ID = iD;
		this.password = password;
		this.name = name;
		this.CLASS = cLASS;
		this.score = score;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCLASS() {
		return CLASS;
	}
	public void setCLASS(String cLASS) {
		CLASS = cLASS;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
}
