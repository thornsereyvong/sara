<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<div class="col-sm-6">
		<label class="font-label">Status <span class="requrie">(Required)</span></label>
		<div class="form-group">
			<select class="form-control select2" name="cam_status"
				style="width: 100%;" id="cam_status">
				<option value="">-- SELECT Status --</option>
				<option ng-repeat="stat in camp_status" value="{{stat.statusID}}">{{stat.statusName}}</option>
			</select>
		</div>
	</div>
	<div class="col-sm-6">
		<label class="font-label">Type <span class="requrie">(Required)</span></label>
		<div class="form-group">
			<select class="form-control select2" name="cam_type"
				style="width: 100%;" id="cam_type">
				<option value="">-- SELECT Type --</option>
				<option ng-repeat="ty in camp_type" value="{{ty.typeID}}">{{ty.typeName}}</option>
			</select>
		</div>
	</div>
	<div class="col-sm-6">
		<label class="font-label">Parent campaign </label>
		<div class="form-group">
			<select class="form-control select2" name="cam_parent"
				style="width: 100%;" id="cam_parent">
				<option value="">-- SELECT Parent --</option>
				<option ng-repeat="cam in camp_parents" value="{{cam.campID}}">[{{cam.campID}}]
					{{cam.campName}}</option>
			</select>
		</div>
	</div>
	<div class="col-sm-6">
		<label class="font-label">Assigned to </label>
		<div class="form-group">
			<select class="form-control select2" name="cam_assignTo"
				id="cam_assignTo" style="width: 100%;">
				<option value="">-- SELECT User --</option>
				<option ng-repeat="user in users" value="{{user.userID}}">{{user.username}}</option>
			</select>
		</div>
	</div>



</body>
</html>