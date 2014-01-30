# **도움말**

master
----
## Version 0.1.0 
* 오류 
 - CORS방식으로 server쪽과 통신중 delay가 이유없이 길게 걸린다. 해당 부분은 클라이언트, 서버쪽 CORS부분을 좀 수정해야 할듯함.
 - 차트 부분 미완성 처리 기타 UI처리가 필요함....  성능향상이 필요함.. elasticsearch쪽 요청시 약간의 딜레이가 발생 해당부분은 서버와 클라이언트 둘다 디버깅이 필요
 - brunch로 빌드시 현재는 개발버전이므로 release에 맞게끔 빌드처리한다. 
 - 로그인처리시 현재는 테스트로 하였음..  보안기능이 들어가야함.
 - 기타 등등의 오류가 있음..  

* 현재는 테스트 버전입니다. 


## **1. 설명서**
* Controller
 - 페이지별 controller는 view를 가져와 연동하여 처리함.. 

* models
 - 데이타 연동 

* utils
 - 공통적으로 사용하는 ajax, time기타 등등으로 구성되어 있다.

* View 
 - 화면뷰를 구성할때 레이아웃을 기능별로 모듈화하여 개발을 하였다.
	 - 차트기능
	 - 검색
	 - 폼 
	 - 테이블
	 - 팝업 다이얼로그
	 - 겔러리
	 - 타임피크
	 - 스피너 ( 작업 진행중 loading)
	 - 페이지네이션
	 - notification 팝업 이벤트 
	 - 구글맵 연동 
	 - 로그인.. 
	 - 기타등등 공통으로 사용하는 기능별로 모듈화 하여 View를 구성한다.
	 - 각 페이지별 뷰


##  **2. Install**
* 프론트 개발빌드툴은 Node npm을 설치하여 [brunch](http://en.wikipedia.org/wiki/Brunch)를 사용하였다. 
* 사용방법 : `npm install -g brunch`

## **3. 빌드 && 실행**
* `brunch build`
* `brunch watch --server` OR 
 `node server/server.js` OR 
 `forever start server/server.js` OR
 `./start.sh`
* 실행되는 클라이언트 서버는 node express를 사용한다. 
 `package.json`에 정의된 내용을 확인해보면 여러가지 라이브러리를 넣었다..
 빌드, 테스트, 서버실행을 위해 필요한 항목들이다. 

## **4. library**

##### 3.1 js 라이브러리
* `jQuery 1.10.2` - `Dom`객체 제어를 위해서 사용한다. 기타 몇가지 UI등 처리 
* `Backbone 1.0.0` - 완변한 MVC는 아니지만 간단한 골격을 만들어주는 라이브러리 무지 가벼우며 프론트 개발을 좀더 수월하게 해줌.
* `Underscore 1.5.1` - `backbone의 의존성` 유틸 라이브러리 
* `Twitter Bootstrap 2.2.2` - UI 라이브러리 JS
* `MarionetteJS 1.0.3` - [마리오네트 홈페이지](http://marionettejs.com/)

##### 3.2 css 라이브러리
* `bootstrap` - css layout등의 처리를 위해서 기본으로 사용하는 UI 라이브러리이다. 

##### 3.3 template 라이브러리
* `Handlebars` - 클라이언트 템플릿 라이브러리중 handlebars를 사용하기로 하였다.
이유는 다양한 helper를 작성할수가 있어서 맘에 들었다 또한 편의성..  루비와 비슷한 문법 ... 성능상으로 다른 것과 차이는 모르겠음..


##### 3.4 javascript complie 
* `coffeescript` - 
 1. 자바스크립트를 단순히 루비와 같은 문법으로 작성할수가 있음.
 2. 깔끔한 문법
 3. 자바스크립트의 좋은 부분만 생성
 4. 다양한 function 지원 callback관련 처리 등등 자바스크립트에서 많은 코딩부분을 쉽고 보기좋게 코딩이 가능하다. 
 5. 루비와 같은 스트링 처리가 가능하다. ...
 6. ..... 책을 참고하자.. 
 [coffeescript 장점](http://devthewild.tistory.com/14)



## **5. Groc Docs** 
 `Markdown`방식의 문법의 Document를 생성해준다. 
 최신버전 [groc](https://github.com/nevir/groc)을 다운받아서 사용한다. 
 `npm install -g groc` = 절대 sudo로 설치하지 말자..  이건 권고사항이니...
 groc설치문제시 직접 github에서 최신버전을 받아서 설치하거나 npm을 업데이트한다. 
 
 * 사용방법 : `.groc.json`을 설정하거나 직접한다. 
 * 명령어 : `groc`



## **6. 문의**
기타 이상이 있을시 **csk6124@gmail.com** 에게 문의하세요..


