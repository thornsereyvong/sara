var app = angular.module('upload',[]);

app.controller('uploadCtrl', function($scope, $http) {
	$scope.uploadFile = function(id, srcFolder){
		$http({
		    method: 'POST',
		    url: '${pageContext.request.contextPath}/upload/attachment/'+srcFolder,
		    enctype : 'multipart/form-data',
		    processData : false,
			contentType : false,
		    data:  new FormData(document.getElementById("id")),
		}).success(function(response) {		
			$scope.fileName = response.fileName;	
			alert($scope.fileName)
		});
	}
});