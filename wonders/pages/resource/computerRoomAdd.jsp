<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        .mar0{
            margin: 0;
        }
        .pt20{
            padding-top: 20px;
        }
        .ml30{
            margin-left: 30px;
        }
    </style>
<!-- navigate -->
    <div class="console-title console-title-border">
        <h3>机房管理</h3>
        <h5>添加</h5>
    </div>
<!--  info -->
    <div class="row mar0 ">
        <div class="aliasAndData col-xs-6">
            <div class="col-btn col-xs-12">
                <label class="col-sm-2 col-xs-2 control-label text-left"  for="monitor-btn">名称</label>
                <div class="col-sm-8 col-xs-9 col-input">
                    <input type="text" class="form-control"  id="alias">
                </div>
            </div>

            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-xs-2 control-label text-left" for="monitor-btn">所属机房</label>
                <div class="col-sm-8 col-xs-9 col-input">
                    <select class="form-control input-sm selectpicker input-group-select" id="belong">
                        <option value="">ComboBox</option>
                        <option value="1">one</option>
                        <option value="2">two</option>
                    </select>
                </div>
            </div>

        </div>

        <div class="col-btn col-xs-6 ">
            <label class="col-sm-2 col-xs-2 control-label text-right"  for="monitor-btn">备注</label>
            <div class="col-sm-8 col-xs-9 col-input">
                <textarea cols="10" rows="4" class="form-control" style="resize:none;"  id="describe"></textarea>
            </div>
        </div>
    </div>
<!--    -->
    <div class="add-operation pt20 ml30">
        <button class="btn btn-info"  id="save" onclick="saveData()">
            <span class="fa fa-floppy-o "></span>
            	保存
        </button>
        
        <button class="btn btn-primary ml30"  id="cancel" onclick="cancelData()" >
            <span class="fa fa-undo"></span>
           		 取消
        </button>
    </div>

<script>
	//初始化下拉框
	$(function(){
		$(".selectpicker").selectpicker();
	});
	
    //保存按钮
    function saveData (){
    	console.log($('#alias').val());
    	console.log($('#describe').val());
    	console.log($('#belong').val());
    	$.ajax({
				"type":"POST",
				"url":"computer-room/create",
				"data":{
						"name":$('#alias').val(),
						"remark":$('#describe').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
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
    	loadMainPage('itam-content','pages/resource/computerRoom.jsp');
    };
    
</script>
