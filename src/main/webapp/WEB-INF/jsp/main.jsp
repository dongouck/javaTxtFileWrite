<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CONSOLE</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script>

	$(function(){
		$('.modify_line').hide();
		
		$('.submit').click(function(){
			register_new();
		});
		
		$('.table_line').dblclick(function(){
			$('.modify_line').hide();
			 $(this).next().show();
			var no=$(this).children().get(0);
		})
	})
	function register_new(){
		
		var id 		= $("#id").val();
		var name 	= $("#name").val();
		var phone 	= $("#phone").val();
		var email 	= $("#email").val();
		
		if ( id==null || id=='' || name==null || name=='' || phone==null || phone=='' || email==null || email=='' ) {
			alert('입력되지 않은 정보가 있습니다.');
			} else {
				$('#new_submit_form').submit();	
		}
	}
	function modify_fn(line_No) { 
		var selector = $("#number_"+line_No).val();
		var id = $("#id_"+line_No).val();
		var name = $("#name_"+line_No).val();
		var phone = $("#phone_"+line_No).val();
		var email = $("#email_"+line_No).val();
		
		if ( id==null || id=='' || name==null || name=='' || phone==null || phone=='' || email==null || email=='' ) {
			alert('입력되지 않은 정보가 있습니다.');
			} else {
				
				$("#selector").val(selector);
				$('#idUpdate').val(id);
				$('#nameUpdate').val(name);
				$('#phoneUpdate').val(phone);
				$('#emailUpdate').val(email);
				
				$("#modify_form").submit();
		}
	}
	function delete_fn(line_No) {
		var selector = $("#number_"+line_No).val();
		
		$("#del_selector").val(selector);
		$("#del_form").submit();
	}
	function cancel_fn() {
		$('.modify_line').hide();
	}

</script>
</head>
<body>
	<div class="nav navbar">
		<h2>고객정보 관리 시스템</h2>
		<div>
			<p class="lead bg-info"> * 신규 : 명단 아래에 신규 인원 정보를 입력하고 등록 버튼을 클릭하세요.</br> 
			* 수정/삭제 : 아래 명단에서 수정하고자 하는 인원을 더블클릭하면 수정 입력란, 삭제 버튼이 생깁니다.
			  </p>
		</div>
	</div>
	<div>
		<table class="table table-condensed">
			<thead>
				<tr>	
					<td>No</td>
					<td>ID</td>
					<td>성명</td>
					<td>전화번호</td>
					<td>이메일</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${memberList}" var="item" varStatus="status"> 
					<tr class="table_line">
						<td><c:out value="${status.index + 1}"></c:out></td>
						<td><c:out value="${item.id}"></c:out></td>
						<td><c:out value="${item.name}"></c:out></td>
						<td><c:out value="${item.phone}"></c:out></td>
						<td><c:out value="${item.email}"></c:out></td>
					</tr>
					<tr class="modify_line" id="line_${status.index + 1}">
						<td>▶<input type="hidden" 	id="number_${status.index + 1}"	value="<c:out value="${status.index + 1}"/>"></td>
						<td><input type="text" 		id="id_${status.index + 1}"		value="<c:out value="${item.id}"/>"/></td>
						<td><input type="text" 		id="name_${status.index + 1}"	value="<c:out value="${item.name}"/>"/></td>
						<td><input type="text" 		id="phone_${status.index + 1}"	value="<c:out value="${item.phone}"/>"/></td>
						<td><input type="text" 		id="email_${status.index + 1}"	value="<c:out value="${item.email}"/>"/></td>
						<td><button type="button" class="btn btn-default btn-sm" onclick="modify_fn('${status.index + 1}')">수정</button>
						<button type="button" class="btn btn-default btn-sm" onclick="delete_fn('${status.index + 1}')">삭제</button>
						<button type="button" class="btn btn-default btn-sm" onclick="cancel_fn()">취소</button></td>
					</tr>
				</c:forEach> 
			</tbody>
		</table>
		<form id="modify_form" 	action="/modify.do" 	method="post">
			<input type="hidden" 	id="selector" 			name="selector" 		value=""/>
			<input type="hidden" 	id="idUpdate" 			name="idUpdate" 		value=""/>
			<input type="hidden" 	id="nameUpdate" 		name="nameUpdate" 		value=""/>
			<input type="hidden" 	id="phoneUpdate"		name="phoneUpdate"		value=""/>
			<input type="hidden" 	id="emailUpdate"		name="emailUpdate"		value=""/>
		</form>
		<form id="del_form" action="/delete.do" method="post">
			<input type="hidden" id="del_selector" name="del_selector" value=""/>
		</form>
	</div>
	<div>
		<div>
			<form id="new_submit_form" action="/new/register.do" method="post">
				<div>
					<h4>신규 등록</h4>
				</div>
				<div>
					<input type="text" 	id="id" 		name="id" 		placeholder="ID"/>
					<input type="text" 	id="name" 		name="name" 	placeholder="성명"/>
					<input type="text" 	id="phone" 		name="phone" 	placeholder="전화번호"/>
					<input type="email" id="email" 		name="email"	placeholder="이메일"/>
					<button type="button" class="submit btn btn-default btn-sm">등록</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>