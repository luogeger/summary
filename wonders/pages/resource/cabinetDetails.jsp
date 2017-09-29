<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        .m0{
            margin: 0;
        }
    </style>

<!--  navigate  -->
    <div class="console-title console-title-border">
        <h6>资产管理系统</h6>
        <h6 id="nav_name"></h6>
        <h6 id="nav_det">详情</h6>
        <a id="return-btn" class="pull-right" type="button" style="text-decoration: none" onclick="loadMainPage('itam-content','pages/resource/cabinet.jsp')">
        <span class="icon-reply"></span>
        	返回
    </a>
    </div>
	
<!-- operation -->
    <div class="add-operation">
     	<button class="btn btn-default btn-sm" id="edit"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
		<button class="btn btn-default btn-sm hidden" id="save"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
		<button class="btn btn-default btn-sm hidden" id="cancel"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
    </div>

<!--  info  -->
<!--  <div class="row-fluid operation" id="operation">
	<div class="col-md-6 col-sm-6">
		<input type="hidden" id="networkDeviceId-edit"/>
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">机柜编码</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="cabinetNum" maxlength="64" class="form-control input-add" readonly="readonly"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="vendor" class="form-control selectpicker input-group-select" disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="model" class="form-control selectpicker input-group-select" disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">总U位</label>
		<div class="col-md-9 col-sm-8 col">
            <input type="text" id="units" maxlength="64" class="form-control input-add" readonly="readonly"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="dataCenter" class="form-control selectpicker input-group-select" disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所属机房</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="comRoom" class="form-control selectpicker input-group-select" disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn" style="height: 60px;">备注</label>
		<div class="col-md-9 col-sm-8 col">
			<textarea id="remark" cols="10" rows="2" class="form-control  input-add" style="resize:none;" disabled="disabled"></textarea>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
	</div>
</div> -->

<!--  info  -->
<div class="row-fluid operation"  id="operation">
	<div class="col-md-6 col-sm-6">
		<input type="hidden" id="networkDeviceId-edit"/>
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">机柜编码</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="cabinetNum" maxlength="64" class="form-control input-add" readonly="true"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="vendor" class="form-control selectpicker input-group-select"  disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="model" class="form-control selectpicker input-group-select"  disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">总U位</label>
		<div class="col-md-9 col-sm-8 col">
            <input type="text" id="units"  maxlength="64" class="form-control input-add" readonly="true"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="dataCenter" class="form-control selectpicker input-group-select"  disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所属机房</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="comRoom" class="form-control selectpicker input-group-select"  disabled="disabled"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn" >备注</label>
		<div class="col-md-9 col-sm-8 col">
			<input id="remark" class="form-control input-add" style="resize:none;" readonly="true">
		</div>
	</div>
	
</div>


<!-- 详情表格 -->
    <div class="col-btn col-xs-12 ">
        <!-- <label class="col-xs-2 col-sm-1 control-label text-left" for="monitor-btn">关联设备</label> -->
        <div class="col-sm-12"  style="padding-left: 0px;">
            <table id="model-table" class="table table-hover no-footer dataTable">
                <thead class="the-box dark full">
                <tr>
                    <th class="sorting_disabled">设备名称</th>
                    <th class="sorting_disabled">类型</th>
                    <th class="sorting_disabled">机柜描述</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    
    
<script>
	//初始化
	$(function(){
		$(".selectpicker").selectpicker({
			dropuAuto : false
		});
	});
	
	// 厂商 - 型号 - 数据中心 - 所属机房 -->下拉框初始化
	initSelects('manufacturer/list', "vendor", {}, null ,"manufacturerId", "name");//厂商
	initSelects('model/list', "model", {}, null ,"modelId", "name");//型号
	initSelects('data-center/list', "dataCenter", {}, null ,"dataCenterId", "name");//数据中心
	initSelects('computer-room/list', "comRoom", {}, null ,"computerRoomId", "name");//所属机房
	
	//编辑，保存，取消--事件
    $(function (){
    	var nav_det = $('#nav_det');//详情、编辑切换
        var editBtn = $('#edit');//编辑
        var saveBtn = $('#save');//保存
        var cancelBtn = $('#cancel');//取消
        var arrHide = [editBtn, saveBtn, cancelBtn];//按钮显示隐藏数组
		
		//编辑
		editBtn.on('click', function(){
			$('#operation').addClass("operation-resource");
			$(".selectpicker").selectpicker("refresh");
			$("#operation input").attr("readonly",false);
			$("#operation select").attr("disabled",false);
			$("#operation textarea").attr("disabled",false);
			hideshow(arrHide);
			nav_det.text('编辑');
			
			
		});
		
		//保存
		saveBtn.on('click', function(){
			hideshow(arrHide);
			nav_det.text('详情');
			$.ajax({
				"type":"POST",
				"url":"cabinet/update",
				"data":{"cabinetId":cabinetId,
						"cabinetId": $('#cabinetNum').val(),
						"manufacturerId": $('#vendor').val(),
						"modelId": $('#model').val(),
						"units": $('#units').val(),
						"name": $('#dataCenter').val(),
						"computerRoomId": $('#comRoom').val(),
						"remark": $('#remark').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						toastr.success(resp.msg);
						$('#operation').removeClass("operation-resource");
						$(".selectpicker").selectpicker("refresh");
						$("#operation input").attr("readonly",true);
						$("#operation select").attr("disabled",true);
						$("#operation textarea").attr("disabled",true);
			    		dataDetail();
			    		initDataTable();
					}else{
						toastr.error(resp.msg);
					}
				},
				"error":function(resp){
					toastr.error("请求失败！");
				}
			});
		});
		
		//取消
		cancelBtn.on('click', function(){
			$('#operation').removeClass("operation-resource");
			$(".selectpicker").selectpicker("refresh");
			$("#operation input").attr("readonly",true);
			$("#operation select").attr("disabled","disabled");
			$("#operation textarea").attr("disabled",true);
			hideshow(arrHide);
			nav_det.text('详情');
			dataDetail();
			
			
		});
		

        //按钮显示隐藏
        function hideshow (arr){
            var i, len = arr.length;
            for(i = 0; i < len; i++){
                arr[i].toggleClass('hidden');
            }
        };
    });
    
    //初始化页面详情
    var cabinetId = "${param.cabinetId}";
    dataDetail();
    function dataDetail(obj){
   		$.ajax({
   			"type":"GET",
   			"url":"cabinet/detail",
   			"data":{"cabinetId":cabinetId},
   			"dataType":"json",
   			"success":function(resp){
   				if(resp.code == "200"){
   					var obj = resp.result.cabinet;
   					$('#nav_name').text(obj.name);
   					$('#cabinetNum').val(obj.cabinetId);
   					$('#vendor').val(obj.manufacturerId);
   					$('#model').val(obj.modelId);
   					$('#units').val(obj.units);
   					$('#dataCenter').val(obj.cabinetId);//不清楚是哪个字段
   					$('#comRoom').val(obj.computerRoomId);
   					$('#remark').val(obj.remark);
   				}else{
   					toastr.warning(resp.msg);
   				}
   			},
   			"error":function(resp){
   				toastr.error("dataDetail请求失败！");
   			}
   		
   		});
   	}

    //初始化表格
    $(function () {
        initDataTable();
    });
    function initDataTable() {
        $("#model-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "cabinet/page",
            "fnServerData": retrieveData, //与后台交互获取数据的处理函数
            "paging":false,
            "bInfo":false,
            "select": {
                style: 'multi',
                selector: 'td:first-child'
            },
            "aoColumns": [
                {
                    "mData": "name",
                    "sWidth":"30%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
                , {
                    "mData": "remark",
                    "sWidth":"20%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }

                , {
                    "mData": "usedUnit",
                    "sWidth":"50%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
            ],
        });
        $("#model-table").dataTable(temp);
    }

    //异步获取
    function retrieveData(sSource, aoData, fnCallback) {
        var row; //默认一次加载10条
        var start; //从第几条开始
        $.each(eval(aoData), function (i, field) {//转换为json对象
            if (field.name == "iDisplayStart") {
                start = field.value;
            }
            if (field.name == "iDisplayLength") {
                row = field.value;
            }
        });

        var query = {
            page: conversionPages(start, row),
            rows: row
        };
        $.getJSON(sSource, query, function (rm) {
            if (rm.code == 200) {
                var data = rm.result.pageInfo;
                data.iTotalRecords = rm.result.pageInfo.total;
                data.iTotalDisplayRecords = rm.result.pageInfo.total;
                fnCallback(data);
            } else {
                toastr.error(resp.msg);
            }
        });
    }

</script>















