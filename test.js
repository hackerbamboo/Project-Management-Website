var user_id;
var proj_id_global;
var tabCounter_t = 1;
var tabCounter_c = 1;
var tabTemplate = "<li><a href='#{href}'>#{label}</a></li>";

$(function(){
			$.ajaxSetup({
				type: "POST",
				async: true,
				cache: false,
				timeout: 5000,
				error: function(jqXHR, statusMsg) {
					if (statusMsg == "timeout") {
						alert("Ajax request timed out after 5 seconds!");
					} else {
						alert("Error occurred during Ajax request: " + jqXHR.status + " " + jqXHR.statusText);
					}
				}
			});		
			
			//////////////////////////////////////////////
			$("#login1").dialog({
				closeOnEscape : true,
				modal : true,
				position : {
					my : "center",
					at : "center"
				},
                create: function (event, ui) {
					$(".ui-dialog-titlebar").hide();
				},
				width: "350",
				height: "300",			
				autoOpen: false,
                show: "blind",
                hide: "fold",
				close: function(){
					$(".login input[type!='button']").val( "" );
				}
			});	

			$("#signinButton").on("click", function(){
                $("#login1").dialog("open");});
			
            $("#login1>form").bind("submit",validatefunction_in);
			$("#login_submit").bind("click",function(){
                $("#login1>form").trigger("submit",[ $("#email").val() , $("#pswd").val() ]);});

			//////////////////////////////////////////
			
			$("#login2").dialog({
				closeOnEscape : true,
				modal : true,
				position : {
					my : "center",
					at : "center"
				},
                create: function (event, ui) {
					$(".ui-dialog-titlebar").hide();
				},
				width: "350",
				height: "420",			
				autoOpen: false,
                show: "blind",
                hide: "fold"
			
			});
			
			$("#signupButton").click(function(){
				$("#login2").dialog("open");
			});
			
			$("#login2>form").bind("submit",validatefunction_up);
			$("#logup_submit").bind("click",function(){
                $("#login2>form").trigger("submit",
				[ $("#firstname").val(), $("#lastname").val(), $("#Upemail").val() , $("#Uppswd").val() ]);});
			
            ////////////////////////////////////////////////////////////////////////////
			
            $("#in_close").click(function(){
                $("#login1").dialog("close");
                $("#login1 .hint").hide();});
			
			$("#up_close").click(function(){
                $("#login2").dialog("close");
                $("#login2 .hint").hide();});	
			
			/////////////////////////////////////////////////////////////////////////////
			$("#logout_submit").click(function(){
			
				$("#header").hide();
				$("#maincontent").hide();
				$("#projects").empty();
				$("#totalaccordion").empty();
				$("legend").after().remove();
				$("#homepage").show();
				$('body').removeClass("background");
			
			})
			/////////////////////////////////////////////////////////////////////////////
		$("#add_milestone_dialog").dialog({
				closeOnEscape : true,
				modal : true,
				position : {
					my : "center",
					at : "center"
				},	
				title: "New Milestone",
				autoOpen: false,
                show: "blind",
                hide: "fold"
			});
		
		$("#add_comment_dialog").dialog({
				closeOnEscape : true,
				modal : true,
				position : {
					my : "center",
					at : "center"
				},	
				title: "New Comment",
				autoOpen: false,
                show: "blind",
                hide: "fold"
			});
		
		$("#add_milestone_date").datepicker({
					dateFormat: "mm/dd/yy"
				});
				$("#add_comment_date").datepicker({
					dateFormat: "mm/dd/yy"
				});
	
		$("#edit_user_icon").on("click",function(){
			$.ajax("jsp/edituser.jsp",{
				data: {
					id: user_id
				},
				success: showEditUser
			});
		});
		
		
		$("#edit_user_dialog").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "400",
			height: "420",
			title: "Edit User",
			close: function(evt,ui){$("#edit_user_dialog>form").remove();},
			show: "blind"
		});
		
		
		
		$("#projects").tabs({
				event : "click",
				active: true,
				collapsible : false,
				hide : {effect : "fade", duration : 500},
				show : {effect : "fade", duration : 500}
			});
			
			
		$("#edit_project_dialog").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "500",
			height: "520",
			title: "Edit Project",
			close: function(evt,ui){$("#edit_project_dialog>form").remove();},
			show: "blind"
		});
		
		$("#edit_milestone_dialog").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "420",
			height: "280",
			title: "Edit Milestone",
			close: function(evt,ui){$("#edit_milestone_dialog>form").remove();},
			show: "blind"
		});
		$("#edit_comment_dialog").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "420",
			height: "280",
			title: "Edit Comment",
			close: function(evt,ui){$("#edit_comment_dialog>form").remove();},
			show: "blind"
		});
		
		$("#delete_milestone_window").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "300",
			height: "300",
			show: "blind"
			
		});
		
		$("#delete_comment_window").dialog({
			autoOpen: false,
			modal : true,
			position : {
					my : "center",
					at : "center"
				},
			width : "300",
			height: "300",
			show: "blind"
			
		});
		
	});
	///////////////////////////////////////////////////////////////////
		function validatefunction_in(evtObj, email, pswd){
			var emailvalue = $.trim(email);
			var pswdvalue = $.trim(pswd);
            if(emailvalue=="" || pswdvalue=="")
            {
                $("#login1").effect("shake");
                $("#login1 .hint").show().text("Please fill out the form.");
                    
            }
            else{
				$.ajax("jsp/login_page.jsp", {
					data:{
						u_email: emailvalue,
						u_pswd: pswdvalue
					},
					success: validateresult
				});
				
			}
            return false;
		};
			
		function validateresult(respText, statusMsg, jqXHR){
			if($.trim(respText) == "Success"){
				$("#login1").dialog("close");
				$("#homepage").hide();
				$("body").addClass("background");
				$("#header").show();
				$("#maincontent").show();
				$.ajax("jsp/showuserinfo.jsp",{
					data:{
						email : $("#email").val()
					},
					success: showUserInfo
				});
				$.ajax("jsp/showprojectinfo_test.jsp",{
					data:{
						email : $("#email").val()
					},
					success: showProjctInfo
				});
			}
			else if($.trim(respText) == "Wrong"){
				$("#login1").effect("shake");
				$("#login1 input[type='password']").val("");
                $("#login1 .hint").show().text("wrong password!");
			}
			else if($.trim(respText) == "No"){
				$("#login1").effect("shake");
                $("#login1 .hint").show().text("invalid email.");
				$("#login1 input[type='email']").val("");
			}
			else{
					
				alert("Database failed.");
			}
			
		}
		function validatefunction_up(evtObj, firstname,lastname, Upemail, Uppswd){
			var f_v = $.trim(firstname);
			var l_v = $.trim(lastname);
			var e_v = $.trim(Upemail);
			var p_v = $.trim(Uppswd);
            if(f_v=="" || l_v=="" ||e_v=="" || p_v=="")
            {
                $("#login2").effect("shake");
                $("#login2 .hint").show().text("Please fill out the form.");   
            }
			else if(!IsEmail(e_v)){
				$("#login2").effect("shake");
                $("#login2 .hint").show().text("Please type in an valid email"); 
				$("#login2 input[type='email']").val("");				
			}
			
			else if(p_v.length<6){	
				$("#login2").effect("shake");
                $("#login2 .hint").show().text("The password should be longer than 6");
				$("#login2 input[type='password']").val("");
			}
			else if(IsEmail(e_v)){
				$.ajax("jsp/logup_page.jsp", {
					data:{
						u_email: e_v
					},
					success: validateuser
				});
			}
            return false;
        };
		
		function validateuser(respText, statusMsg, jqXHR){
			if($.trim(respText) == "Wrong"){
				$("#login2").effect("shake");
                $("#login2 .hint").show().text("This email address has existed")
			}
			else if($.trim(respText) == "Success"){
				$.ajax("jsp/add_user.jsp",{
					data:{
						first_f : $("#Upfirstname").val(),
						last_f: $("#Uplastname").val(),
						email_f: $("#Upemail").val(),
						password_f: $("#Uppswd").val()
					},
					success: showmainpage
				});
			}
		};
		function IsEmail(email) {
			var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			return regex.test(email);
		};
		
		function showmainpage(){
			$("#login2").dialog("close");
			$("#homepage").hide();
			$("body").addClass("background");
			$("#header").show();
			//showUserInfo;
		}
		///////////////////////////////////////////////////////////////////////////////////
		function showUserInfo(respText, statusMsg, jqXHR){
			$("#userInfo").fadeIn(750);
			$("legend").after(respText).fadeIn(750);
			user_id = $("#user_id").val();
		};
		
		function showEditUser(respText, statusMsg, jqXHR){
			$("#edit_user_dialog").dialog("open");
			$("#edit_user_dialog").append(respText);
			$("#edit_user_dialog input[type='button']").bind("click",function(){
				$.ajax("jsp/updateuser.jsp",{
					data:{
						id: user_id,
						firstname: $("#FirstName").val(),
						lastname: $("#LastName").val(),
						title: $("#Title").val(),
						email: $("#Email").val(),
						password: $("Password").val()
					},
					success: updateUser
					
				})
			
			});
		}
		
		
		function updateUser(respText, statusMsg, jqXHR){
			var text = $.trim(respText);
			if(text == "Success"){
				$("#edit_user_dialog").dialog("close");
				$("legend").next().remove();
				$.ajax("jsp/aftereditshowuserinfo.jsp",{
					data:{
						id : user_id
					},
					success: showUserInfoAgain
				});
			}
		
		}
		
		function showUserInfoAgain(respText, statusMsg, jqXHR){
			$("legend").after(respText);
		}
		
		
		
		
		
		function showProjctInfo(respText, statusMsg, jqXHR){
			$("#projects").fadeIn(750);
			$("#projects").children().remove();
			$("#projects").append($.trim(respText));
			$("#projects").tabs("refresh");
			
			
			$("input[value='Edit']").on("click",function(){
				var text_id = $(this).parent().attr("id");
				var proj_id = text_id[5];
				$.ajax("jsp/editproject.jsp",{
				data: {
					id: proj_id
				},
				success: showEditProject
				});
			
			
			});
			
			$("input[value='Detail']").on("click",function(){
				var text_id = $(this).parent().attr("id");
				var proj_id = text_id[5];
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: proj_id
				},
				success: showAccordion
				});
			
			});
			
		}
		
		
		function showEditProject(respText, statusMsg, jqXHR){
			$("#edit_project_dialog").dialog("open");
			$("#edit_project_dialog").append(respText);
			var proj_id = $("#edit_project_dialog input[type='hidden']").val();
			$("#edit_project_dialog input[type='button']").bind("click",function(){
				$.ajax("jsp/updateproject.jsp",{
					data:{
						id: proj_id,
						proj_name: $("#name_proj_"+proj_id).val(),
						proj_number: $("#number_proj_"+proj_id).val(),
						billing_code: $("#billing_proj_"+proj_id).val(),
						proj_description: $("#description_proj_"+proj_id).val(),
						client_name: $("#client_proj_"+proj_id).val(),
						timeframe: $("#timeframe_proj_"+proj_id).val()
					},
					success: updateProject
					
				})
			
			});
		}
	
		function updateProject(respText, statusMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#edit_project_dialog").dialog("close");
				$.ajax("jsp/showprojectinfo_test2.jsp",{
					data:{
						id : text[0]
					},
					success: showProjctInfo
				});
			}
		}
		
		
		function showAccordion(respText, statusMsg, jqXHR){
			var text = $.trim(respText);
			$("#totalaccordion").children().remove();
			$("#totalaccordion").append(text);
			var proj_id = $("#totalaccordion input[type='hidden']").val();
		
			$("#accordion_proj_"+proj_id).accordion({
				heightStyle: "content"
			});
			$("#totalaccordion").show();
			
			$("input[class='me_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var mile_id = text_id.substring(7);
				$.ajax("jsp/editmilestone.jsp",{
					data: {
						id : mile_id
					},
					success:showEditMilestone
				});
			});
			
			$("input[class='ce_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var com_id = text_id.substring(7);
				$.ajax("jsp/editcomment.jsp",{
					data: {
						id : com_id
					},
					success:showEditCom
				});
			
			});
			
			$("input[class='md_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var mile_id = text_id.substring(9);
				$("#delete_milestone_window").dialog("open").dialog({
					buttons: {
						"Delete Comfirm": function() {
							$( this ).dialog( "close" );
							$.ajax("jsp/deletemilestone.jsp",{
								data:{
									id: mile_id
								},
								success: updateMilestone_delete
							});
						},
						Cancel: function() {
							$( this ).dialog( "close" );
						}
					}
				
				});
				
			});
			
			$("input[class='cd_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var com_id = text_id.substring(9);
				$("#delete_comment_window").dialog("open").dialog({
					buttons: {
						"Delete Comfirm": function() {
							$( this ).dialog( "close" );
							$.ajax("jsp/deletecomment.jsp",{
								data:{
									id: com_id
								},
								success: updateComment_delete
							});
						},
						Cancel: function() {
							$( this ).dialog( "close" );
						}
					}
				
				});
				
			});

			$("input[class='ma_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var proj_id = text_id.substring(10);
				$("#add_milestone_dialog").dialog("open");
				$("#add_milestone_dialog>form").bind("submit", addMilestone);
				$("#add_milestone_submit").bind("click",function(){
					$("#add_milestone_dialog>form").trigger("submit",
					[ proj_id, $("#add_milestone_text").val(), $("#add_milestone_date").val()]);});
			
			});
			$("input[class='ca_button']").on("click",function(){
				var text_id = $(this).attr("id");
				var proj_id = text_id.substring(10);
				$("#add_comment_dialog").dialog("open");
				$("#add_comment_dialog>form").bind("submit", addComment);
				$("#add_comment_submit").bind("click",function(){
					$("#add_comment_dialog>form").trigger("submit",
					[ proj_id, $("#add_comment_text").val(), $("#add_comment_date").val()]);});
			
			});
			
		}
		
		function showEditMilestone(respText, StausMsg, jqXHR){
			$("#edit_milestone_dialog").dialog("open");
			$("#edit_milestone_dialog").append(respText);
			var milestone_id = $("#edit_milestone_dialog input[type='hidden']").val();
			
			$("#edit_milestone_dialog input[type='button']").bind("click",function(){
				$.ajax("jsp/updatemilestone.jsp",{
					data:{
						id: milestone_id,
						milestone_text: $("#text_milestone_"+milestone_id).val(),
						milestone_date: $("#date_milestone_"+milestone_id).val(),
						entered_by: user_id,
					},
					success: updateMilestone
					
				})
			
			});
		}
		
		
		function updateMilestone(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#edit_milestone_dialog").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				});
			}
		}
		
		function updateMilestone_delete(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#delete_milestone_window").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				});
			}
		}
		
		
		function showEditCom(respText, StausMsg, jqXHR){
			$("#edit_comment_dialog").dialog("open");
			$("#edit_comment_dialog").append(respText);
			var comment_id = $("#edit_comment_dialog input[type='hidden']").val();
			
			
			$("#edit_comment_dialog input[type='button']").bind("click",function(){
				$.ajax("jsp/updatecomment.jsp",{
					data:{
						id: comment_id,
						comment_text: $("#text_comment_"+comment_id).val(),
						comment_date: $("#date_comment_"+comment_id).val(),
						entered_by: user_id,
					},
					success: updateComment
					
				})
			
			});
		}
		
		
		function updateComment(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#edit_comment_dialog").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				//compelete: $("#accordion_proj_"+text[0]).accordion({active: 2})
				});
			}
		}
		
		function updateComment_delete(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#delete_comment_window").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				//compelete: $("#accordion_proj_"+text[0]).accordion({active: 2})
				});
			}
		}
		
		function addMilestone(evtObj, proj_id , milestone_text, milestone_date){
			var proj_id = $.trim(proj_id);
			var milestone_text = $.trim(milestone_text);
			var milestone_date = $.trim(milestone_date);
			
			if (milestone_text == "" || milestone_date =="")
			{
				$("#add_milestone_dialog").effect("shake");
                $("#add_milestone_dialog .hint").show().text("Please fill out the form.");   
			}
			else{
				$.ajax("jsp/addmilestone.jsp", {
					data:{
						id: proj_id,
						milestone_text: milestone_text,
						milestone_date: milestone_date,
						user: user_id
					},
					success: addMilestone_update
				})
			}
			return false;
			
		}
		
		function addMilestone_update(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#add_milestone_dialog").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				//compelete: $("#accordion_proj_"+text[0]).accordion({active: 2})
				});
			}
		
		}
		
		
		function addComment(evtObj, proj_id , comment_text, comment_date){
			var proj_id = $.trim(proj_id);
			var comment_text = $.trim(comment_text);
			var comment_date = $.trim(comment_date);
			
			if (comment_text == "" || comment_date =="")
			{
				$("#add_comment_dialog").effect("shake");
                $("#add_comment_dialog .hint").show().text("Please fill out the form.");   
			}
			else{
				$.ajax("jsp/addcomment.jsp", {
					data:{
						id: proj_id,
						comment_text: comment_text,
						comment_date: comment_date,
						user: user_id
					},
					success: addComment_update
				})
			}
			return false;
			
		}
		
		function addComment_update(respText, StausMsg, jqXHR){
			var text = $.trim(respText);
			var t_text = text.substring(1);
			
			if(t_text == "Success"){
				$("#add_comment_dialog").dialog("close");
				$.ajax("jsp/showmilestone.jsp",{
				data: {
					id: text[0]
				},
				success: showAccordion
				//compelete: $("#accordion_proj_"+text[0]).accordion({active: 2})
				});
			}
		
		}
		