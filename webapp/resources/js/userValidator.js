function validateUser(){
	$("#addNewUser").bootstrapValidator({
		message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
		},	
		fields: {
			userId: {
                validators: {
                    notEmpty: {
                        message: 'The username is required'
                    }
                }
            },
            username: {
                validators: {
                    notEmpty: {
                        message: 'The username is required'
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
                        message: 'The password is required'
                    }
                }
            },
            selectStatus:{
                validators: {
                    notEmpty: {
                        message: 'The select status is required'
                    }
                }
            },
            selectApp:{
                validators: {
                    notEmpty: {
                        message: 'The select apps are required'
                    }
                }
            },
            selectRole:{
                validators: {
                    notEmpty: {
                        message: 'The select role is required'
                    }
                }
            },
            email:{
                validators: {
                    notEmpty: {
                        message: 'The email is required'
                    }
                }
            }
		}
     });
}