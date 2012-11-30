(function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};define(["backbone","handlebars","lodash","jquery","simplemodal","models/recipe","models/recipe_ingredient","models/step","collections/steps","collections/recipe_ingredients","views/recipeTimeline","views/recipeIngredients","text!templates/createRecipe.html"],function(e,n,r,i,s,o,u,a,f,l,c,h,p){var d;return d=function(e){function r(){return r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype.events={"dblclick .editable":"edit","mouseover .editable":"highlight","mouseout .editable":"unhighlight","click #new-ingredient":"createIngredient","mouseover .contents-container .contents":"highlight","mouseout .contents-container .contents":"unhighlight","dblclick .contents-container .contents":"editStep","click .unit":"addStep"},r.prototype.initialize=function(e){return this.template=n.compile(p),this.model=new o({name:"Double click here to edit the recipe name.",photo:"http://freecoloringpagesite.com/coloring-pics/blue-coloring-2.png",description:"Double click here to edit the recipe description. Additionally, you can double click any thing on this recipe to edit it.",prep_time:"0",cook_time:"0",ready_in:"0",serving_size:"0",recipe_ingredients:new l,steps:new f([new a({description:"Click here to edit this step.",start_time:0,end_time:30})])})},r.prototype.render=function(){var e=this;return this.$el.html(this.template(this.model.for_template())),i(".recipe").ready(function(){return i(".img-circle").first().css("background","url('"+e.model.attributes.photo+"')"),e.renderIngredients(),e.renderTimeline(),e.renderFormActions()})},r.prototype.renderFormActions=function(){var e=this;return i("section.container").prepend("<div id='form-actions'>          <a href='#' id='submit-create-recipe'>Save Recipe</a>        </div>"),i("#submit-create-recipe").ready(function(){return i("#submit-create-recipe").on("click",function(t){return t.preventDefault(),e.saveRecipe(),!1})})},r.prototype.renderIngredients=function(){var e=this;return this.ingredientsList=new h(this.model.get("recipe_ingredients")),console.log(this.ingredientsList),i(".ingredient-contents").ready(function(){return i("#ingredient-list li").addClass("editable"),i("#ingredient-list li").addClass("ingredient"),i("#ingredient-list").append("<li style='list-style-type: none;'>                                      <a href='#' id='new-ingredient'>                                      + Add Ingredient</a></li>")})},r.prototype.renderTimeline=function(){var e;return e=this.model.get("steps").toJSON(),this.timeline=new c(e)},r.prototype.highlight=function(e){return i(e.target).hasClass("img-circle")?i(e.target).css("border-color","#ffff99"):i(e.target).css("background","#ffff99"),i(e.target).css("color","#478dff")},r.prototype.unhighlight=function(e){return i(e.target).hasClass("img-circle")?i(e.target).css("border-color","#fff"):i(e.target).css("background","none"),i(e.target).css("color","black")},r.prototype.edit=function(e){var t,n,r,s,o=this;return e.preventDefault(),s=i(e.target).attr("data-edit"),t=i(e.target).attr("data-field"),n="<form id='edit-recipe-field-form'>",r=this.model.get(t),s==="textarea"?n+="<textarea name='edit' rows=6 cols=60>"+r+"</textarea>                  <br /><br/><input type='submit' class='submit-button'>":n+="<input type='text' name='edit' value='"+r+"' size=60/>                  <br /><br /><input type='submit' class='submit-button'>",n+="</form>",i.modal(n,{onShow:function(e){return i("#edit-recipe-field-form").on("submit",function(e){return e.preventDefault(),o.model.set(t,i("input[name=edit], textarea[name=edit]").val()),i.modal.close(),o.render(),!1})}})},r.prototype.createIngredient=function(e){var t,n=this;return e.preventDefault(),t="<form id='create-ingredient-form'>                  <p><input type='text' name='amount' placeholder='Amount'/></p>                  <p><input type='text' name='unit' placeholder='Unit'/></p>                  <p><input type='text' name='name' placeholder='Name'/></p>                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#create-ingredient-form").on("submit",function(e){var t,r,s,o,a;return e.preventDefault(),r=n.model.get("recipe_ingredients"),t=i("input[name=amount]").val(),a=i("input[name=unit]").val(),s=i("input[name=name]").val(),o=new u({amount:t,unit:a,name:s}),o.set("cid",o.cid),r.push(o),n.model.set("recipe_ingredients",r),i.modal.close(),n.renderIngredients(),!1})}}),!1},r.prototype.editIngredient=function(e){var t;return e.preventDefault(),t="<form id='create-ingredient-form'>                  <p><input type='text' name='amount' placeholder='Amount'/></p>                  <p><input type='text' name='unit' placeholder='Unit'/></p>                  <p><input type='text' name='name' placeholder='Name'/></p>                  <input type='submit'>                </form>"},r.prototype.editStep=function(e){var t,n,r=this;return e.preventDefault(),n=i(e.target).text().trim(),t="<form id='edit-step-form'>                  <textarea name='step' rows=5 cols=40>"+n+"</textarea>                  <br />                  <br />                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#edit-step-form").on("submit",function(e){var t,s,o;return e.preventDefault(),o=r.model.get("steps"),s=o.where({description:n})[0],t=i("textarea[name='step']").val(),s.set("description",t),i.modal.close(),r.renderTimeline()})}})},r.prototype.addStep=function(e){var t,n=this;return e.preventDefault(),t="<form id='add-step-form'>                  <textarea name='description' rows=5 cols=40></textarea>                  <br />                  <p>                  <input type='text' name='start_time' placeholder='Start time'/><br />                  <input type='text' name='end_time' placeholder='End time'/><br />                  </p>                  <br />                  <input type='submit'>                </form>",i.modal(t,{onShow:function(e){return i("#add-step-form").on("submit",function(e){var t,r,s,o;return e.preventDefault(),t=i("textarea[name=description]").val(),s=i("input[name=start_time]").val(),r=i("input[name=end_time]").val(),o=n.model.get("steps"),o.push(new a({description:t,start_time:s,end_time:r})),n.model.set("steps",o),i.modal.close(),n.renderTimeline()})}})},r.prototype.saveRecipe=function(){return this.model.save()},r}(e.View)})}).call(this);