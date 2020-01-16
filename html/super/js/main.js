/*!
# A.Works Super script
# Laidback david 2019.01.06
*/

$(document).ready(function () {
	/* Sidebar Script */
	$('#sidebarCollapse').on('click', function () {
		$('#sidebar').toggleClass('active');
	});
	/* DatePicker Script */
	$('#datestart').datepicker({
		uiLibrary: 'bootstrap4',
		format: 'yyyy-mm-dd',
		footer: true,
		showOtherMonths: true,
	});
	$('#dateend').datepicker({
		uiLibrary: 'bootstrap4',
		format: 'yyyy-mm-dd',
		footer: true,
		showOtherMonths: true,
	});
});

/* modal progressbar button click Script */
var i = 0;
$(document).ready(function() {
	$("#reset").click(function() {
		$(':input','#attachmentModal').val("");
		$("#pbarmain").hide();
		$("#pbar").hide();
		$(".progress-bar").css("width", "0%");
		i = 0;
	});
});
function makeProgress(){         
	$("#pbarmain").show();
	$("#pbar").show();
		if(i < 100){
		i = i + 4;
		$(".progress-bar").css("width", i + "%").text(i + " %");
		setTimeout("makeProgress()", 100);
	}
	if(i == 100) {
		setTimeout( function() {
			$("#exampleModalCenter").modal("hide");
			i = 0;
			$(".progress-bar").css("width", i + "%").text(i + " %");
			return;
		}, 800)
	}
}