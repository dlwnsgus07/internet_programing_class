package myBean;
 // 공백을 없에기 위해 선언한 Utill
public class Utll {
	public static String nullChk(String str) {
		return nullChk(str,"");
	}
	
	public static String nullChk(String str,String newStr) {
		if(str==null)
			return newStr;
		else
			return str;
	}
}
