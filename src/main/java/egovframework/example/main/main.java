package egovframework.example.main;

public class main {
	 public static final String dir=System.getProperty("user.dir");
	public static void main(String[] args) {
		
		
		//String a=property.dir;
		//System.out.println("! "+a);
		System.out.println("dir::"+dir);
		String rootPath = System.getProperty("user.dir");
		System.out.println("절대 경로 방법1: "+rootPath);
		/*for(int i=0; i< list.length;i++) {
			
			System.out.println(list[i]);
		}
		*/
	}

}
