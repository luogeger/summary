<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        .m0{
            margin:0px;
        }
        .p0{
        	padding: 0px;
        }
        
    </style>
<!-- navigate -->
    <div class="console-title console-title-border">
        <h3>机房管理</h3>
        <h5 id="nav_alias"></h5>
        <h5>详情</h5>
        <a id="return-btn" class="pull-right" type="button" style="display: inline-block; text-decoration: none;" 
        	onclick="loadMainPage('itam-content','pages/resource/computerRoom.jsp');">
                <span class="icon-reply"></span>
                返回
            </a>
    </div>
<!-- operation -->
    <div class="add-operation">
        <button class="btn btn-info edit">
            <span class="fa fa-edit"></span>
            编辑
        </button>
        <button class="btn btn-info save hidden">
            <span class="fa fa-floppy-o "></span>
            保存
        </button>
        <button class="btn btn-primary cancel hidden" style="margin-left:30px;" >
            <span class="fa fa-undo"></span>
            取消
        </button>
    </div>
<!-- info -->
    <div class="row m0">
        <div class="col-btn col-xs-12">
            <label class="col-sm-1 col-xs-2 control-label text-left" for="monitor-btn">名称</label>
            <div class="col-sm-5 col-xs-7 col-input">
                <input type="text" class="form-control" id="alias"  disabled>
            </div>
            <div class="col-sm-7 col-xs-3"></div>
        </div>

        <div class="col-btn col-xs-12">
            <label class="col-sm-1 col-xs-2 control-label text-left" for="monitor-btn">备注</label>
            <div class="col-sm-5 col-xs-7 col-input">
                <textarea cols="10" rows="4" class="form-control" style="resize:none;"  id="remark" disabled ></textarea>
            </div>
            <div class="col-sm-7 col-xs-3"></div>
        </div>
    </div>
<!-- 详情表格 -->
    <div class="col-btn col-xs-12 ">
        <label class="col-xs-2 col-sm-1 control-label text-left p0" for="monitor-btn">机房:</label>
        <div class="col-xs-10 col-sm-11"  style="padding-left: 0px;">
            <table id="model-table" class="table table-hover no-footer dataTable">
                <thead class="the-box dark full">
                <tr>
                    <th class="sorting_disabled">机房名称</th>
                    <th class="sorting_disabled">备注</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

<script>
    $(function (){
		var computerRoomId = "${param.computerRoomId}";//获取详情页信息
        var editBtn = $('.add-operation .edit');//编辑按钮
        var saveBtn = $('.add-operation .save');//保存按钮
        var cancelBtn = $('.add-operation .cancel');//取消按钮
        var arrHide = [editBtn, saveBtn, cancelBtn];//按钮显示隐藏数组
		
	//详情页数据渲染
	dataDetail();
   	function dataDetail(obj){
   		$.ajax({
   			"type":"GET",
   			"url":"computer-room/detail",
   			"data":{"computerRoomId":computerRoomId},
   			"dataType":"json",
   			"success":function(resp){
   				if(resp.code == "200"){
   					var obj = resp.result.computerRoom;
   					$('#alias').val(obj.name);
   					$('#remark').val(obj.remark);
   					$('#nav_alias').text(obj.name);
   				}else{
   					toastr.warning(resp.msg);
   				}
   			},
   			"error":function(resp){
   				toastr.error("请求失败！");
   			}
   		
   		});
   	}
	
	//--初始化表格
	$(function () {
       initDataTable();
    });
    function initDataTable() {
        $("#model-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "computer-room/page",
            "fnServerData": retrieveData, //与后台交互获取数据的处理函数
            "paging":false,
            "bInfo":false,
            "language":{
                'sEmptyTable':'没有相关记录',
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
    //--异步获取
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
		
		
		//编辑按钮
        editBtn.dblclick(function (){
            hideshow(arrHide);
            $('input').attr("disabled",false);
            $('textarea').attr("disabled",false);
        });
        
        //保存按钮
        saveBtn.on('click', function () {
            hideshow(arrHide);
            $.ajax({
				"type":"POST",
				"url":"computer-room/update",
				"data":{"computerRoomId":computerRoomId,
						"name":$('#alias').val(),
						"remark":$('#remark').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						toastr.success(resp.msg);
						$('input').attr("disabled",true);
			            $('textarea').attr("disabled",true);
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
        
        //取消按钮
        cancelBtn.on('click', function () {
            hideshow(arrHide);
            $('input').attr("disabled",true);
            $('textarea').attr("disabled",true);
            dataDetail();
        });

        //按钮显示隐藏
        function hideshow (arr){
            var i, len = arr.length;
            for(i = 0; i < len; i++){
                arr[i].toggleClass('hidden');
            }
        };
    })
    
</script>





