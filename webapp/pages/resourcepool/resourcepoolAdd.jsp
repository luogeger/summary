<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.no-padding{
		padding: 0;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>资源池管理</h6>
	<h6>添加</h6>
	<h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/resourcepool/resourcepoolList.jsp')">
                返回
    </h6>
</div>
<div class="row-fluid operation operation-resource">
	<div class="col-sm-12 title-content">
		<strong>基本信息：</strong>
	</div>
	<div class="col-md-9 col-sm-12">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池名称</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="poolName-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-9 col-sm-12">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池类型</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="poolType-add" class="form-control input-sm selectpicker input-group-select input-add">
            </select>
		</div>
	</div>
	<div class="col-md-9 col-sm-12">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">URL</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="poolUrl-add" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-9 col-sm-12">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池描述</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="poolRemark-add" maxlength="128" class="form-control input-add"/>
		</div>
	</div>
	<div class="configurationInfo">
	</div>
	<div class="col-sm-12 operation-btn">
		<button type="button"  data-value="submit" onclick="addPool()" class="btn btn-info btn-sm" >确定</button>
		<button type="button"  data-value="reset" onclick="cancelAdd()" class="btn btn-primary btn-sm">取消</button>
	</div>
</div>

<script>
	$(function(){
		$(".selectpicker").selectpicker();
		//资源池类型
		initSelects("mdconfig/resource/pool/type", "poolType-add", null, null, "configId", "value");
	});
	function addPool(){
		var poolName = $("#poolName-add").val();
		var poolType = $("#poolType-add").val();
		var poolUrl = $("#poolUrl-add").val();
		var poolRemark = $("#poolRemark-add").val();
		if(poolName == null || poolName == ""){
			toastr.error("请输入资源池名称");
			$("#poolName-add").focus();
			return false;
		}
		if(poolType == null || poolType == ""){
			toastr.error("请先添加资源池类型");
			return false;
		}
		if(poolUrl == null || poolUrl == ""){
			toastr.error("请输入URL");
			$("#poolUrl-add").focus();
			return false;
		}
		$.ajax({
				type: 'post',
				url: "resource-pool/create",
				data: {type: poolType, name: poolName, fetchDataUrl: poolUrl, remark: poolRemark},
				dataType: 'json',
	            success: function (data) {
	            	if(data.code==200){
	            		toastr.success("添加成功");
	            		cancelAdd();
	            	}else {
	            		toastr.error(data.msg);
					}
				},
				error : function(data) {
					toastr.error(data.msg);
				}
			}); 
	}
	function cancelAdd(){
		loadMainPage("itam-content","pages/resourcepool/resourcepoolList.jsp");
	}
	
</script>
