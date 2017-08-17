<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.col-name{
		background: #eee;
		padding: 8px 15px;
	}
	.col-content {
		border: 1px solid #eee;
		padding: 0;
		border-radius: 4px;
		margin-bottom: 10px;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>资产概览</h6>
	<h6>资源池</h6>
</div>
<div class="pool-detail">
	<div id="pool-echarts">
	</div>
</div>
<script type="text/javascript">
	var myChart = new Array();
	$(function(){
		initResourcePoolData();
		window.onresize = function(){
		    for(var i = 0; i < myChart.length; i++){
		    	myChart[i].resize();
		    }
		};
	});
	function addParentDiv(parentId,num,name) {
		var divHtml = "";
		if(num == 1 || num == 2){
			divHtml = "<div class='col-md-6 col-sm-12'><div class='col-sm-12 col-content' id='"+parentId+"'>"+
			"<div class='col-sm-12 col-name'>"+name+"</div></div></div>";
		}else if(num > 2){
			divHtml = "<div class='col-md-12 col-sm-12'><div class='col-sm-12 col-content' id='"+parentId+"'>"+
			"<div class='col-sm-12 col-name'>"+name+"</div></div></div>";
		}
		$("#pool-echarts").append(divHtml);
	}
	function addSubDiv(parentId,subId,num) {
		var divHtml = "";
		if(num == 1){
			divHtml = "<div class='col-md-12 col-sm-12' id='"+subId+"' style='height: 320px;width: 50%;left: 25%'></div></div>";
		}else if(num == 2){
			divHtml = "<div class='col-md-6 col-sm-6' id='"+subId+"' style='height: 320px;'></div></div>";
		}else if(num == 3){
			divHtml = "<div class='col-md-4 col-sm-6' id='"+subId+"' style='height: 320px;'></div></div>";
		}else if(num > 3){
			divHtml = "<div class='col-md-3 col-sm-6' id='"+subId+"' style='height: 320px;'></div></div>";
		}
		$("#"+parentId).append(divHtml);
	}
	function initResourcePoolData(){
		$.getJSON("resources/json/resourcePool.json", function (r) {
           if(r.code == 200) {
               var data = r.result.list;
               $.each(data,function(index,items){
               		var num = items.resources.length;
               		addParentDiv(items.id,num,items.name);
           			$.each(items.resources,function(i,item){
           				var subId = items.id+item.name;
           				addSubDiv(items.id,subId,num);
						var chart = initEcharts(subId, [{"value": item.used,name: item.title}], item.title, "gauge");
						myChart.push(chart);
           			});
               });
           } else {
               toastr.error(rm.msg);
           }
       });
	}

</script>