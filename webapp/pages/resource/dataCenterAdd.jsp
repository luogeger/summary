<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        
    </style>
<!-- navigate -->
    <div class="console-title console-title-border">
        <h6>资产管理系统</h6>
        <h6>资源管理</h6>
        <h6>数据中心</h6>
        <h6 id="sub-title" >添加</h6>
        <a id="return-btn" class="pull-right" type="button" onclick="loadMainPage('itam-content','pages/resource/dataCenterList.jsp');" style="text-decoration: none;">
            <span class="icon-reply"></span>
            返回
        </a>
    </div>

<!-- content -->
<div class="row" style="margin: 0px;">
    <div class="col-xs-12 col-sm-12 col-md-6 ">
    	<!--  名称  -->
        <div class="col-btn col-xs-12">
            <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn">名称</label>
            <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                <input type="text" class="form-control" id="alias">
            </div>
            <div class="col-xs-4 col-sm-5 col-md-3 "></div>
        </div>
        <!--  国家  -->
        <div class="col-btn col-xs-12">
            <label class="col-xs-1 col-sm-1 col-md-1 control-label" style="text-align: center;" for="monitor-btn">国家</label>
            <!-- 下拉框 -->
            <div class="col-xs-5 col-sm-4 col-md-6 col-input">
                <select  class="form-control input-sm selectpicker input-group-select" id="nation">
                    <option value="0">ComboBox</option>
                    <option value="1">中国</option>
                    <option value="2">新加坡</option>
                </select>
            </div>
            <!-- 空栏 -->
			<div class="col-xs-4 col-sm-5 col-md-3 "></div>
        </div>
        <!--  城市  -->
        <div class="col-btn col-xs-12">
            <label class="col-xs-1 col-sm-1 col-md-1 control-label" style="text-align: center;" for="monitor-btn">城市</label>
            <!--  下拉框  -->
            <div class="col-xs-5 col-sm-4 col-md-6 col-input ">
                <select  class="form-control input-sm selectpicker input-group-select" id="city">
                    <option value="0">ComboBox</option>
                    <option value="1">上海</option>
                    <option value="2">广州</option>
                </select>
            </div>
            <!--  空栏 -->
            <div class="col-xs-4 col-sm-5 col-md-3 "></div>
        </div>
        <!--  地址  -->
        <div class="col-btn col-xs-12">
            <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn">地址</label>
            <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                <textarea cols="10" rows="4" class="form-control" style="resize:none;" id="address"></textarea>
            </div>
        </div>
        <!--  描述  -->
        <div class="col-btn col-xs-12">
            <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn">描述</label>
            <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                <textarea cols="10" rows="4" class="form-control" style="resize:none;" id="describe"></textarea>
            </div>
        </div>
    </div>

</div><!--  content end  -->

<!-- button -->
    <div class="operationBtn ">
        <button type="reset" class="btn btn-info btn-sm" onclick="saveData()" id="save">保存</button>
        <button type="reset" class="btn btn-default btn-sm" onclick="cancelData()" id="cancel">取消</button>
    </div>
   
<script>
	//初始化下拉框
	$(function(){
		$(".selectpicker").selectpicker();
	
	});
	//保存按钮
	function saveData (){
		$.ajax({
				"type":"POST",
				"url":"data-center/create",
				"data":{
						"name": $('#alias').val(),
						"country": $('#nation').val(),
						"city": $('#city').val(),
						"address": $('#address').val(),
						"remark": $('#describe').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						$('#alias').val('');
					    $('#nation').val('0');
					    $('#city').val('0');
					    $('#address').val('');
					    $('#describe').val('');	
					    toastr.success(resp.msg);
					}else{
						toastr.error(resp.msg);
					}
				},
				"error":function(resp){
					toastr.error("请求失败！");
				}
			});
	};
	//取消按钮
	function cancelData (){
		loadMainPage('itam-content','pages/resource/dataCenterList.jsp');
	};
</script>
 
