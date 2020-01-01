$(document).ready(function(){

		$("#verify_btn" ).click(function(e){
			e.preventDefault();
			/*$(".payform").show();*/
			$("#verifyform").modal({keyboard: true});
		
	});
	
	  $("#treasurer_council").change(function(){
  
    //get group members info based on selected group
     var selectedCouncil = $('#treasurer_council option:selected').text();
    
    $.getJSON('/treasurers/'+selectedCouncil+'/pull_branches').done(function(data){
			
			table_data = "<select class='form-control' name='treasurer[branch_id]' id='treasurer_branch_id'>"
			for (var i = 0; i < data.length; i++) {
         if(data[i].branch_selected == "yes"){
					 table_data = table_data + "<option selected value=\'"+data[i].branch_name+"\'>"+data[i].branch_name+"</option>"
				 }else{
					 table_data = table_data + "<option value=\'"+data[i].branch_name+"\'>"+data[i].branch_name+"</option>"
				 }
          
       
       }
			table_data = table_data + "</select>"
			
			 $('#branch_data').html(table_data);
			      
});
    
  }).change();
	
	
});