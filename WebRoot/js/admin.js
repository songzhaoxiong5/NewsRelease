function warning(){
    		return confirm("此新闻的相关评论也将删除，确定删除么？");	
    	}
    	
    	$(document).ready(function(){
    	//变量声明
    	var $leftLinks=$("#opt_list a");//左侧链接
    	var $optArea=$("#opt_area");//页面内容主题框架
		var $msg=$("#msg");//页面消息提示区
    	
    		//点击编辑主题时执行的方法
			$leftLinks.eq(3).click(function(){
				initTopicList3();
			});
			//点击添加新闻主题时执行的方法
			$leftLinks.eq(2).click(function(){
				$optArea.load("newspages/topic_add.jsp #opt_area>*");//注意拿到所有元素及其样式的方法
			});
			//点击编辑新闻时执行的方法
			$leftLinks.eq(1).click(function(){
				initNews();
			});
    		//初始化新闻，登录时显示
			function initNews(){
				$.ajax({
					"url":"newscontrol",
					"type":"GET",
					"data":"opr=list",
					"dataType":"json",
					"success":processNewsList
				});
				//JSON对象的格式[{"topicID":topicID,"newsList":[{},{},{}]},{},{}]
						function processNewsList(data){
							var $innerContainer=$("#opt_area").empty();
							if(data.message!=undefined&&data.message.length!=0){
								$innerContainer.append("<ul class='classlist'>当前无新闻可以展示</ul>");
								
							}else{
								$innerContainer.append("<ul class='classlist'></ul>");
								var $innerContainer2=$("ul.classlist");
								for(var i=0;i<data.length;i++){//第一层循环
								if(data[i].newsList!=undefined&&data[i].newsList.length!=0){
									var $newsList=$(data[i].newsList);
									$newsList.each(function(index,element){
										$innerContainer2.append("<li>"+element.contentTitle+"<span>作者："+element.author+"&#160;&#160;&#160;&#160;<a href='newspages/news_modify.jsp?contentID="+element.contentID+"'>修改</a>&#160;&#160;&#160;&#160;<a href='news_control.jsp?opr=del&contentID="+element.contentID+"' onclick='return warning();'>删除</a></span></li>");
									});
								}
								$innerContainer2.append("<li class='space'></li>");
								}
							}
						}
			}
			
				//初始化新闻主题的方法，多个版本
			
						function initTopicList(){
							$.getJSON("topic_control.jsp","opr=showAll",processTopicList);
						}
						function initTopicList2(){
							$.ajax({
								"url":"topiccontrol",
								"type":"GET",
								"data":"opr=listHtml",
								"dataType":"html",
								"success":processTopicList2
							});
						}
						function initTopicList3(){
							var $topicArea=$("#opt_area").empty();
							$topicArea.load("topiccontrol","opr=listHtml");
						}
						
						function processTopicList(data){
							var $topicArea=$("#opt_area>ul").empty();
							for(var i=0;i<data.length;i++){
								$topicArea.append("<li>"+data[i].topicName+"<span>&#160;&#160;&#160;&#160;<a href='newspages/topic_modify.jsp?tid="+data[i].topicID+"&tName="+data[i].topicName+"&opr=modify'>修改</a> &#160;&#160;&#160;&#160; <a href='topic_control.jsp?tid="+data[i].topicID+"&opr=del'>删除</a> </span> </li>");
							}
						}
						
						function processTopicList2(data){
							var $topicArea=$("#opt_area>ul").empty();
							$topicArea.html(data);
						}
						
			
					//在增加新闻主题页面点击提交时执行的方法
					$optArea.on("click","#addTopicSubmit",function(){
						var $tname=$optArea.find("#tname");
						var tnameValue=$tname.val();
						if(tnameValue==""){
							$msg.html("请输入主题名称！").fadeIn(1000).fadeOut(5000);
							$tname.focus();
							return false;
						}
						
						$.getJSON("topiccontrol","opr=add&tname="+tnameValue,afterTopicAdd);
						function afterTopicAdd(data){
							if(data.status=="success"){
								$msg.html(data.message).fadeIn(1000).fadeOut(5000);
								$optArea.load("topiccontrol","opr=listHtml");
							}else if(data.status=="exist"){
								$msg.html(data.message).fadeIn(1000).fadeOut(5000);
								$tname.select();
								$tname.val(data.redundancy);
							}
						}
					});
					//添加主题页面的重置按钮
					function clear(){
			  			var tName=document.getElementById("tname");
			  			if(tName.value!=""){
			  			tName.value="";
			  			}
		  			}
		  			
		  			//编辑主题页面的修改按钮动态绑定事件
		  			$optArea.on("click","a.modify",function(){
		  				var topicName=$(this).attr("tName");
		  				var topicID=$(this).attr("topicID");
		  				$optArea.load("newspages/topic_modify.jsp #opt_area>*","topicName="+topicName+"&topicID="+topicID);
		  			});
		  			
					//编辑修改主题页面上的提交按钮的绑定事件
					$optArea.on("click","#modifySubmitButton",function(){
						var $tname=$optArea.find("#tname");
						var tnameValue=$tname.val();
						if(tnameValue==""){
							$msg.html("请输入主题名称！").fadeIn(1000).fadeOut(5000);
							$tname.focus();
							return false;
						}
						var topicName=$optArea.find("#tname").val();
						var topicID=$optArea.find("#tid").val();
						$.getJSON("topiccontrol","opr=modify&topicName="+topicName+"&topicID="+topicID,afterTopicUpdate);
						function afterTopicUpdate(data){
							if(data.status=="success"){
								$msg.html(data.message).fadeIn(1000).fadeOut(5000);
								$optArea.load("topiccontrol","opr=listHtml");
							}else if(data.status="exist"){
								$msg.html(data.message).fadeIn(1000).fadeOut(5000);
								$tname.select();
								$tname.val(data.redundancy);
							}
						}
					});
					//编辑主题页面的删除按钮动态绑定事件
					$optArea.on("click","a.delete",function(){
						if(confirm("确定要删除该主题吗？")){
							var topicID=$(this).attr("topicID");
							$.getJSON("topiccontrol","opr=del&tid="+topicID,afterTopicDelete);
							var $clicked=$(this);
							function afterTopicDelete(data){
							$msg.html(data.message).fadeIn(1000).fadeOut(5000);
							if(data.status=="success"){
								$clicked.parent().parent().remove();
							}
						}
						}
						
					});
			
				initNews();
			
			
			
			
			
		});