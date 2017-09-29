<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>厂商管理</h6>
            <h6 id="sub-title" style="display: line-block;">编辑</h6>
            <a id="return-btn" class="pull-right" type="button" style="display: inline-block;" onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');">
                <span class="icon-reply"></span>
                返回
            </a>
        </div>
        <div class="add-operation">
        	<button class="btn btn-info"><span class="fa fa-floppy-o"></span> 保存</button>
        	<button class="btn btn-primary" style="margin-left:50px;"  onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');"><span class="fa fa-undo"></span> 取消</button>
        </div>
        <div class="add-content" style="background-color:#ffffff;height:165px;margin-top:10px;">
        	<ul class="pull-left contentList">
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">厂商名称：</div>
			        <div class="col-xs-9 col-sm-8 text-right">
			            <input type="text" placeholder="品牌名称内容"/>
			        </div>
			    </li>
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">责任人：</div>
			        <div class="col-xs-9 col-sm-8 text-right" id="responsible"></div>
			    </li>
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">联系电话：</div>
			        <div class="col-xs-9 col-sm-8 text-right" id="tel"></div>
			    </li>
			</ul>
			<ul class="pull-left contentList">
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">联系邮箱：</div>
			        <div class="col-xs-9 col-sm-8 text-right">
			            <input type="text" placeholder="123@wondersgroup.com"/>
			        </div>
			    </li>
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">联系地址：</div>
			        <div class="col-xs-9 col-sm-8 text-right">
			            <input type="text" placeholder="具体联系地址"/>
			        </div>
			    </li>
			    <li>
			        <div class="col-xs-3 col-sm-4 add-label">备注：</div>
			        <div class="col-xs-9 col-sm-8 text-right">
			            <input type="text" placeholder="备注内容"/>
			        </div>
			    </li>
			</ul>
        </div>
    </div>
    <script>
    	var name= decodeURI(decodeURI("${param.templateName}"));
    	var tel = "${param.templateTel}";
    	$("#responsible").html(name);
    	$("#tel").html(tel);
    </script>