(function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};define(["backbone","handlebars","lodash","jquery","jquery.simplemodal","models/recipe","models/recipe_ingredient","models/step","collections/steps","collections/recipe_ingredients","views/recipeTimeline","views/recipeIngredients","text!templates/createRecipe.html"],function(e,n,r,i,s,o,u,a,f,l,c,h,p){var d;return d=function(e){function s(){return s.__super__.constructor.apply(this,arguments)}return t(s,e),s.prototype.events={"mouseover .editable":"highlight","mouseout .editable":"unhighlight","mouseover li.ingredient-editable":"highlight","mouseout li.ingredient-editable":"unhighlight","click #new-ingredient":"createIngredient","dblclick #ingredient-list li.ingredient-editable":"editIngredient","dblclick .editable":"edit","mouseover .contents-container .contents":"highlight","mouseout .contents-container .contents":"unhighlight","dblclick .contents-container .contents":"editStep","click .unit":"addStep","click a#favorite-recipe-button":"favorite","click a#unfavorite-recipe-button":"unfavorite"},s.prototype.initialize=function(e){var t=this;return this.template=n.compile(p),e!=null&&e.id!=null?(this.model=new o({_id:e.id}),this.model.fetch({success:function(){return t.render()}})):this.model=new o({name:"Double click here to edit the recipe name.",photo:"http://freecoloringpagesite.com/coloring-pics/blue-coloring-2.png",description:"Double click here to edit the recipe description. Additionally, you can double click any thing on this recipe to edit it.",prep_time:"0",cook_time:"0",ready_in:"0",serving_size:"0",recipe_ingredients:new l,steps:new f([new a({description:"Click here to edit this step.",start_time:0,end_time:30})])})},s.prototype.render=function(){var e=this;return this.$el.html(this.template(this.model.for_template())),i(".recipe").ready(function(){return i(".img-circle").first().css("background","url('"+e.model.attributes.photo+"')"),e.renderIngredients(),e.renderTimeline(),e.renderFormActions()})},s.prototype.renderFormActions=function(){var e=this;return i("#submit-create-recipe").on("click",function(t){return t.preventDefault(),e.saveRecipe(),!1})},s.prototype.renderIngredients=function(){var e,t=this;return console.log("Rendered Ingredients"),e=this.model.get("recipe_ingredients"),r.each(e.models,function(e){return e.set("cid",e.cid)}),this.ingredientsList=new h(e),i(".ingredient-contents").ready(function(){return i("#ingredient-list li").addClass("ingredient-editable"),i("#ingredient-list").append("<li style='list-style-type: none;'>                                      <a href='#' id='new-ingredient'>                                      + Add Ingredient</a></li>")})},s.prototype.renderTimeline=function(){var e;return e=this.model.get("steps"),e.toJSON!=null?this.timeline=new c(e.toJSON()):this.timeline=new c(e)},s.prototype.highlight=function(e){return i(e.target).hasClass("img-circle")?i(e.target).css("border-color","#ffff99"):i(e.target).css("background","#ffff99"),i(e.target).css("color","#478dff")},s.prototype.unhighlight=function(e){return i(e.target).hasClass("img-circle")?i(e.target).css("border-color","#fff"):i(e.target).css("background","none"),i(e.target).css("color","black")},s.prototype.edit=function(e){var t,n,r,s,o=this;return e.preventDefault(),s=i(e.target).attr("data-edit"),t=i(e.target).attr("data-field"),n="<form id='edit-recipe-field-form'>",r=this.model.get(t),s==="textarea"?n+="<textarea name='edit' rows=6 cols=60>"+r+"</textarea>                  <br /><br/><input type='submit' class='submit-button'>":n+="<input type='text' name='edit' value='"+r+"' size=60/>                  <br /><br /><input type='submit' class='submit-button'>",n+="</form>",i.modal(n,{onShow:function(e){return i("#edit-recipe-field-form").on("submit",function(e){return e.preventDefault(),o.model.set(t,i("input[name=edit], textarea[name=edit]").val()),i.modal.close(),o.render(),!1})}})},s.prototype.editIngredient=function(e){var t,n=this;return e.preventDefault(),t="<form id='edit-ingredient-form'>                  <p><input type='text' name='amount' placeholder='Amount'/></p>                  <p><input type='text' name='unit' placeholder='Unit'/></p>                  <p><input type='text' name='name' placeholder='Name'/></p>                  <input type='submit'>                </form>",i.modal(t,{onShow:function(t){var r,s;return s=n.model.get("recipe_ingredients"),console.log(s),r=s.getByCid(i(e.target).closest(".ingredient-editable").attr("data-cid")),i("input[name=amount]").val(r.get("amount")),i("input[name=unit]").val(r.get("unit")),i("input[name=name]").val(r.get("name")),i("#edit-ingredient-form").on("submit",function(e){return e.preventDefault(),r.set("amount",i("input[name=amount]").val()),r.set("unit",i("input[name=unit]").val()),r.set("name",i("input[name=name]").val()),i.modal.close(),n.renderIngredients(),!1})}})},s.prototype.createIngredient=function(e){var t,n=this;return e.preventDefault(),t="<form id='create-ingredient-form'>                  <p><input type='text' name='amount' placeholder='Amount'/></p>                  <p><input type='text' name='unit' placeholder='Unit'/></p>                  <p><input type='text' name='name' placeholder='Name'/></p>                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#create-ingredient-form").on("submit",function(e){var t,r,s,o,a;return e.preventDefault(),r=n.model.get("recipe_ingredients"),t=i("input[name=amount]").val(),a=i("input[name=unit]").val(),s=i("input[name=name]").val(),o=new u({amount:t,unit:a,name:s}),o.set("cid",o.cid),r.push(o),n.model.set("recipe_ingredients",r),i.modal.close(),n.renderIngredients(),!1})}}),!1},s.prototype.editStep=function(e){var t,n,r=this;return e.preventDefault(),n=i(e.target).text().trim(),t="<form id='edit-step-form'>                  <textarea name='step' rows=5 cols=40>"+n+"</textarea>                  <br />                  <br />                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#edit-step-form").on("submit",function(e){var t,s,o;return e.preventDefault(),o=r.model.get("steps"),s=o.where({description:n})[0],t=i("textarea[name='step']").val(),s.set("description",t),i.modal.close(),r.renderTimeline()})}})},s.prototype.addStep=function(e){var t,n=this;return e.preventDefault(),t="<form id='add-step-form'>                  <textarea name='description' rows=5 cols=40></textarea>                  <br />                  <p>                  <input type='text' name='start_time' placeholder='Start time'/><br />                  <input type='text' name='end_time' placeholder='End time'/><br />                  </p>                  <br />                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#add-step-form").on("submit",function(e){var t,r,s,o;return e.preventDefault(),t=i("textarea[name=description]").val(),s=i("input[name=start_time]").val(),r=i("input[name=end_time]").val(),o=n.model.get("steps"),o.push(new a({description:t,start_time:s,end_time:r})),n.model.set("steps",o),i.modal.close(),n.renderTimeline()})}})},s.prototype.saveRecipe=function(){var e,t,n=this;return e=this.model.get("recipe_collection"),t=this.model.get("steps"),this.model.save(null,{success:function(){return console.log("Saved"),n.renderIngredients()},error:function(){return console.log("Error")}})},s.prototype.favorite=function(e){var t=this;return e.preventDefault(),i.ajax({type:"POST",url:"/api/recipes/favorite/"+this.model.get("_id"),dataType:"json",data:{authenticity_token:i("meta[name='csrf-token']").attr("content")},success:function(){return i("#favorite-recipe-button").text("Unfavorite").attr("id","unfavorite-recipe-button"),t.model.set("is_favorited_by_user?",!0)},error:function(){return alert("Error!")}}),!1},s.prototype.unfavorite=function(e){var t=this;return e.preventDefault(),i.ajax({type:"POST",url:"/api/recipes/unfavorite/"+this.model.get("_id"),dataType:"json",data:{authenticity_token:i("meta[name='csrf-token']").attr("content")},success:function(){return i("#unfavorite-recipe-button").text("Favorite").attr("id","favorite-recipe-button"),t.model.set("is_favorited_by_user?",!1)},error:function(){return alert("Error!")}}),!1},s}(e.View)})}).call(this);